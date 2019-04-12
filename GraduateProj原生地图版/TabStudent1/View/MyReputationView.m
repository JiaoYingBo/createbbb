//
//  MyReputationView.m
//  GraduateProj
//
//  Created by jay on 2018/11/19.
//  Copyright © 2018 mlg. All rights reserved.
//

#import "MyReputationView.h"

@implementation MyReputationView

// 1.重写initWithFrame:方法，创建子控件并添加到自己上面
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        // 1. 创建头像
        UIImageView *headView = [UIImageView new];
        self.headView = headView;
        //self.headView.backgroundColor = [UIColor blackColor];//bg
        [self addSubview:self.headView];
        
        // 2.名次
        UILabel *numberLabel = [UILabel new];
        numberLabel.textAlignment = NSTextAlignmentCenter;
        self.numberLabel = numberLabel;
        //self.numberLabel.backgroundColor = [UIColor yellowColor];//bg
        self.numberLabel.numberOfLines = 0;//显示两行
        self.numberLabel.textColor = [UIColor lightGrayColor];
       
        [self addSubview:self.numberLabel];
        
    }
    return self;
}

// 2.重写layoutSubviews，给自己内部子控件设置frame
- (void)layoutSubviews {
    [super layoutSubviews];
    CGSize size = self.frame.size;
    self.headView.frame = CGRectMake(0, 0, size.width , 60);
    self.headView.layer.cornerRadius = 30;
    self.headView.layer.masksToBounds = YES;
    
    self.numberLabel.frame = CGRectMake(0, size.width, size.width, 30);
    
}



@end
