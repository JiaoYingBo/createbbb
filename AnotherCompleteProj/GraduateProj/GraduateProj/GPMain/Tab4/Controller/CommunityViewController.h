//
//  CommunityViewController.h
//  GraduateProj
//
//  Created by 焦英博 on 2019/3/18.
//  Copyright © 2019 mlg. All rights reserved.
//

#import "GPBaseViewController.h"
#import "grayTimeView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommunityViewController : GPBaseViewController

@property (nonatomic,strong)grayTimeView *timeView;
@property (nonatomic,weak)NSTimer *timer;

@end

NS_ASSUME_NONNULL_END
