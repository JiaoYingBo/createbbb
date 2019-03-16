//
//  RunRecordModel.h
//  GraduateProj
//
//  Created by 焦英博 on 2019/3/16.
//  Copyright © 2019 mlg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RunRecordModel : NSObject <NSCoding>

@property (nonatomic, strong) NSArray *lineGroupArray;
@property (nonatomic, strong) NSArray *lineTempArray;
// 分别是：总计时间 全程距离 均速 配速 消耗大卡
@property (nonatomic, strong) NSArray *dataArray;

@end

NS_ASSUME_NONNULL_END
