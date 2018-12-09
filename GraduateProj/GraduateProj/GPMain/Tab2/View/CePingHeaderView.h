//
//  CePingHeaderView.h
//  GraduateProj
//
//  Created by 焦英博 on 2018/12/7.
//  Copyright © 2018 mlg. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CePingHeaderView : UIView

@property (nonatomic, strong) UIImageView *headImg;
@property (nonatomic, strong) UIImageView *sexImg;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *detailLabel;

@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIView *bottomLine;

@property (nonatomic, copy) void(^leftRightClick)(BOOL isLeft);

@end

NS_ASSUME_NONNULL_END
