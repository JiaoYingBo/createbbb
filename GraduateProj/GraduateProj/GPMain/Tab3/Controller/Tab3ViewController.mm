//
//  Tab3ViewController.m
//  GraduationProject
//
//  Created by 焦英博 on 2018/11/13.
//  Copyright © 2018年 mlg. All rights reserved.
//

#import "Tab3ViewController.h"
#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import "RunCountView.h"
#import "RunButton.h"
#import "RunViewController.h"

@interface Tab3ViewController ()<BMKMapViewDelegate, BMKLocationServiceDelegate, RunCountViewDelegate, RunButtonDelegate>
/** 百度地图 */
@property (nonatomic, weak)  BMKMapView *mapView;
/** 定位服务 */
@property (nonatomic, strong) BMKLocationService *locationService;
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
    mapView.zoomLevel = 17;
    mapView.showMapScaleBar = YES;
    mapView.overlookEnabled = NO;
    mapView.showsUserLocation = YES;
    mapView.mapType = BMKMapTypeStandard;
    mapView.logoPosition = BMKLogoPositionRightBottom;
    mapView.userTrackingMode = BMKUserTrackingModeNone;
    mapView.mapScaleBarPosition = CGPointMake(5.0, CGRectGetHeight(mapView.frame)-20);
    _mapView = mapView;
    [self.view addSubview:_mapView];
}

- (void)bmkServiceConfig {
    BMKLocationService *locationService = [[BMKLocationService alloc] init];
    locationService.delegate = self;
    _locationService = locationService;
    [_locationService startUserLocationService];
}

- (void)configUI {
    self.countView = [[RunCountView alloc] initWithFrame:CGRectMake(10, 74, kScreenWidth-20, 120)];
    self.countView.delegate = self;
    [self.view addSubview:self.countView];
    
    self.runBtn = [[RunButton alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    self.runBtn.center = CGPointMake(kScreenWidth/2, kScreenHeight-49-20-40);
    self.runBtn.delegate = self;
    [self.view addSubview:self.runBtn];
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

#pragma mark - 点击代理
- (void)didClickedRunButton:(RunButton *)btn {
    [self presentViewController:[[RunViewController alloc] init] animated:YES completion:nil];
}

- (void)didClickedRunCountView:(RunCountView *)countView {
    NSLog(@"跳转跑步记录列表页面");
}

#pragma mark - BMKLocationServiceDelegate
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    // 设置地图中心为用户经纬度 （很奇怪，这两句要一块写才能显示当前位置和定位圆圈）
    // 这三行可以让地图始终处于用户为屏幕中心的位置和17的缩放
    [_mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
    [_mapView updateLocationData:userLocation];
    _mapView.zoomLevel = 17;
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [_locationService stopUserLocationService];
    [_locationService startUserLocationService];
}

@end
