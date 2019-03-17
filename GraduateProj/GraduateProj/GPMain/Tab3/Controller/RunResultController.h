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
// 分别是：总计时间 全程距离 均速 配速 消耗大卡
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, copy) NSString *startRunTime;

// 是历史记录页面还是跑步结束页面，默认NO（跑步结束）
@property (nonatomic, assign) BOOL isRecordModel;

@property (nonatomic, copy) void(^dismissClick)(void);

@end

NS_ASSUME_NONNULL_END
