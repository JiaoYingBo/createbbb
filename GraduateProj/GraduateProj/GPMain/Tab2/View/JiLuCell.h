//
//  JiLuCell.h
//  GraduateProj
//
//  Created by 焦英博 on 2018/12/9.
//  Copyright © 2018 mlg. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JiLuCell : UITableViewCell

@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *gradeLabel;
@property (nonatomic, strong) UIImageView *headImg;

@end

NS_ASSUME_NONNULL_END
