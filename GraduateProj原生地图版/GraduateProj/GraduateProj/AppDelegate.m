//
//  AppDelegate.m
//  GraduateProj
//
//  Created by 焦英博 on 2018/11/17.
//  Copyright © 2018年 mlg. All rights reserved.
//TZ.Graduate-Student

#import "AppDelegate.h"
#import <IQKeyboardManager.h>
#import <RTRootNavigationController.h>
#import "GPMainTabBarController.h"
#import "LoginViewController.h"
#import <Bugly/Bugly.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self buglyConfig];
    [self IQKeyBoardManagerConfig];
    [self localStorageConfig];
    
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:17.0]}];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    RTRootNavigationController *rootViewController;
    UIViewController *mainVC;
    
    BOOL logined = 1;//暂定为1

    if (logined) {
        mainVC = [[GPMainTabBarController alloc] init];
        ((GPMainTabBarController *)mainVC).isTeacher = NO;
        ((GPMainTabBarController *)mainVC).selectedIndex = 2;
    } else {
        mainVC = [[LoginViewController alloc] init];
    }
    
    rootViewController = [[RTRootNavigationController alloc] initWithRootViewControllerNoWrapping:mainVC];
    
    self.window.rootViewController = rootViewController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)buglyConfig {
    [Bugly startWithAppId:@"ddbc036aaf"];
}

- (void)IQKeyBoardManagerConfig {
    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 50;
}

// 存储跑步记录用
- (void)localStorageConfig {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:RunRecordLocalStorageNumber] == nil) {
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:RunRecordLocalStorageNumber];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

@end
