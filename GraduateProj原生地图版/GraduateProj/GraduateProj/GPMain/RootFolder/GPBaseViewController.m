//
//  GPBaseViewController.m
//  GraduationProject
//
//  Created by 焦英博 on 2018/11/13.
//  Copyright © 2018年 mlg. All rights reserved.
//

#import "GPBaseViewController.h"

@interface GPBaseViewController ()

@end

@implementation GPBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
}

- (void)setLeftNavItemToBack {
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    [self CreateBackButtonWithBlackText];
}

- (void)CreateBackButtonWithBlackText{
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 7, 60, 30)];
    leftButton.imageView.contentMode = UIViewContentModeCenter;
    leftButton.adjustsImageWhenHighlighted = NO;
    leftButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [leftButton addTarget:self action:@selector(backPop) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setImage:[UIImage imageNamed:@"back-m"] forState:UIControlStateNormal];//bule-back
    [leftButton setImage:[UIImage imageNamed:@"back-m-pressed"] forState:UIControlStateHighlighted];
    leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -18, 0, 0);
    [leftButton setTitle:@"        " forState:UIControlStateNormal];
    [leftButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [leftButton setTitleColor:kColor(0, 93, 225, 1) forState:UIControlStateNormal];
    [leftButton setTitleColor:kColor(65, 144, 255, 1) forState:UIControlStateHighlighted];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem =leftItem;
}

- (void)backPop {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
