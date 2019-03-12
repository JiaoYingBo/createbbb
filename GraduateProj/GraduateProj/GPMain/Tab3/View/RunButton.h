//
//  RunButton.h
//  GraduateProj
//
//  Created by 焦英博 on 2019/3/10.
//  Copyright © 2019 mlg. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class RunButton;
@protocol RunButtonDelegate <NSObject>

@optional
- (void)didClickedRunButton:(RunButton *)btn;

@end

@interface RunButton : UIView

@property (nonatomic, weak) id<RunButtonDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
