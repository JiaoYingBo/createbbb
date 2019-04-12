//
//  IndexTableViewCell.h
//  GraduateProj
//
//  Created by jay on 2018/11/20.
//  Copyright © 2018 mlg. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IndexTableViewCell : UITableViewCell

@property (nonatomic,strong)UIView * bgView;//外面的白色view
@property (nonatomic,strong)UILabel * showLabel;//成绩展示label
@property (nonatomic,strong)NSArray * dataArray;//接受数据-1--2--3-- {1,2,3}
@property (nonatomic,strong)NSArray * cellDataArray;//接受数据-1--2--3-- {优秀，良好}
@property (nonatomic,copy)NSString * currentValue;//我的当前值



@end

NS_ASSUME_NONNULL_END
