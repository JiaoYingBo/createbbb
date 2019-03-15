//
//  RunViewController.m
//  GraduateProj
//
//  Created by 焦英博 on 2019/3/10.
//  Copyright © 2019 mlg. All rights reserved.
//

#import "RunViewController.h"
#import "RunResultController.h"
#import "MyAnnotation.h"
#import "RunNavView.h"
#import "RunControlView.h"
#import "CircleSpreadTransition.h"
#import "CountDownView.h"
#import <BaiduMapAPI_Base/BMKTypes.h>
#import <BaiduMapAPI_Map/BMKCircle.h>
#import <BaiduMapAPI_Map/BMKCircleView.h>
#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapAPI_Map/BMKPolyline.h>
#import <BaiduMapAPI_Map/BMKPinAnnotationView.h>
#import <BaiduMapAPI_Map/BMKPolylineView.h>
#import <BaiduMapAPI_Map/BMKPointAnnotation.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>//引入定位功能所有的头文件

#define Map_Height 230.f

@interface RunViewController ()<BMKMapViewDelegate, BMKLocationServiceDelegate, UIViewControllerTransitioningDelegate, RunControlViewDelegate>

/** 百度地图 */
@property (nonatomic,weak)  BMKMapView *mapView;
/** 定位服务 */
@property (nonatomic,strong) BMKLocationService *locationService;
/** 点 */
@property (nonatomic,strong) BMKPointAnnotation *pointAnnotation;
@property (nonatomic, assign) UIStatusBarStyle statusBarStyleRecord;
// 是否点击了“隐藏”处于隐藏状态，隐藏状态下该控制器不可置nil
@property (nonatomic, assign) BOOL isHideMode;
@property (nonatomic, weak) RunControlView *controlView;
@property (nonatomic, strong) NSTimer *timer;
// 是否开始跑步
@property (nonatomic, assign) BOOL didStartRun;

@end

@implementation RunViewController {
    NSMutableArray *lineArray;
    CLLocationDistance _totalDistance;
}

/**
 关于自定义转场动画：
 
 先说说在实现non-interactive动画时，遇到的问题。
 
 在写demo时，用了controller.modalPresentationStyle = UIModalPresentationCustom;  就无法在- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext函数中通过toViewController.frame 获得 frame了，全是0，开始想不通，后来发现，之所以不用UIModalPresentationCustom时，可以获得frame，是因为系统通过modalPresentationStylez为toViewController.frame设定了初始值，而用了UIModalPresentationCustom，系统就不管toViewController.frame的初始化了，自然要自己指定frame了！这也才是custom的意义，自定义弹出开始和结束时的frame。另外还有一个问题，如果使用了controller.modalPresentationStyle = UIModalPresentationCustom，并且屏幕经过了旋转90度，transitionContext的containerView的坐标系并不会一起旋转，结果就是，先旋转，再present出controller，那么controller的frame就错了。
 
 但是如果不使用UIModalPresentationCustom，而使用其他的style(在ipad上测试)，同时使用自定义动画，要么会产生视图bug（UIModalPresentationFormSheet和UIModalPresentationPageSheet），要么还是像以前一样，会把原来controller的view从hierarchy上移掉(UIModalPresentationFullScreen，UIModalPresentationNone)！就达不到同时现实2个controller的view的效果了。如果仅仅想更改动画效果，不需要2个controller同时出现，那么不应该使用UIModalPresentationCustom。如果使用了UIModalPresentationCustom，那么就需要针对屏幕的各个方向，调整自定义动画的start frame 和 end frame。比如需要支持4个方向，那么就需要4组start frame 和 end frame，这样才能达到不同方向，相同的弹出效果。（摘自https://www.cnblogs.com/breezemist/p/3460497.html）
 
 简单说就是使用UIModalPresentationCustom模式时，fromVC不会消失
 */
- (instancetype)init {
    self = [super init];
    if (self) {
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
        _totalDistance = 0;
        _didStartRun = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self bmkMapConfig];
    [self bmkServiceConfig];
    [self configUI];
}

- (void)bmkMapConfig {
    BMKMapView *mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, Map_Height)];
    mapView.zoomLevel = 17;
    mapView.overlookEnabled = NO;
    mapView.showsUserLocation = YES;
    mapView.mapType = BMKMapTypeStandard;
    mapView.logoPosition = BMKLogoPositionRightBottom;
    mapView.userTrackingMode = BMKUserTrackingModeNone;
    _mapView = mapView;
    [self.view addSubview:_mapView];
}

- (void)bmkServiceConfig {
    BMKLocationService *locationService = [[BMKLocationService alloc] init];
    locationService.delegate = self;
    [locationService startUserLocationService];
    _locationService = locationService;
    BMKPointAnnotation *point = [[BMKPointAnnotation alloc] init];
    _pointAnnotation = point;
}

- (void)configUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    RunNavView *navView = [[RunNavView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    [self.view addSubview:navView];
    __weak typeof(self)weakSelf = self;
    navView.leftBtnClick = ^{
        // 点击“隐藏”按钮时设为YES
        weakSelf.isHideMode = YES;
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    };
    
    RunControlView *controlView = [[RunControlView alloc] initWithFrame:CGRectMake(0, 64 + Map_Height, kScreenWidth, kScreenHeight - 64 - Map_Height)];
    controlView.delegate = self;
    [self.view addSubview:controlView];
    self.controlView = controlView;
}

#pragma mark - BMKMapViewDelegate
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation {
    MyAnnotation *annotationView = (MyAnnotation*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"RunAnnotation"];
    if (annotationView == nil) {
        annotationView = [[MyAnnotation alloc] initWithAnnotation:annotation reuseIdentifier:@"RunAnnotation"];
    }
    return annotationView;
}

- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id<BMKOverlay>)overlay {
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView *overlayView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        overlayView.lineWidth = 3;
        overlayView.isFocus = NO;
        overlayView.strokeColor = [UIColor colorWithRed:0.167 green:0.840 blue:0.043 alpha:1];
        return overlayView;
    }
    
    if ([overlay isKindOfClass:[BMKCircle class]]) {
        BMKCircleView *circleView = [[BMKCircleView alloc] initWithCircle:overlay];
        circleView.fillColor = [UIColor colorWithRed:0.989 green:0.417 blue:0.057 alpha:0.328];
        circleView.strokeColor = [UIColor colorWithRed:0.989 green:0.417 blue:0.057 alpha:0.879];
        circleView.lineWidth = 0;
        return circleView;
    }
    
    return nil;
}

#pragma mark - BMKLocationServiceDelegate
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    // 设置地图中心为用户经纬度
    [_mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
    [self setAnnotationWithLocation:userLocation];
    
    if (self.didStartRun) {
        [self setMapLineWithLocation:userLocation];
        NSLog(@"速度：%.f m/s  %.fkm/h", userLocation.location.speed, userLocation.location.speed*3.6);
    }
}

/**
 *  设置地图的标注
 */
- (void)setAnnotationWithLocation:(BMKUserLocation*)userLocation {
    if (userLocation.location == nil) {
        return;
    }
    // 方向度数，0为正北方
    double dir = userLocation.location.course;
    // 单位m/s
    CLLocationSpeed speed = userLocation.location.speed;
    _pointAnnotation.title = [NSString stringWithFormat:@"我(精确度:%.0f m)",userLocation.location.horizontalAccuracy];
    _pointAnnotation.subtitle = [NSString stringWithFormat:@"时速:%0.1fKm/h",(speed<0? 0:speed) * 3.6f];
    _pointAnnotation.coordinate = userLocation.location.coordinate;
    if (![_mapView.annotations containsObject:_pointAnnotation]) {
        [_mapView addAnnotation:_pointAnnotation];
        [_mapView selectAnnotation:_pointAnnotation animated:YES];
    }
    
    //误差范围指示器
    static BMKCircle *circle;
    if (circle == nil) {
        circle = [BMKCircle circleWithCenterCoordinate:userLocation.location.coordinate radius:userLocation.location.horizontalAccuracy];
        [_mapView addOverlay:circle];
    } else {
        circle.radius = 10;//userLocation.location.horizontalAccuracy;
        circle.coordinate = userLocation.location.coordinate;
    }
    
    //设置方向角度
    MyAnnotation *annotationView = (MyAnnotation*)[_mapView viewForAnnotation:_pointAnnotation];
    if (![annotationView isKindOfClass:[MyAnnotation class]]) {
        return;
    }
    annotationView.bgImage.transform = CGAffineTransformMakeRotation((dir + 90 - _mapView.rotation) * M_PI / 180);
}
/**
 *  设置运动轨迹地图路径
 */
- (void)setMapLineWithLocation:(BMKUserLocation*)userLocation {
    if (userLocation.location == nil) {
        return;
    }
    /*
     horizontalAccuracy的单位是米，代表当前GPS信号精确到了多少米，越接近于0定位就越准确，GPS信号也就越强，当horizontalAccuracy为负数时，当前为没有GPS信号，所以一般情况下参考horizontalAccuracy就可以向用户展示当前的信号强度
     */
    // 突然大于15可能是GPS信号弱定位漂移了，忽略
    if (userLocation.location.horizontalAccuracy > 15) {
        return;
    }
    
    if (lineArray == nil) {
        lineArray = [NSMutableArray new];
        return;
    }
    
    CLLocation *last = lineArray.lastObject;
    CLLocationDistance distance = [userLocation.location distanceFromLocation:last];
    // 经纬度没变或者距离小于4
    if ((last.coordinate.longitude == userLocation.location.coordinate.longitude &&
         last.coordinate.latitude == userLocation.location.coordinate.latitude) ||
        (distance < 4 && lineArray.count != 0)) {
        // 此时不绘制路线，但要更新页面数据
        NSLog(@"不绘制路线，但刷新数据");
        [self updateControlViewWithBMKUserLocation:userLocation];
        return;
    }
    [lineArray addObject:userLocation.location];
    
    // 更新ControlView上的数据
    _totalDistance += distance;
    NSLog(@"又绘制，又刷新");
    [self updateControlViewWithBMKUserLocation:userLocation];
    
    CLLocationCoordinate2D *coords = new CLLocationCoordinate2D[lineArray.count];
    for (int i = 0; i < lineArray.count; i++) {
        CLLocation *loc = lineArray[i];
        coords[i] = loc.coordinate;
    }
    
    if (lineArray.count <= 1) {
        return;
    }
    static BMKPolyline *line;
    if (line == nil) {
        line = [BMKPolyline polylineWithCoordinates:coords count:lineArray.count];
        [_mapView addOverlay:line];
    } else {
        [line setPolylineWithCoordinates:coords count:lineArray.count];
    }
}
// 已知体重、距离 跑步热量（kcal）＝体重（kg）×距离（公里）×1.036 例如：体重60公斤的人，长跑8公里，那么消耗的热量＝60×8×1.036＝497.28 kcal(千卡)
- (void)updateControlViewWithBMKUserLocation:(BMKUserLocation *)userLocation {
    // 刚开始定位的时候会出现负数，忽略
    if (_totalDistance < 0 || userLocation.location.speed < 0) {
        return;
    }
    NSString *discante = [NSString stringWithFormat:@"%.2f", _totalDistance/1000];
    NSString *speed = [NSString stringWithFormat:@"%.f", userLocation.location.speed*3.6];
    NSString *calorie = [NSString stringWithFormat:@"%.f", 60*_totalDistance/1000*1.036];
    [self.controlView updateDistance:discante speed:speed calorie:calorie];
}

#pragma mark - RunControlView Delegate
- (void)runControlViewDidStart:(RunControlView *)controlView {
    __weak typeof(self)weakSelf = self;
    CountDownView *countDown = [[CountDownView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [countDown showWithDismissCompletion:^{
        // 倒计时结束再开始计时和绘制路线
        [controlView timeStart];
        weakSelf.didStartRun = YES;
    }];
}

- (void)runControlViewDidEnd:(RunControlView *)controlView {
    self.didStartRun = NO;
    [self.locationService stopUserLocationService];
    RunResultController *resultVC = [[RunResultController alloc] init];
    [self presentViewController:resultVC animated:YES completion:nil];
}

#pragma mark - 转场动画
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [CircleSpreadTransition transitionWithTransitionType:XWCircleSpreadTransitionTypePresent];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    if (self.isHideMode) {
        return [CircleSpreadTransition transitionWithTransitionType:XWCircleSpreadTransitionTypeDismiss];
    }
    return [CircleSpreadTransition transitionWithTransitionType:XWCircleSpreadTransitionTypeNormal];
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    return nil;
}

#pragma mark - 生命周期函数

- (void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self;
    _locationService.delegate = self;
    // 每次进入此页面就初始化为NO
    self.isHideMode = NO;
    
    /**
     参考 https://www.jianshu.com/p/25e9c1a864be
     1、修改工程Targets-General里的选项，让plist里多出一个status bar style
     2、plist里添加View controller-based status bar appearance为NO
     3、基类里添加[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
     4、需要变颜色的类里单独改颜色。
     */
    self.statusBarStyleRecord = [UIApplication sharedApplication].statusBarStyle;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
    _locationService.delegate = nil;
    lineArray = nil;
    
    [UIApplication sharedApplication].statusBarStyle = self.statusBarStyleRecord;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [_locationService stopUserLocationService];
    [lineArray removeAllObjects];
    [_locationService startUserLocationService];
}

#pragma mark - 内存泄漏!!!!!!!!!!!!!!!!! 应该是地图或者服务，注意查清！！！
- (void)dealloc {
    NSLog(@"run dealloc");
}

@end
