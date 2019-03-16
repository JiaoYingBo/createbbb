//
//  RunResultController.m
//  GraduateProj
//
//  Created by 焦英博 on 2019/3/14.
//  Copyright © 2019 mlg. All rights reserved.
//

#import "RunResultController.h"
#import "RunNavView.h"
#import "MyAnnotation.h"
#import <BaiduMapAPI_Map/BMKCircle.h>
#import <BaiduMapAPI_Map/BMKCircleView.h>
#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapAPI_Map/BMKPolyline.h>
#import <BaiduMapAPI_Map/BMKPolylineView.h>
#import <BaiduMapAPI_Map/BMKPointAnnotation.h>
#import <BaiduMapAPI_Map/BMKPinAnnotationView.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>

@interface RunResultController ()<BMKMapViewDelegate, BMKLocationServiceDelegate>

@property (nonatomic, weak) RunNavView *navView;
@property (nonatomic, weak)  BMKMapView *mapView;
@property (nonatomic, strong) BMKLocationService *locationService;
/** 点 */
@property (nonatomic, strong) BMKPointAnnotation *pointAnnotation;

@end

@implementation RunResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self bmkMapConfig];
    [self bmkServiceConfig];
    [self configUI];
}

- (void)bmkMapConfig {
    BMKMapView *mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 250)];
    mapView.zoomLevel = 17;
    mapView.overlookEnabled = NO;
    mapView.rotateEnabled = NO;
    mapView.maxZoomLevel = 19;
    mapView.minZoomLevel = 10;
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
        [weakSelf.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RunControllerDidEndRun" object:nil];
    };
    self.navView = navView;
    
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
    return nil;
}

- (void)mapViewDidFinishLoading:(BMKMapView *)mapView {
    [self setMapLineWithLocation];
}

#pragma mark - BMKLocationServiceDelegate
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    // 设置地图中心为用户经纬度
//    [_mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
//    _mapView.zoomLevel = 17;
    // 设置大头针
//    [self setAnnotationWithLocation:userLocation];
//    // 绘制路线
//    [self setMapLineWithLocation:userLocation];
}

/**
 *  设置地图的标注
 */
- (void)setAnnotationWithLocation:(BMKUserLocation*)userLocation {
    if (userLocation.location == nil) {
        return;
    }
    _pointAnnotation.coordinate = userLocation.location.coordinate;
    if (![_mapView.annotations containsObject:_pointAnnotation]) {
        [_mapView addAnnotation:_pointAnnotation];
        [_mapView selectAnnotation:_pointAnnotation animated:YES];
    }
}
/**
 *  设置运动轨迹地图路径
 */
- (void)setMapLineWithLocation {
//    if (userLocation.location == nil) {
//        return;
//    }
//    /*
//     horizontalAccuracy的单位是米，代表当前GPS信号精确到了多少米，越接近于0定位就越准确，GPS信号也就越强，当horizontalAccuracy为负数时，当前为没有GPS信号，所以一般情况下参考horizontalAccuracy就可以向用户展示当前的信号强度
//     */
//    // 突然大于15可能是GPS信号弱定位漂移了，忽略
//    if (userLocation.location.horizontalAccuracy > 15) {
//        return;
//    }
//
//    if (_lineTempArray.count == 0) {
//        [_lineTempArray addObject:userLocation.location];
//        return;
//    }
//
//    CLLocation *last = _lineTempArray.lastObject;
//    CLLocationDistance distance = [userLocation.location distanceFromLocation:last];
//    // 经纬度没变或者距离小于4
//    if ((last.coordinate.longitude == userLocation.location.coordinate.longitude &&
//         last.coordinate.latitude == userLocation.location.coordinate.latitude) ||
//        (distance < 4 && _lineTempArray.count != 0)) {
//        return;
//    }
//    [_lineTempArray addObject:userLocation.location];
    
    for (int i = 0; i < _lineGroupArray.count; i ++) {
        NSMutableArray *temp = _lineGroupArray[i];
        
        CLLocationCoordinate2D *coords = new CLLocationCoordinate2D[temp.count];
        for (int i = 0; i < temp.count; i++) {
            CLLocation *loc = temp[i];
            coords[i] = loc.coordinate;
        }
        
        if (temp.count <= 1) {
            continue;
        }
        BMKPolyline *line = _polylineArray[i];
        
        if (![[_mapView overlays] containsObject:line]) {
            line = [BMKPolyline polylineWithCoordinates:coords count:temp.count];
            [_mapView addOverlay:line];
        } else {
            [line setPolylineWithCoordinates:coords count:temp.count];
        }
    }
}

#pragma mark - 生命周期
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

- (void)dealloc {
    NSLog(@"result dealloc");
}

@end
