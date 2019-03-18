//
//  MyReputationView.h
//  GraduateProj
//
//  Created by jay on 2018/11/19.
//  Copyright © 2018 mlg. All rights reserved.
//自定义的view，用来显示头像及其名次

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyReputationView : UIView

@property (nonatomic, strong) UIImageView *headView;// 头像

@property (nonatomic, strong) UILabel *numberLabel;//名次及名字

@end

NS_ASSUME_NONNULL_END
