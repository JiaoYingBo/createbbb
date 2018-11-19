//
//  Tab3ViewController.m
//  GraduationProject
//
//  Created by 焦英博 on 2018/11/13.
//  Copyright © 2018年 mlg. All rights reserved.
//

#import "Tab3ViewController.h"
#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>//引入定位功能所有的头文件

@interface Tab3ViewController ()<BMKMapViewDelegate, BMKLocationServiceDelegate> {
    BMKMapView *_mapView;
    BMKLocationService *_service;
}

@end

@implementation Tab3ViewController

- (void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

- (void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _mapView = [[BMKMapView alloc] initWithFrame:self.view.bounds];
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    //显示定位图层
    _mapView.showsUserLocation = YES;
    //设置定位的状态
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;
    _mapView.zoomLevel = 18;
    
    _service = [[BMKLocationService alloc] init];
    _service.delegate = self;
    [_service startUserLocationService];
}

/**
 *在将要启动定位时，会调用此函数
 */
- (void)willStartLocatingUser {
    
}

/**
 *在停止定位后，会调用此函数
 */
- (void)didStopLocatingUser {
    
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
//- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation {
//    if (!userLocation.heading) {
//        return;
//    }
//    [_mapView updateLocationData:userLocation];
//}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    _mapView.showsUserLocation = YES;
    [_mapView updateLocationData:userLocation];
    _mapView.centerCoordinate = userLocation.location.coordinate;
}

/**
 *定位失败后，会调用此函数
 *@param error 错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error {
    
}

@end
