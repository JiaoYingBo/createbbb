//
//  showCell.m
//  GraduateProj
//
//  Created by jay on 2019/1/10.
//  Copyright © 2019 mlg. All rights reserved.
//

#import "showCell.h"


@implementation showCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configUI];
    }
    return self;
}

- (void)configUI{
    _frontView = [[customShowView alloc] init];
    _frontView.backgroundColor = kColor(255, 211, 53, 1);
    [self.contentView addSubview:_frontView];
    
    _rearView = [[customShowView alloc] init];
    _rearView.backgroundColor = kColor(255, 211, 53, 1);
    [self.contentView addSubview:_rearView];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [_frontView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(5);
        make.bottom.equalTo(self.contentView).offset(-5);
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView.mas_centerX).offset(-5);
    }];
    [_rearView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(5);
        make.bottom.equalTo(self.contentView).offset(-5);
        make.left.equalTo(_frontView.mas_right).offset(10);
        make.right.equalTo(self.contentView).offset(-5);
    }];
}

@end
