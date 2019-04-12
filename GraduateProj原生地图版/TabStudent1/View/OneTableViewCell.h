//
//  OneTableViewCell.h
//  GraduateProj
//
//  Created by jay on 2018/11/19.
//  Copyright © 2018 mlg. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OneTableViewCell : UITableViewCell

@property (nonatomic,strong)UIView * bgView;//外面的白色view
@property (nonatomic,strong)UIImageView * frontImage;//前面的图标
@property (nonatomic,strong)UILabel * proLable;//指标label（身高，体重）
@property (nonatomic,strong)UILabel * rangeLable;//加一个等级label
@property (nonatomic,strong)UILabel * gradeLabel;//分数label


@end

NS_ASSUME_NONNULL_END
