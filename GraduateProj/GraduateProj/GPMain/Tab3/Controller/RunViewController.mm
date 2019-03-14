//
//  RunViewController.m
//  GraduateProj
//
//  Created by 焦英博 on 2019/3/10.
//  Copyright © 2019 mlg. All rights reserved.
//

#import "RunViewController.h"
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

@end

@implementation RunViewController {
    NSMutableArray *lineArray;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
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
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    };
    
    RunControlView *controlView = [[RunControlView alloc] initWithFrame:CGRectMake(0, 64 + Map_Height, kScreenWidth, kScreenHeight - 64 - Map_Height)];
    controlView.delegate = self;
    [self.view addSubview:controlView];
}

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation {
    MyAnnotation *annotationView = (MyAnnotation*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"myAnno"];
    if (annotationView == nil) {
        annotationView = [[MyAnnotation alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnno"];
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
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    // 设置地图中心为用户经纬度
    [_mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
    
    [self setAnnotationWithLocation:userLocation];
    
    [self setMapLineWithLocation:userLocation];
    
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
    }else{
        
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
    if (userLocation.location.horizontalAccuracy > 5) {
        return;
    }
    
    if (lineArray == nil) {
        lineArray = [NSMutableArray new];
        return;
    }
    
    CLLocation *last = lineArray.lastObject;
    CLLocationDistance distance = [userLocation.location distanceFromLocation:last];
    // 经纬度没变或者距离小于4
    if ((last.coordinate.longitude == userLocation.location.coordinate.longitude
         &&last.coordinate.latitude == userLocation.location.coordinate.latitude)
        || (distance < 4 && lineArray.count != 0)) {
        return;
    }
    [lineArray addObject:userLocation.location];
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

#pragma mark - RunControlView Delegate
- (void)runControlViewDidStart:(RunControlView *)controlView {
    CountDownView *countDown = [[CountDownView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [countDown show];
}

- (void)runControlViewDidEnd:(RunControlView *)controlView {
    NSLog(@"ye mian fan hui");
}

#pragma mark - 转场动画
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [CircleSpreadTransition transitionWithTransitionType:XWCircleSpreadTransitionTypePresent];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [CircleSpreadTransition transitionWithTransitionType:XWCircleSpreadTransitionTypeDismiss];
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    return nil;
}

#pragma mark - 生命周期函数

- (void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self;
    _locationService.delegate = self;
    
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
