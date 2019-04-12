//
//  RunViewController.m
//  GraduateProj
//
//  Created by 焦英博 on 2019/3/10.
//  Copyright © 2019 mlg. All rights reserved.
//

#import "RunViewController.h"
#import "RunResultController.h"
#import "RunNavView.h"
#import "MyAnnotation.h"
#import "CountDownView.h"
#import "RunControlView.h"
#import "CircleSpreadTransition.h"
#import <MapKit/MapKit.h>

#define RunController_Map_Height 230.f

@interface RunViewController ()<CLLocationManagerDelegate, MKMapViewDelegate, UIViewControllerTransitioningDelegate, RunControlViewDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) MKMapView *mkMap;

@property (nonatomic, assign) UIStatusBarStyle statusBarStyleRecord;
@property (nonatomic, weak) RunNavView *navView;
@property (nonatomic, weak) RunControlView *controlView;
@property (nonatomic, copy) NSString *startTime;
// 是否点击了“隐藏”处于隐藏状态，隐藏状态下该控制器不可置nil
@property (nonatomic, assign) BOOL isHideMode;
// 是否开始跑步
@property (nonatomic, assign) BOOL didStartRun;

@end

@implementation RunViewController {
    NSMutableArray *_lineGroupArray;
    NSMutableArray *_lineTempArray;
    NSMutableArray *_polylineArray;
    CLLocationDistance _totalDistance;
}

/**
 关于自定义转场动画：
 
 先说说在实现non-interactive动画时，遇到的问题。
 
 在写demo时，用了controller.modalPresentationStyle = UIModalPresentationCustom;  就无法在- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext函数中通过toViewController.frame 获得 frame了，全是0，开始想不通，后来发现，之所以不用UIModalPresentationCustom时，可以获得frame，是因为系统通过modalPresentationStylez为toViewController.frame设定了初始值，而用了UIModalPresentationCustom，系统就不管toViewController.frame的初始化了，自然要自己指定frame了！这也才是custom的意义，自定义弹出开始和结束时的frame。另外还有一个问题，如果使用了controller.modalPresentationStyle = UIModalPresentationCustom，并且屏幕经过了旋转90度，transitionContext的containerView的坐标系并不会一起旋转，结果就是，先旋转，再present出controller，那么controller的frame就错了。
 
 但是如果不使用UIModalPresentationCustom，而使用其他的style(在ipad上测试)，同时使用自定义动画，要么会产生视图bug（UIModalPresentationFormSheet和UIModalPresentationPageSheet），要么还是像以前一样，会把原来controller的view从hierarchy上移掉(UIModalPresentationFullScreen，UIModalPresentationNone)！就达不到同时现实2个controller的view的效果了。如果仅仅想更改动画效果，不需要2个controller同时出现，那么不应该使用UIModalPresentationCustom。如果使用了UIModalPresentationCustom，那么就需要针对屏幕的各个方向，调整自定义动画的start frame 和 end frame。比如需要支持4个方向，那么就需要4组start frame 和 end frame，这样才能达到不同方向，相同的弹出效果。（摘自https://www.cnblogs.com/breezemist/p/3460497.html）
 
 简单说就是使用UIModalPresentationCustom模式时，fromVC不会消失。而自定义模态弹出的转场动画，必须h设置为custom模式。
 */
- (instancetype)init {
    self = [super init];
    if (self) {
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
        _totalDistance = 0;
        _didStartRun = NO;
        _lineTempArray = @[].mutableCopy;
        _lineGroupArray = @[_lineTempArray].mutableCopy;
        MKPolyline *line = [[MKPolyline alloc] init];
        _polylineArray = @[line].mutableCopy;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configMapView];
    [self configUI];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AppEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AppEnterForeground) name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)configMapView {
    self.mkMap = [[MKMapView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, RunController_Map_Height)];
    self.mkMap.showsUserLocation = YES;
    self.mkMap.mapType = MKMapTypeStandard;
    self.mkMap.showsScale = YES;
    self.mkMap.delegate = self;
    [self.view addSubview:_mkMap];
    
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager requestAlwaysAuthorization];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    // 设置过滤距离(以用户位置方圆10米为半径，实际位置超过该范围才会更新位置。否则不更新)
    self.locationManager.distanceFilter = 10;
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingLocation];
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
    self.navView = navView;
    
    RunControlView *controlView = [[RunControlView alloc] initWithFrame:CGRectMake(0, 64 + RunController_Map_Height, kScreenWidth, kScreenHeight - 64 - RunController_Map_Height)];
    controlView.delegate = self;
    [self.view addSubview:controlView];
    self.controlView = controlView;
}

#pragma mark - MKMapViewDelegate
- (MKPolylineRenderer *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay{
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolylineRenderer *line = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
        line.strokeColor = kColor(27, 252, 1, 1);
        line.lineWidth = 3.f;
        return line;
    }
    return nil;
}
#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *userLocation = [locations firstObject];
    [self locateWithCLLocation:userLocation];
    if (!self.isHideMode) {
        // 更新GPS信号
        [self setGPSWithCLLocation:userLocation];
        // 绘制路线
        if (self.didStartRun) {
            [self setMapLineWithLocation:userLocation];
        } else {
            // 表示暂停跑步了
            if (_lineGroupArray.count > 0) {
                [self updateControlViewWithBMKUserLocation:nil];
            }
        }
    } else {
        if (self.didStartRun) {
            // 这里只更新数据
            [self setMapLineWithLocation:userLocation];
        }
    }
}

#pragma mark - 其它私有方法
- (void)locateWithCLLocation:(CLLocation *)location {
    CLLocationCoordinate2D coordinate = location.coordinate;
    // 从外网上查的设置缩放的方法
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(coordinate, 800, 800);
    MKCoordinateRegion adjustedRegion = [self.mkMap regionThatFits:viewRegion];
    [self.mkMap setRegion:adjustedRegion animated:YES];
}
- (void)setGPSWithCLLocation:(CLLocation *)location {
    // GPS强度
    /**
     horizontalAccuracy的单位是米，代表当前GPS信号精确到了多少米，越接近于0定位就越准确，GPS信号也就越强，
     当horizontalAccuracy为负数时，当前为没有GPS信号，
     所以一般情况下参考horizontalAccuracy就可以向用户展示当前的信号强度
     我自己定义0~10超强，10~60强，60以上弱，负数无效
     */
    CLLocationAccuracy accuracy = location.horizontalAccuracy;
    if (accuracy < 0) {
        self.controlView.GPSStrength = 0; // 无效
    } else if (accuracy <= 10) {
        self.controlView.GPSStrength = 3; // 超强
    } else if (accuracy > 10 && accuracy <= 60) {
        self.controlView.GPSStrength = 2; // 强
    } else {
        self.controlView.GPSStrength = 1; // 弱
    }
}

/**
 *  设置运动轨迹地图路径
 */
- (void)setMapLineWithLocation:(CLLocation *)userLocation {
    if (userLocation == nil) {
        return;
    }
    /*
     horizontalAccuracy的单位是米，代表当前GPS信号精确到了多少米，越接近于0定位就越准确，GPS信号也就越强，
     当horizontalAccuracy为负数时，当前为没有GPS信号，所以一般情况下参考horizontalAccuracy就可以向用户展示当前的信号强度
     */
    // 突然大于15可能是GPS信号弱定位漂移了，忽略
    if (userLocation.horizontalAccuracy > 15) {
        NSLog(@"%.f >15，信号可能漂移，不稳定",userLocation.horizontalAccuracy);
        return;
    }
    if (_lineTempArray.count == 0) {
        [_lineTempArray addObject:userLocation];
        return;
    }
    
    CLLocation *last = _lineTempArray.lastObject;
    CLLocationDistance distance = [userLocation distanceFromLocation:last];
    // 经纬度没变或者距离小于2，定位频率大约是每秒一次
    if ((last.coordinate.longitude == userLocation.coordinate.longitude &&
         last.coordinate.latitude == userLocation.coordinate.latitude) ||
        (distance < 2 && _lineTempArray.count != 0)) {
        // 此时不绘制路线，但要更新页面数据
        [self updateControlViewWithBMKUserLocation:userLocation];
        return;
    }
    [_lineTempArray addObject:userLocation];
    // 更新ControlView上的数据
    _totalDistance += distance;
    
    if (!self.isHideMode) {
        // 绘制路线，且刷新页面数据
        [self updateControlViewWithBMKUserLocation:userLocation];
        
        for (int i = 0; i < _lineGroupArray.count; i ++) {
            NSMutableArray *temp = _lineGroupArray[i];
            
            CLLocationCoordinate2D *coords = new CLLocationCoordinate2D[temp.count];
            for (int i = 0; i < temp.count; i++) {
                CLLocation *loc = temp[i];
                coords[i] = loc.coordinate;
            }
            
            if (temp.count <= 1) {
                free(coords);
                continue;
            }
            MKPolyline *line = _polylineArray[i];
            
            if (![self.mkMap.overlays containsObject:line]) {
                line = [MKPolyline polylineWithCoordinates:coords count:temp.count];
                [self.mkMap addOverlay:line];
//                [_polylineArray replaceObjectAtIndex:i withObject:line];
            } else {
                [self.mkMap removeOverlay:line];
                line = [MKPolyline polylineWithCoordinates:coords count:temp.count];
                [self.mkMap addOverlay:line];
//                [_polylineArray replaceObjectAtIndex:i withObject:line];
            }
            free(coords);
        }
    }
}
// 已知体重、距离 跑步热量（kcal）＝体重（kg）×距离（公里）×1.036 例如：体重60公斤的人，长跑8公里，那么消耗的热量＝60×8×1.036＝497.28 kcal(千卡)
- (void)updateControlViewWithBMKUserLocation:(CLLocation *)userLocation {
    // 为nil表示暂停跑步了，只把速度变为0，其它不变
    if (userLocation == nil) {
        [self.controlView updateDistance:nil speed:@"0" calorie:nil];
        return;
    }
    // 刚开始定位的时候会出现负数，忽略
    if (userLocation.speed < 0) {
        return;
    }
    if (_totalDistance < 0) {
        _totalDistance = 0;
    }
    
    NSString *discante = [NSString stringWithFormat:@"%.2f", _totalDistance/1000];
    NSString *speed = [NSString stringWithFormat:@"%.f", userLocation.speed*3.6];
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
        weakSelf.navView.titleLabel.text = @"跑步中";
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RunControllerDidStartRun" object:nil];
    }];
}

- (void)runControlViewDidPause:(RunControlView *)controlView {
    self.didStartRun = NO;
    self.navView.titleLabel.text = @"暂停跑步";
    [self.locationManager stopUpdatingLocation];
    
    _lineTempArray = @[].mutableCopy;
    [_lineGroupArray addObject:_lineTempArray];
    
    MKPolyline *line = [[MKPolyline alloc] init];
    [_polylineArray addObject:line];
}

- (void)runControlViewDidContinue:(RunControlView *)controlView {
    self.didStartRun = YES;
    self.navView.titleLabel.text = @"跑步中";
    [self.locationManager startUpdatingLocation];
}

- (void)runControlViewDidEnd:(RunControlView *)controlView {
    self.didStartRun = NO;
    self.navView.titleLabel.text = @"跑步结束";
    [self.locationManager stopUpdatingLocation];
    self.startTime = [self getCurrentTime];
    
    // 小于50米或少于10秒时不记录
    if (_totalDistance < 50 || self.controlView.runDuration < 10) {
        [self notifyAlert];
        return;
    }
    
    NSArray *data = @[@(self.controlView.runDuration), @(_totalDistance), @(60*_totalDistance/1000*1.036)];
    RunResultController *resultVC = [[RunResultController alloc] init];
    resultVC.lineGroupArray = _lineGroupArray;
    resultVC.lineTempArray = _lineTempArray;
    resultVC.dataArray = [self getDetailDatasWithDatas:data];
    resultVC.startRunTime = self.startTime;
    self.statusBarStyleRecord = UIStatusBarStyleLightContent;
    [self presentViewController:resultVC animated:YES completion:^{
        self.statusBarStyleRecord = UIStatusBarStyleDefault;
    }];
}

// 分别是：总计时间 全程距离 均速 配速 消耗大卡
- (NSArray *)getDetailDatasWithDatas:(NSArray *)array {
    int time = [array[0] intValue];
    NSString *timeString = [NSString stringWithFormat:@"%02d:%02d:%02d",time/3600,time/60,time%60];
    
    double distance = [array[1] floatValue];
    NSString *distanceString = [NSString stringWithFormat:@"%.2f", distance/1000];
    
    NSString *junsuString = [NSString stringWithFormat:@"%.2f", distance/1000/((float)time/3600)];
    
    float fTime = (float)time;
    float minute = fTime/60/(distance/1000);
    int minuteInt = floorf(minute);
    int secondInt = (int)((minute - minuteInt) * 60);
    NSString *peisuString = [NSString stringWithFormat:@"%02d'%02d''", minuteInt, secondInt];
    
    double daka = [array[2] floatValue];
    NSString *dakaString = [NSString stringWithFormat:@"%.f", daka];
    
    return @[timeString, distanceString, junsuString, peisuString, dakaString];
}

- (void)notifyAlert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"距离过短无法保存" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RunControllerDidEndRun" object:nil];
    }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

//获取当前的时间
- (NSString *)getCurrentTime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    NSString *strToMinute = [currentTimeString substringToIndex:16];
    return strToMinute;
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
    [super viewWillAppear:animated];
//    _mapView.delegate = self;
//    _locationService.delegate = self;
    // 每次进入此页面就初始化为NO
    self.isHideMode = NO;
    
    /**
     参考 https://www.jianshu.com/p/25e9c1a864be
     1、修改工程Targets-General里的选项，让plist里多出一个status bar style
     2、plist里添加View controller-based status bar appearance为NO
     3、基类里添加[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
     4、需要变颜色的类里单独改颜色。
     */
    self.statusBarStyleRecord = UIStatusBarStyleDefault;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // 为了让页面隐藏时也定位，就不置service为nil了
    // 而mapview不置nil容易出现绘制bug而崩溃
//    _mapView.delegate = nil;
//    _locationService.delegate = nil;
    
    [UIApplication sharedApplication].statusBarStyle = self.statusBarStyleRecord;
}

- (void)AppEnterBackground {
    self.isHideMode = YES;
}

- (void)AppEnterForeground {
    self.isHideMode = NO;
}

#pragma mark - 内存泄漏!!!!!!!!!!!!!!!!! 应该是地图或者服务，注意查清！！！
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"run dealloc");
}

@end
