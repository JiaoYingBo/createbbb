//
//  DVPieChartTeacher.h
//  GraduateProj
//
//  Created by jay on 2018/11/28.
//  Copyright © 2018 mlg. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DVPieChartTeacher : UIView

/**
 数据数组
 */
@property (strong, nonatomic) NSArray *dataArray;

/**
 标题
 */
@property (copy, nonatomic) NSString *title;


/**
 绘制方法
 */
- (void)draw;

@end

NS_ASSUME_NONNULL_END
