//
//  LoginViewController.m
//  GraduateProj
//
//  Created by 焦英博 on 2018/11/19.
//  Copyright © 2018年 mlg. All rights reserved.
//

#import "LoginViewController.h"
#import "GPMainTabBarController.h"
#import "LoginView.h"
#import <MBProgressHUD.h>

@interface LoginViewController ()

@property (nonatomic, strong) LoginView *loginView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

- (void)configUI {
    self.loginView = [LoginView new];
    self.loginView.frame = self.view.bounds;
    [self.view addSubview:self.loginView];
    self.loginView.loginClick = ^(NSUInteger type, NSString *username, NSString *pwd) {
//        if (username.length > 0 && pwd.length > 0) {
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
            hud.label.text = @"正在登录";
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hideAnimated:YES];
                GPMainTabBarController *mainVC = [[GPMainTabBarController alloc] init];
                window.rootViewController = mainVC;
            });
//        }
    };
}

@end
