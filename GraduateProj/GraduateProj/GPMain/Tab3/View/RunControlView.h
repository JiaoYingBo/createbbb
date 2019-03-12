//
//  RunControlView.h
//  GraduateProj
//
//  Created by 焦英博 on 2019/3/12.
//  Copyright © 2019 mlg. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RunControlView : UIView

@property (nonatomic, strong) UILabel *distanceLabel;
@property (nonatomic, strong) UILabel *speedLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *calorieLabel;
@property (nonatomic, strong) UIButton *startPauseBtn;
@property (nonatomic, strong) UIButton *endBtn;

@end

NS_ASSUME_NONNULL_END
