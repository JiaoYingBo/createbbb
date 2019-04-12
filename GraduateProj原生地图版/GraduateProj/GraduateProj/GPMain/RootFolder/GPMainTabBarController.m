//
//  GPMainTabBarController.m
//  GraduationProject
//
//  Created by 焦英博 on 2018/11/13.
//  Copyright © 2018年 mlg. All rights reserved.
//

#import "GPMainTabBarController.h"
#import "GPBaseNavigationController.h"
#import "Tab1ViewController.h"
#import "Tab2ViewController.h"
#import "Tab3ViewController.h"
#import "Tab4ViewController.h"
#import "Tab5ViewController.h"
#import "TabTea1ViewControlelr.h"

@interface GPMainTabBarController ()

@end

@implementation GPMainTabBarController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // NSLog(@"willllllllll");
    
    //self.isTeacher = true;//暂时设置为老师
//    [self configureTabBar];//在viewdidload中无法接受属性传值。
}
    
- (void)viewDidLoad {
    [super viewDidLoad];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:kColor(67, 149, 247, 1),NSFontAttributeName:[UIFont systemFontOfSize:17]} forState:UIControlStateSelected];
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //NSLog(@"Diddddddddd");
}
- (void)setIsTeacher:(BOOL)isTeacher {
    _isTeacher = isTeacher;
    [self configureTabBar];
}
- (void)configureTabBar {
    NSLog(@"maintab==%@",self.isTeacher?@"老师":@"学生");
    
    GPBaseViewController *tab1;
    if (self.isTeacher) {
        tab1 = [[TabTea1ViewControlelr alloc] init];
    }else{
        tab1 = [[Tab1ViewController alloc] init];
    }
   // Tab1ViewController *tab1 = [[Tab1ViewController alloc] init];
    Tab2ViewController *tab2 = [[Tab2ViewController alloc] init];
    Tab3ViewController *tab3 = [[Tab3ViewController alloc] init];
    Tab4ViewController *tab4 = [[Tab4ViewController alloc] init];
    Tab5ViewController *tab5 = [[Tab5ViewController alloc] init];
    NSMutableArray *vcArr = [NSMutableArray arrayWithObjects:tab1,tab2,tab3,tab4,tab5, nil];
    
    NSArray *titleArr = @[@"成绩",@"测评",@"运动",@"干货",@"我的"];
    NSArray *picArr = @[@"home_normal",@"find_normal",@"shequ",@"chat_normal",@"mine_normal"];
    NSArray *selectPicArr = @[@"home_selected",@"find_selected",@"shequ_selected",@"chat_selected",@"mine_selected"];
    
    for (int i = 0; i < vcArr.count; i++) {
        UIViewController *vc = vcArr[i];
        vc.title = titleArr[i];
        GPBaseNavigationController *nc =[[GPBaseNavigationController alloc]initWithRootViewController:vc];
        [nc.tabBarItem setImage:[[UIImage imageNamed:picArr[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [nc.tabBarItem setSelectedImage:[[UIImage imageNamed:selectPicArr[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [vcArr replaceObjectAtIndex:i withObject:nc];
    }
    self.viewControllers = vcArr;
}

@end
