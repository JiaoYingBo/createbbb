//
//  AppDelegate.m
//  GraduateProj
//
//  Created by 焦英博 on 2018/11/17.
//  Copyright © 2018年 mlg. All rights reserved.
//

#import "AppDelegate.h"
#import <IQKeyboardManager.h>
#import <RTRootNavigationController.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import "GPMainTabBarController.h"
#import "LoginViewController.h"

@interface AppDelegate () {
    BMKMapManager* _mapManager;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSMutableArray *total = @[].mutableCopy;
    NSMutableArray *temp = nil;
    NSMutableArray *a1 = @[@"1",@"2"].mutableCopy;
    temp = a1;
    [total addObject:temp];
    NSLog(@"111--%@", total); // 1 2
    [temp addObject:@"0"];
    NSLog(@"444--%@", total);
    NSMutableArray *a2 = @[@"3",@"4"].mutableCopy;
    temp = a2;
    NSLog(@"222--%@", total); // 1 2
    [total addObject:temp];
    NSLog(@"333--%@", total); // 1 2 , 3 4
    [self baiduMapConfig];
    [self IQKeyBoardManagerConfig];
    
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:17.0]}];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    RTRootNavigationController *rootViewController;
    UIViewController *mainVC;
    
    BOOL logined = 1;
    if (logined) {
        mainVC = [[GPMainTabBarController alloc] init];
        ((GPMainTabBarController *)mainVC).selectedIndex = 2;
    } else {
        mainVC = [[LoginViewController alloc] init];
    }

    rootViewController = [[RTRootNavigationController alloc] initWithRootViewControllerNoWrapping:mainVC];
    
    self.window.rootViewController = rootViewController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)baiduMapConfig {
    _mapManager = [[BMKMapManager alloc] init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"QI9I59nAodGr1CPtuvj2kBarkVctUG8o"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"BauduMap manager start failed!");
    }
}

- (void)IQKeyBoardManagerConfig {
    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 50;
}

@end
