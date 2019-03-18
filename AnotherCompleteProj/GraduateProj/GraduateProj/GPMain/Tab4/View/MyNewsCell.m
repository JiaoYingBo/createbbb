//
//  MyNewsCell.m
//  GraduateProj
//
//  Created by jay on 2019/2/2.
//  Copyright © 2019 mlg. All rights reserved.
//

#import "MyNewsCell.h"

@implementation MyNewsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configUI];
    }
    return self;
}

- (void)configUI{
    self.topImageView = [[UIImageView alloc] init];
    self.topImageView.layer.cornerRadius = 5;
    self.topImageView.layer.masksToBounds = YES;
    self.topImageView.backgroundColor = [UIColor brownColor];
    [self.contentView addSubview:self.topImageView];
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(15);
        make.bottom.equalTo(self.contentView).offset(-15);
        make.left.equalTo(self.contentView).offset(15);
        make.width.equalTo(self.topImageView.mas_height);
    }];
    self.headLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.headLabel];
    [self.headLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topImageView.mas_top).offset(5);
        make.left.equalTo(self.topImageView.mas_right).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.mas_equalTo(20);
    }];
    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.textColor = [UIColor lightGrayColor];
    self.contentLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headLabel.mas_bottom).offset(5);
        make.left.right.equalTo(self.headLabel);
        make.bottom.equalTo(self.topImageView.mas_bottom);
    }];
}

@end
