//
//  RunNavView.h
//  GraduateProj
//
//  Created by 焦英博 on 2019/3/10.
//  Copyright © 2019 mlg. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, RunNavViewType) {
    RunNavViewTypeNormal = 0,
    RunNavViewTypeRunEnd = 1,
    RunNavViewTypeRecord = 2,
};

@interface RunNavView : UIView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, copy) void(^leftBtnClick)(void);

@property (nonatomic, assign) RunNavViewType type;

@end

NS_ASSUME_NONNULL_END
