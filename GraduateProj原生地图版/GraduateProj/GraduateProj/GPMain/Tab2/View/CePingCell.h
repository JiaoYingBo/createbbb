//
//  CePingCell.h
//  GraduateProj
//
//  Created by 焦英博 on 2018/12/8.
//  Copyright © 2018 mlg. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CePingCell : UITableViewCell

@property (nonatomic, strong) UIImageView *headImg;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *unitLabel;
@property (nonatomic, assign) BOOL hideTopLine;

@end

NS_ASSUME_NONNULL_END
