//
//  CircleSpreadTransition.h
//  GraduateProj
//
//  Created by 焦英博 on 2019/3/10.
//  Copyright © 2019 mlg. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, XWCircleSpreadTransitionType) {
    XWCircleSpreadTransitionTypePresent = 0,
    XWCircleSpreadTransitionTypeDismiss
};

NS_ASSUME_NONNULL_BEGIN

@interface CircleSpreadTransition : NSObject<UIViewControllerAnimatedTransitioning, CAAnimationDelegate>

@property (nonatomic, assign) XWCircleSpreadTransitionType type;

+ (instancetype)transitionWithTransitionType:(XWCircleSpreadTransitionType)type;

@end

NS_ASSUME_NONNULL_END
