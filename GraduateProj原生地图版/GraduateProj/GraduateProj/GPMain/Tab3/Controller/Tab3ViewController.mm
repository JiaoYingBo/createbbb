//
//  Tab3ViewController.m
//  GraduationProject
//
//  Created by 焦英博 on 2018/11/13.
//  Copyright © 2018年 mlg. All rights reserved.
//

#import "Tab3ViewController.h"
#import "RunViewController.h"
#import "RunListController.h"
#import "RunButton.h"
#import "MyAnnotation.h"
#import "RunCountView.h"
#import "TargetLockView.h"
#import "RunResultController.h"
#import "RunFileUtil.h"
#import "RunRecordModel.h"
#import <MapKit/MapKit.h>

@interface Tab3ViewController ()<RunCountViewDelegate, RunButtonDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong) RunCountView *countView;
@property (nonatomic, strong) RunButton *runBtn;
@property (nonatomic, strong) RunViewController *runVC;

@property (nonatomic, strong) NSArray *runRecordDatas;
@property (nonatomic, assign) float totalMileage;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) MKMapView *mkMap;
@property (nonatomic, strong) CLLocation *userLocation;

@end

@implementation Tab3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configMapView];
    [self configUI];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(runVCStartStateObserve) name:@"RunControllerDidStartRun" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(runVCEndStateObserve) name:@"RunControllerDidEndRun" object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.locationManager startUpdatingLocation];
    [self configDatas];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.locationManager stopUpdatingLocation];
}

- (void)configDatas {
    self.runRecordDatas = @[];
    self.runRecordDatas = [RunFileUtil getAllRecordFiles];
    self.totalMileage = 0.00;
    if (self.runRecordDatas.count > 0) {
        for (int i = 0; i < self.runRecordDatas.count; i ++) {
            NSData *data = self.runRecordDatas[i];
            RunRecordModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            self.totalMileage = self.totalMileage + [model.dataArray[1] floatValue];
        }
    }
    self.countView.countLabel.text = [NSString stringWithFormat:@"%td", self.runRecordDatas.count];
    self.countView.mileageLabel.text = [NSString stringWithFormat:@"%.2f", self.totalMileage];
}

- (void)configMapView {
    self.mkMap = [[MKMapView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64-49)];
    self.mkMap.showsUserLocation = YES;
    self.mkMap.mapType = MKMapTypeStandard;
    self.mkMap.showsScale = YES;
    [self.view addSubview:_mkMap];
    
    if (![CLLocationManager locationServicesEnabled]) {
        [self notifyAlertWith:@"该设备不支持定位功能" gotoSetting:NO];
        return;
    }
    
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
        [weakSelf locateWithCLLocation:weakSelf.userLocation];
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
    [self configDatas];
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *userLocation = [locations firstObject];
    self.userLocation = userLocation;
    [self locateWithCLLocation:userLocation];
    [self setGPSWithCLLocation:userLocation];
}

#pragma mark - 点击代理
- (void)didClickedRunButton:(RunButton *)btn {
    if ([self locationJudgment]) {
        [self presentViewController:self.runVC animated:YES completion:nil];
    }
}

- (void)didClickedRunCountView:(RunCountView *)countView {
    NSLog(@"跳转跑步记录列表页面");
    RunListController *list = [[RunListController alloc] init];
    list.datas = self.runRecordDatas;
    list.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:list animated:YES];
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
        self.countView.GPSStrength = 0; // 无效
    } else if (accuracy <= 10) {
        self.countView.GPSStrength = 3; // 超强
    } else if (accuracy > 10 && accuracy <= 60) {
        self.countView.GPSStrength = 2; // 强
    } else {
        self.countView.GPSStrength = 1; // 弱
    }
}

- (BOOL)locationJudgment {
    if ([CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways)) {
        //定位功能可用
        return YES;
    } else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        //定位不能用
        [self notifyAlertWith:@"请在系统设置中打开定位权限，并设为始终允许。" gotoSetting:YES];
        return NO;
    }
    return NO;
}

- (void)notifyAlertWith:(NSString *)messgae gotoSetting:(BOOL)toSetting {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:messgae preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (toSetting) {
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if([[UIApplication sharedApplication] canOpenURL:url]) {
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
            }
        }
    }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [self.locationManager stopUpdatingLocation];
    [self.locationManager startUpdatingLocation];
}

@end
