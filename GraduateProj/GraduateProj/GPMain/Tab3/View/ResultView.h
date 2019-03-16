//
//  ResultView.h
//  GraduateProj
//
//  Created by 焦英博 on 2019/3/16.
//  Copyright © 2019 mlg. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ResultView : UIView

@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *distanceLabel;
@property (nonatomic, strong) UILabel *junsuLabel;
@property (nonatomic, strong) UILabel *peisuLabel;
@property (nonatomic, strong) UILabel *xiaohaoLabel;

// array分别是：总时间 总距离 消耗大卡
- (void)configWithDatas:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
