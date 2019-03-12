//
//  RunNavView.h
//  GraduateProj
//
//  Created by 焦英博 on 2019/3/10.
//  Copyright © 2019 mlg. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RunNavView : UIView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, copy) void(^leftBtnClick)(void);

@end

NS_ASSUME_NONNULL_END
