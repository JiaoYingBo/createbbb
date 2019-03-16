//
//  Tab3ViewController.m
//  GraduationProject
//
//  Created by 焦英博 on 2018/11/13.
//  Copyright © 2018年 mlg. All rights reserved.
//

#import "Tab3ViewController.h"
#import "RunViewController.h"
#import "RunButton.h"
#import "MyAnnotation.h"
#import "RunCountView.h"
#import "TargetLockView.h"
#import <BaiduMapAPI_Map/BMKCircle.h>
#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapAPI_Map/BMKCircleView.h>
#import <BaiduMapAPI_Map/BMKPinAnnotationView.h>
#import <BaiduMapAPI_Map/BMKPointAnnotation.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import "RunResultController.h"

@interface Tab3ViewController ()<BMKMapViewDelegate, BMKLocationServiceDelegate, RunCountViewDelegate, RunButtonDelegate>
/** 百度地图 */
@property (nonatomic, weak)  BMKMapView *mapView;
/** 定位服务 */
@property (nonatomic, strong) BMKLocationService *locationService;
@property (nonatomic, assign) BMKUserLocation *userLocation;
@property (nonatomic, strong) BMKPointAnnotation *pointAnnotation;

@property (nonatomic, strong) RunCountView *countView;
@property (nonatomic, strong) RunButton *runBtn;
@property (nonatomic, strong) RunViewController *runVC;

@end

@implementation Tab3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self bmkMapConfig];
    [self bmkServiceConfig];
    [self configUI];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(runVCStartStateObserve) name:@"RunControllerDidStartRun" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(runVCEndStateObserve) name:@"RunControllerDidEndRun" object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self;
    _locationService.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
    _locationService.delegate = nil;
}

- (void)bmkMapConfig {
    BMKMapView *mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64-49)];
    mapView.zoomLevel = 16;
    mapView.overlookEnabled = NO;
    mapView.showMapScaleBar = YES;
    mapView.showsUserLocation = YES;
    mapView.mapType = BMKMapTypeStandard;
    mapView.logoPosition = BMKLogoPositionRightBottom;
    mapView.userTrackingMode = BMKUserTrackingModeNone;
    mapView.mapScaleBarPosition = CGPointMake(5.0, CGRectGetHeight(mapView.frame)-20);
    [self.view addSubview:mapView];
    _mapView = mapView;
}

- (void)bmkServiceConfig {
    BMKLocationService *locationService = [[BMKLocationService alloc] init];
    locationService.delegate = self;
    _locationService = locationService;
    [_locationService startUserLocationService];
    BMKPointAnnotation *point = [[BMKPointAnnotation alloc] init];
    _pointAnnotation = point;
}

- (void)configUI {
    self.countView = [[RunCountView alloc] initWithFrame:CGRectMake(10, 74, kScreenWidth-20, 120)];
    self.countView.delegate = self;
    [self.view addSubview:self.countView];
    
    self.runBtn = [[RunButton alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    self.runBtn.center = CGPointMake(kScreenWidth/2, kScreenHeight-49-20-40);
    self.runBtn.delegate = self;
    [self.view addSubview:self.runBtn];
    
    TargetLockView *lockView = [[TargetLockView alloc] initWithFrame:CGRectMake(10, kScreenHeight-49-80, 35, 35)];
    [self.view addSubview:lockView];
    __weak typeof(self)weakSelf = self;
    lockView.lockBtnClick = ^{
        [weakSelf focusLocationWithBMKUserLocation:weakSelf.userLocation];
    };
}

- (CGRect)buttonFrame {
    return self.runBtn.frame;
}

- (RunViewController *)runVC {
    if (!_runVC) {
        _runVC = [[RunViewController alloc] init];
    }
    return _runVC;
}

- (void)runVCStartStateObserve {
    self.runBtn.isRunning = YES;
}

- (void)runVCEndStateObserve {
    self.runVC = nil;
    self.runBtn.isRunning = NO;
}

#pragma mark - 点击代理
- (void)didClickedRunButton:(RunButton *)btn {
    [self presentViewController:self.runVC animated:YES completion:nil];
}

- (void)didClickedRunCountView:(RunCountView *)countView {
    NSLog(@"跳转跑步记录列表页面");
    [self presentViewController:[[RunResultController alloc] init] animated:YES completion:nil];
}

- (void)focusLocationWithBMKUserLocation:(BMKUserLocation *)userLocation {
    // 这三行可以让地图始终处于用户为屏幕中心的位置和17的缩放
    _mapView.zoomLevel = 17;
    // 设置地图中心为用户经纬度 （很奇怪，这两句要一块写才能显示系统定位圈）
//    [_mapView updateLocationData:userLocation];
    [_mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
}

#pragma mark - BMKLocationServiceDelegate
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    // 定位
    self.userLocation = userLocation;
    // 打开地图时它会立马定位两次，就用第二次的定位结果显示
    static int locationTimes = 0;
    if (locationTimes < 2) {
        locationTimes ++;
        [self focusLocationWithBMKUserLocation:userLocation];
    }
    // 大头针
    _pointAnnotation.coordinate = userLocation.location.coordinate;
    if (![_mapView.annotations containsObject:_pointAnnotation]) {
        [_mapView addAnnotation:_pointAnnotation];
        [_mapView selectAnnotation:_pointAnnotation animated:YES];
    }
    // 范围圈
    static BMKCircle *circle;
    if (circle == nil) {
        circle = [BMKCircle circleWithCenterCoordinate:userLocation.location.coordinate radius:150];
        [_mapView addOverlay:circle];
    } else {
        circle.coordinate = userLocation.location.coordinate;
    }
    
    // GPS强度
    /**
     horizontalAccuracy的单位是米，代表当前GPS信号精确到了多少米，越接近于0定位就越准确，GPS信号也就越强，
     当horizontalAccuracy为负数时，当前为没有GPS信号，
     所以一般情况下参考horizontalAccuracy就可以向用户展示当前的信号强度
     我自己定义0~10超强，10~60强，60以上弱，负数无效
     */
    if (userLocation.location.horizontalAccuracy < 0) {
        self.countView.GPSStrength = 0; // 无效
    } else if (userLocation.location.horizontalAccuracy <= 10) {
        self.countView.GPSStrength = 3; // 超强
    } else if (userLocation.location.horizontalAccuracy > 10 && userLocation.location.horizontalAccuracy <= 60) {
        self.countView.GPSStrength = 2; // 强
    } else {
        self.countView.GPSStrength = 1; // 弱
    }
}

#pragma mark - BMKMapViewDelegate
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation {
    MyAnnotation *annotationView = (MyAnnotation*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"Tab3Annotation"];
    if (annotationView == nil) {
        annotationView = [[MyAnnotation alloc] initWithAnnotation:annotation reuseIdentifier:@"Tab3Annotation"];
    }
    return annotationView;
}

- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id<BMKOverlay>)overlay {
    if ([overlay isKindOfClass:[BMKCircle class]]) {
        BMKCircleView *circleView = [[BMKCircleView alloc] initWithCircle:overlay];
        circleView.fillColor = kColor(73, 173, 253, 0.2);
        circleView.strokeColor = [UIColor whiteColor];
        circleView.lineWidth = 0;
        return circleView;
    }
    
    return nil;
}

//- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
//    // 目前没找到更好的改变大小的方法
//    BMKCircle *circle = mapView.overlays.lastObject;
//    if (mapView.zoomLevel > 18) {
//        circle.radius = 30;
//    } else if (mapView.zoomLevel >= 16 && mapView.zoomLevel < 18) {
//        circle.radius = 100;
//    } else {
//        circle.radius = 200;
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [_locationService stopUserLocationService];
    [_locationService startUserLocationService];
}

@end
