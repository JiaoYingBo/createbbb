//
//  RunResultController.h
//  GraduateProj
//
//  Created by 焦英博 on 2019/3/14.
//  Copyright © 2019 mlg. All rights reserved.
//

#import "GPBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface RunResultController : GPBaseViewController

@property (nonatomic, strong) NSMutableArray *lineGroupArray;
@property (nonatomic, strong) NSMutableArray *lineTempArray;
@property (nonatomic, strong) NSMutableArray *polylineArray;

@property (nonatomic, copy) void(^dismissClick)(void);

@end

NS_ASSUME_NONNULL_END
