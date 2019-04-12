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
#import "RunFileUtil.h"
#import "RunRecordModel.h"
#import <MBProgressHUD.h>
#import <MapKit/MapKit.h>

#import "CrumbPathRender.h"

@interface RunResultController ()<MKMapViewDelegate>

@property (nonatomic, strong) MKMapView *mkMap;
@property (nonatomic, weak) RunNavView *navView;
@property (nonatomic, strong) MKPointAnnotation *startAnnotation;
@property (nonatomic, strong) MKPointAnnotation *endAnnotation;
@property (nonatomic, strong) UIButton *saveBtn;
@property (nonatomic, strong) ResultView *resultView;
@property (nonatomic, strong) RunRecordModel *model;

@end

@implementation RunResultController

- (instancetype)init {
    if (self = [super init]) {
        self.isRecordModel = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configMapView];
    [self configUI];
    self.model = [[RunRecordModel alloc] init];
    self.model.lineGroupArray = self.lineGroupArray;
    self.model.lineTempArray = self.lineTempArray;
    self.model.dataArray = self.dataArray;
    self.model.startRunDate = self.startRunTime;
}

- (void)configMapView {
    self.mkMap = [[MKMapView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 320)];
    self.mkMap.mapType = MKMapTypeStandard;
//    self.mkMap.zoomEnabled = NO;
    self.mkMap.delegate = self;
    [self.view addSubview:self.mkMap];
    
    _startAnnotation = [[MKPointAnnotation alloc] init];
    _endAnnotation = [[MKPointAnnotation alloc] init];
    
    [self mapViewFitsPolyLine:[self getMapLine]];
//    [self drawMapLine];
    [self drawLine];
    [self setAnnotationWithStartLocation:[[self getAllLocation] firstObject] endLocation:[[self getAllLocation] lastObject]];
}

- (void)configUI {
    self.view.backgroundColor = kColor(51, 51, 68, 1);
    
    RunNavView *navView = [[RunNavView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    if (self.isRecordModel) {
        navView.type = RunNavViewTypeRecord;
        navView.titleLabel.text = self.startRunTime;
    } else {
        navView.type = RunNavViewTypeRunEnd;
    }
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
    if (self.isRecordModel) {
        [self.saveBtn setTitle:@"关闭" forState:UIControlStateNormal];
    } else {
        [self.saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    }
    [self.saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.saveBtn];
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(25);
        make.right.equalTo(self.view).offset(-25);
        make.bottom.equalTo(self.view).offset(-25);
        make.height.mas_equalTo(40*kScreen_W_Scale);
    }];
    
    if (!self.isRecordModel) {
        [self configEndTimeUI];
    }
}

- (void)configEndTimeUI {
    UIView *endView = [UIView new];
    endView.layer.cornerRadius = 10;
    endView.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:endView];
    [endView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-8);
        make.bottom.equalTo(self.resultView.mas_top).offset(-22);
        make.width.mas_equalTo(170);
        make.height.mas_equalTo(20);
    }];
    
    UIView *touView = [UIView new];
    touView.layer.cornerRadius = 6;
    touView.backgroundColor = kColor(255, 124, 93, 1);
    [endView addSubview:touView];
    [touView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(endView).offset(6);
        make.centerY.equalTo(endView);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(12);
    }];
    
    UILabel *endLab = [UILabel new];
    endLab.text = @"End";
    endLab.textColor = [UIColor whiteColor];
    endLab.font = [UIFont fontWithName:@"Baskerville-BoldItalic" size:13];
    [touView addSubview:endLab];
    [endLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(touView);
    }];
    
    UILabel *timeLab = [UILabel new];
    timeLab.text = @"2019-03-17 07:28";
    timeLab.textColor = [UIColor whiteColor];
    timeLab.font = [UIFont systemFontOfSize:13];
    [endView addSubview:timeLab];
    [timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(endView);
        make.right.equalTo(endView).offset(-10);
    }];
}

// 根据坐标路线显示合适的地图区域
- (void)mapViewFitsPolyLine:(MKPolyline *)polyLine {
    if (polyLine.pointCount < 1) {
        return;
    }
    MKMapPoint pnt = polyLine.points[0];
    CGFloat lX, lY, rX, rY;
    lX = pnt.x;
    lY = pnt.y;
    rX = pnt.x;
    rY = pnt.y;
    for (int i = 1; i < polyLine.pointCount; i++) {
        MKMapPoint pt = polyLine.points[i];
        if (pt.x < lX) {
            lX = pt.x;
        }
        if (pt.x > rX) {
            rX = pt.x;
        }
        if (pt.y < lY) {
            lY = pt.y;
        }
        if (pt.y > rY) {
            rY = pt.y;
        }
    }
    MKMapRect rect;
    rect.origin = MKMapPointMake(lX, lY);
    rect.size = MKMapSizeMake(rX - lX, rY - lY);
    [self.mkMap setVisibleMapRect:rect edgePadding:UIEdgeInsetsMake(15, 15, 15, 15) animated:NO];
}

#pragma mark - mapViewDelegate
- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView {
//    [self setAnnotationWithStartLocation:[[self getAllLocation] firstObject] endLocation:[[self getAllLocation] lastObject]];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MyAnnotation *annotationView = (MyAnnotation*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"ResultAnnotation"];
    if (annotationView == nil) {
        annotationView = [[MyAnnotation alloc] initWithAnnotation:annotation reuseIdentifier:@"ResultAnnotation"];
        if (annotation == _startAnnotation) {
            annotationView.type = MyAnnotationTypeGo;
        } else if (annotation == _endAnnotation) {
            annotationView.type = MyAnnotationTypeEnd;
        }
    }
    return annotationView;
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    // 单色路径
//    if ([overlay isKindOfClass:[MKPolyline class]]) {
//        MKPolylineRenderer *line = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
//        line.strokeColor = kColor(27, 252, 1, 1);
//        line.lineWidth = 3.f;
//        return line;
//    }
//    return nil;
    
    // 多段彩色路径
    if ([overlay isKindOfClass:[CrumbPathOverlay class]]) {
        MKOverlayRenderer *render = [mapView rendererForOverlay:overlay];
        if(!render) {
            render = [[CrumbPathRender alloc] initWithOverlay:overlay];
        }
        return render;
        
    }
    return nil;
}

#pragma mark - 其它私有方法
- (void)setAnnotationWithStartLocation:(CLLocation*)start endLocation:(CLLocation*)end {
    _startAnnotation.coordinate = start.coordinate;
    if (![self.mkMap.annotations containsObject:_startAnnotation]) {
        [self.mkMap addAnnotation:_startAnnotation];
    }
    
    _endAnnotation.coordinate = end.coordinate;
    if (![self.mkMap.annotations containsObject:_endAnnotation]) {
        [self.mkMap addAnnotation:_endAnnotation];
    }
}

// 将所有坐标连成一条路径以便进行区域大小判断
- (MKPolyline *)getMapLine {
    NSArray *totalArr = [self getAllLocation];
    CLLocationCoordinate2D *coords = new CLLocationCoordinate2D[totalArr.count];
    for (int i = 0; i < totalArr.count; i++) {
        CLLocation *loc = totalArr[i];
        coords[i] = loc.coordinate;
    }
    MKPolyline *polyLine = [MKPolyline polylineWithCoordinates:coords count:totalArr.count];
    return polyLine;
}

- (NSArray *)getAllLocation {
    NSMutableArray *totalArr = @[].mutableCopy;
    for (int i = 0; i < _lineGroupArray.count; i ++) {
        NSMutableArray *temp = _lineGroupArray[i];
        for (CLLocation *location in temp) {
            [totalArr addObject:location];
        }
    }
    return totalArr.copy;
}

- (void)drawLine {
    NSArray *totalArr = [self getAllLocation];
    CLLocation *loc = totalArr[0];
    CrumbPathOverlay *overlay = [[CrumbPathOverlay alloc] initWithOrigin:CrumbPointMake(loc.coordinate,0)];
    [_mkMap addOverlay:overlay];
    
    for (int i = 0; i < totalArr.count; i ++) {
        if (i > 0) {
            CLLocation *location = totalArr[i];
            // hue范围0-1，数值越大越红，越小越绿
            static float hue = 0.6;
            [overlay addCoordinate:CrumbPointMake(location.coordinate, hue)];
            if (i%10 == 0) {
                hue = hue + 0.05;
            }
            if (hue > 0.85) {
                hue = 0.3;
            }
        }
    }
}

// 绘制路径
- (void)drawMapLine {
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
        MKPolyline *line = [[MKPolyline alloc] init];
        if (![self.mkMap.overlays containsObject:line]) {
            line = [MKPolyline polylineWithCoordinates:coords count:temp.count];
            [self.mkMap addOverlay:line];
        } else {
            [self.mkMap removeOverlay:line];
            line = [MKPolyline polylineWithCoordinates:coords count:temp.count];
            [self.mkMap addOverlay:line];
        }
    }
}

- (void)saveBtnClick {
    if (self.isRecordModel) {
        [self dismissViewControllerAnimated:YES completion:nil];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    } else {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.model];
        [RunFileUtil saveRecordData:data];

        [self showDownHud];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"RunControllerDidEndRun" object:nil];
        });
    }
}

- (void)showDownHud {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.contentColor = kColor(240, 90, 20, 1);
    hud.mode = MBProgressHUDModeCustomView;
    UIImage *image = [[UIImage imageNamed:@"Checkmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    hud.customView = [[UIImageView alloc] initWithImage:image];
    hud.square = YES;
    hud.label.text = @"保存完成!";
    [hud hideAnimated:YES afterDelay:1.f];
}

- (void)dealloc {
    NSLog(@"result dealloc");
}

@end
