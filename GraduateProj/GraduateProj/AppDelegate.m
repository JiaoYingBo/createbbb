//
//  AppDelegate.m
//  GraduateProj
//
//  Created by 焦英博 on 2018/11/17.
//  Copyright © 2018年 mlg. All rights reserved.
//

#import "AppDelegate.h"
#import <RTRootNavigationController.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import "GPMainTabBarController.h"

@interface AppDelegate () {
    BMKMapManager* _mapManager;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self baiduMapConfig];
    
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:17.0]}];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    RTRootNavigationController *rootViewController;
    GPMainTabBarController *mtc = [[GPMainTabBarController alloc] init];
    rootViewController = [[RTRootNavigationController alloc] initWithRootViewControllerNoWrapping:mtc];
    
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

@end
