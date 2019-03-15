//
//  TargetLockView.h
//  GraduateProj
//
//  Created by 焦英博 on 2019/3/15.
//  Copyright © 2019 mlg. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TargetLockView : UIView

@property (nonatomic, copy) void(^lockBtnClick)(void);

@end

NS_ASSUME_NONNULL_END
