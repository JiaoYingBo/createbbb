//
//  RunCountView.h
//  GraduateProj
//
//  Created by 焦英博 on 2019/3/10.
//  Copyright © 2019 mlg. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class RunCountView;
@protocol RunCountViewDelegate <NSObject>

@optional
- (void)didClickedRunCountView:(RunCountView *)countView;

@end

@interface RunCountView : UIView

@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, strong) UILabel *mileageLabel;
// GPS信号强度（准确度）0:无效 1:弱 2:强 3:超强
@property (nonatomic, assign) NSInteger GPSStrength;
@property (nonatomic, weak) id<RunCountViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
