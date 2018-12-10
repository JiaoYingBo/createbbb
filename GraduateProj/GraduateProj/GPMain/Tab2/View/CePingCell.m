//
//  CePingCell.m
//  GraduateProj
//
//  Created by 焦英博 on 2018/12/8.
//  Copyright © 2018 mlg. All rights reserved.
//

#import "CePingCell.h"

@implementation CePingCell {
    UIView *_topLine;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configUI];
    }
    return self;
}

- (void)configUI {
    self.contentView.backgroundColor = kColor(234, 234, 234, 1);
    UIView *bgView = [UIView new];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contentView);
        make.height.mas_equalTo(70);
    }];
    
    UIView *line1 = [UIView new];
    line1.backgroundColor = kColor(220, 220, 220, 1);
    [self.contentView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
    }];
    _topLine = line1;
    
    UIView *line2 = [UIView new];
    line2.backgroundColor = kColor(220, 220, 220, 1);
    [self.contentView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(bgView.mas_bottom);
        make.height.mas_equalTo(0.5);
    }];
    
    self.headImg = [[UIImageView alloc] init];
    self.headImg.image = [UIImage imageNamed:@"ic_logistics"];
    self.headImg.layer.masksToBounds = YES;
    [bgView addSubview:self.headImg];
    [self.headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(15);
        make.centerY.equalTo(bgView);
        make.width.height.mas_equalTo(35);
    }];
    
    self.titleLabel = [UILabel new];
    self.titleLabel.text = @"身高";
    self.titleLabel.textColor = kColor(51, 51, 51, 1);
    self.titleLabel.font = [UIFont systemFontOfSize:17];
    [bgView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.headImg);
        make.left.equalTo(self.headImg.mas_right).offset(15);
    }];
    
    self.unitLabel = [UILabel new];
    self.unitLabel.text = @"厘米";
    self.unitLabel.textColor = kColor(200, 200, 200, 1);
    self.unitLabel.font = [UIFont systemFontOfSize:15];
    [bgView addSubview:self.unitLabel];
    [self.unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.headImg).offset(3);
        make.right.equalTo(bgView).offset(-15);
    }];
    
    self.numberLabel = [UILabel new];
    self.numberLabel.text = @"180.3";
    self.numberLabel.textColor = kColor(51, 51, 51, 1);
    self.numberLabel.font = [UIFont systemFontOfSize:27];
    [bgView addSubview:self.numberLabel];
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.headImg);
        make.right.equalTo(bgView).offset(-50);
    }];
}

- (void)setHideTopLine:(BOOL)hideTopLine {
    _hideTopLine = hideTopLine;
    _topLine.hidden = _hideTopLine;
}

@end
