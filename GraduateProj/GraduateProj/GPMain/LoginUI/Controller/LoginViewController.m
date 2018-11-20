//
//  LoginViewController.m
//  GraduateProj
//
//  Created by 焦英博 on 2018/11/19.
//  Copyright © 2018年 mlg. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"

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
        NSLog(@"%@ %@ %@", type==0?@"学生":@"老师", username, pwd);
    };
}

@end
