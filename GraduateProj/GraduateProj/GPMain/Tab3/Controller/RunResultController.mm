//
//  RunResultController.m
//  GraduateProj
//
//  Created by 焦英博 on 2019/3/14.
//  Copyright © 2019 mlg. All rights reserved.
//

#import "RunResultController.h"
#import "RunNavView.h"
#import "ResultView.h"
#import "MyAnnotation.h"
#import <BaiduMapAPI_Map/BMKCircle.h>
#import <BaiduMapAPI_Map/BMKCircleView.h>
#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapAPI_Map/BMKPolyline.h>
#import <BaiduMapAPI_Map/BMKPolylineView.h>
#import <BaiduMapAPI_Map/BMKPointAnnotation.h>
#import <BaiduMapAPI_Map/BMKPinAnnotationView.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>

@interface RunResultController ()<BMKMapViewDelegate, BMKLocationServiceDelegate>

@property (nonatomic, weak) RunNavView *navView;
@property (nonatomic, weak)  BMKMapView *mapView;
@property (nonatomic, strong) BMKLocationService *locationService;
/** 点 */
@property (nonatomic, strong) BMKPointAnnotation *pointAnnotation;
@property (nonatomic, strong) UIButton *saveBtn;
@property (nonatomic, strong) ResultView *resultView;

@end

@implementation RunResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self bmkMapConfig];
    [self bmkServiceConfig];
    [self configUI];
}

- (void)bmkMapConfig {
    BMKMapView *mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 320)];
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
//    [locationService startUserLocationService];
    _locationService = locationService;
    BMKPointAnnotation *point = [[BMKPointAnnotation alloc] init];
    _pointAnnotation = point;
}

- (void)configUI {
    self.view.backgroundColor = kColor(51, 51, 68, 1);
    
    RunNavView *navView = [[RunNavView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    navView.isResultModel = YES;
    [self.view addSubview:navView];
    __weak typeof(self)weakSelf = self;
    navView.leftBtnClick = ^{
        [weakSelf.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RunControllerDidEndRun" object:nil];
    };
    self.navView = navView;
    
    self.resultView = [[ResultView alloc] initWithFrame:CGRectMake(0, 320+64+20, 375, 170)];
    [self.view addSubview:self.resultView];
    [self.resultView configWithDatas:self.dataArray];
    
    self.saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.saveBtn.layer.cornerRadius = 5*kScreen_W_Scale;
    self.saveBtn.layer.masksToBounds = YES;
    self.saveBtn.backgroundColor = kColor(255, 124, 93, 1);
    self.saveBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17*kScreen_W_Scale];
    [self.saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [self.saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.saveBtn];
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(25);
        make.right.equalTo(self.view).offset(-25);
        make.bottom.equalTo(self.view).offset(-25);
        make.height.mas_equalTo(40*kScreen_W_Scale);
    }];
}

// 根据坐标路线显示合适的地图区域
- (void)mapViewFitPolyLine:(BMKPolyline *)polyLine {
    CGFloat ltX, ltY, rbX, rbY;
    if (polyLine.pointCount < 1) {
        return;
    }
    BMKMapPoint pt = polyLine.points[0];
    ltX = pt.x;
    ltY = pt.y;
    rbX = pt.x;
    rbY = pt.y;
    for (int i = 1; i < polyLine.pointCount; i++) {
        BMKMapPoint pt = polyLine.points[i];
        if (pt.x < ltX) {
            ltX = pt.x;
        }
        if (pt.x > rbX) {
            rbX = pt.x;
        }
        if (pt.y > ltY) {
            ltY = pt.y;
        }
        if (pt.y < rbY) {
            rbY = pt.y;
        }
    }
    BMKMapRect rect;
    rect.origin = BMKMapPointMake(ltX , ltY);
    rect.size = BMKMapSizeMake(rbX - ltX, rbY - ltY);
    [_mapView setVisibleMapRect:rect];
    _mapView.zoomLevel = _mapView.zoomLevel - 0.3;
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
    [self mapViewFitPolyLine:[self getMapLine]];
    [self setMapLine];
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

// 将所有坐标连成一条路径以便进行区域大小判断
- (BMKPolyline *)getMapLine {
    NSMutableArray *totalArr = @[].mutableCopy;
    for (int i = 0; i < _lineGroupArray.count; i ++) {
        NSMutableArray *temp = _lineGroupArray[i];
        for (CLLocation *location in temp) {
            [totalArr addObject:location];
        }
    }
    CLLocationCoordinate2D *coords = new CLLocationCoordinate2D[totalArr.count];
    for (int i = 0; i < totalArr.count; i++) {
        CLLocation *loc = totalArr[i];
        coords[i] = loc.coordinate;
    }
    BMKPolyline *polyLine = [BMKPolyline polylineWithCoordinates:coords count:totalArr.count];
    [polyLine setPolylineWithCoordinates:coords count:totalArr.count];
    return polyLine;
}

// 绘制路径
- (void)setMapLine {
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

- (void)saveBtnClick {
    [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RunControllerDidEndRun" object:nil];
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
