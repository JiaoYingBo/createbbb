//
//  CountDownView.h
//  GraduateProj
//
//  Created by 焦英博 on 2019/3/13.
//  Copyright © 2019 mlg. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CountDownView : UIView

@property (nonatomic, strong) UILabel *countLabel;

- (void)showWithDismissCompletion:(void(^)(void))completion;
- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
