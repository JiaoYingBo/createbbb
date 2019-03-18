//
//  JiLuCell.m
//  GraduateProj
//
//  Created by 焦英博 on 2018/12/9.
//  Copyright © 2018 mlg. All rights reserved.
//

#import "JiLuCell.h"

@implementation JiLuCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configUI];
    }
    return self;
}

- (void)configUI {
    self.dateLabel = [UILabel new];
    self.dateLabel.text = @"2018年12月9日";
    self.dateLabel.textColor = kColor(135, 135, 135, 1);
    self.dateLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(20);
        make.left.equalTo(self.contentView).offset(20);
    }];
    
    UIView *line1 = [UIView new];
    line1.backgroundColor = kColor(200, 200, 200, 1);
    [self.contentView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(20);
        make.right.equalTo(self.contentView).offset(-20);
        make.top.equalTo(self.contentView).offset(40);
        make.height.mas_equalTo(0.5);
    }];
    
    UIView *line2 = [UIView new];
    line2.backgroundColor = kColor(200, 200, 200, 1);
    [self.contentView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(60);
        make.right.equalTo(line1);
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
    }];
    
    UIView *bgView = [UIView new];
    bgView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(line1.mas_bottom);
        make.bottom.equalTo(line2.mas_top);
    }];
    
    self.headImg = [[UIImageView alloc] init];
    self.headImg.image = [UIImage imageNamed:@"ic_system"];
    self.headImg.layer.masksToBounds = YES;
    [bgView addSubview:self.headImg];
    [self.headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(20);
        make.centerY.equalTo(bgView);
        make.width.height.mas_equalTo(30);
    }];
    
    self.timeLabel = [UILabel new];
    self.timeLabel.text = @"上午10:49";
    self.timeLabel.textColor = kColor(135, 135, 135, 1);
    self.timeLabel.font = [UIFont systemFontOfSize:12];
    [bgView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(15);
        make.left.equalTo(line2).offset(3);
    }];
    
    self.gradeLabel = [UILabel new];
    self.gradeLabel.text = @"89";
    self.gradeLabel.textColor = kColor(51, 51, 51, 1);
    self.gradeLabel.font = [UIFont boldSystemFontOfSize:17];
    [bgView addSubview:self.gradeLabel];
    [self.gradeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bgView).offset(13);
        make.left.equalTo(self.timeLabel);
    }];
    
    UILabel *fen = [UILabel new];
    fen.text = @"分";
    fen.textColor = kColor(135, 135, 135, 1);
    fen.font = [UIFont systemFontOfSize:12];
    [bgView addSubview:fen];
    [fen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.gradeLabel).offset(1);
        make.left.equalTo(self.timeLabel).offset(26);
    }];
    
    UIImageView *arrow = [[UIImageView alloc] init];
    arrow.image = [UIImage imageNamed:@"ic_arrow"];
    [bgView addSubview:arrow];
    [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(line1);
        make.centerY.equalTo(bgView);
    }];
}

@end
