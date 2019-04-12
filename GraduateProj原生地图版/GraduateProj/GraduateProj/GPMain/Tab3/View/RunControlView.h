//
//  RunControlView.h
//  GraduateProj
//
//  Created by 焦英博 on 2019/3/12.
//  Copyright © 2019 mlg. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class RunControlView;
@protocol RunControlViewDelegate <NSObject>

@optional
- (void)runControlViewDidStart:(RunControlView *)controlView;
- (void)runControlViewDidPause:(RunControlView *)controlView;
- (void)runControlViewDidContinue:(RunControlView *)controlView;
- (void)runControlViewDidEnd:(RunControlView *)controlView;

@end

@interface RunControlView : UIView

@property (nonatomic, strong) UILabel *distanceLabel;
@property (nonatomic, strong) UILabel *speedLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *calorieLabel;
@property (nonatomic, strong) UIButton *startPauseBtn;
@property (nonatomic, strong) UIButton *endBtn;
// GPS信号强度（准确度）0:无效 1:弱 2:强 3:超强
@property (nonatomic, assign) NSInteger GPSStrength;
// 跑步时长
@property (nonatomic, assign) int runDuration;

@property (nonatomic, weak) id<RunControlViewDelegate> delegate;

- (void)timeStart;
- (void)updateDistance:(nullable NSString *)distance speed:(nullable NSString *)speed calorie:(nullable NSString *)calorie;

@end

NS_ASSUME_NONNULL_END
