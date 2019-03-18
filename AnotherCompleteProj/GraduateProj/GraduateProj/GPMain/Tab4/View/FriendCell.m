//
//  FriendCell.m
//  GraduateProj
//
//  Created by jay on 2019/1/14.
//  Copyright © 2019 mlg. All rights reserved.
//

#import "FriendCell.h"

@implementation FriendCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configUI];
    }
    return self;
}

- (void)configUI{
    //头像
    self.headImageView = [[UIImageView alloc] init];
    self.headImageView.backgroundColor = [UIColor yellowColor];
    self.headImageView.layer.cornerRadius = 5;
    self.headImageView.layer.masksToBounds = YES;
    //姓名
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.text = @"--";
    self.nameLabel.textColor = [UIColor grayColor];
    self.nameLabel.font = [UIFont systemFontOfSize:15];
    //self.nameLabel.backgroundColor = [UIColor greenColor];
    //发布时间
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.text = @"2019-1-19";
    self.timeLabel.textColor = [UIColor lightGrayColor];
    self.timeLabel.font = [UIFont systemFontOfSize:12];
    //self.timeLabel.backgroundColor = [UIColor lightGrayColor];
    //钟表
    self.clockImage = [[UIImageView alloc] init];
    self.clockImage.image = [UIImage imageNamed:@"zhongbiao"];
    //self.clockImage.backgroundColor = [UIColor blackColor];
    //中间横线
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = kColor(0, 191, 242, 1);
    //内容
    self.wordsLabel = [[UILabel alloc] init];
    self.wordsLabel.numberOfLines = 0;
    //[self.wordsLabel sizeToFit];
    //self.wordsLabel.backgroundColor = [UIColor greenColor];
    //赞的次数
    self.goodLabel = [[UILabel alloc] init];
    self.goodLabel.textColor = [UIColor lightGrayColor];
    self.goodLabel.font = [UIFont systemFontOfSize:12];
    //self.goodLabel.backgroundColor = [UIColor lightGrayColor];
    //点赞按钮
    self.goodButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //self.goodButton.backgroundColor = [UIColor yellowColor];
    [self.goodButton addTarget:self action:@selector(goodButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.goodButton setImage:[UIImage imageNamed:@"xin-2"] forState:UIControlStateNormal];
    [self.goodButton setImage:[UIImage imageNamed:@"xin"] forState:UIControlStateSelected];
    //评论按钮
    self.commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //self.commentButton.backgroundColor = [UIColor purpleColor];
    [self.commentButton addTarget:self action:@selector(commentButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.commentButton setImage:[UIImage imageNamed:@"pinglun"] forState:UIControlStateNormal];
    //评论数
    self.comCount = [[UILabel alloc] init];
    self.comCount.textColor = [UIColor lightGrayColor];
    self.comCount.text = @"2";
    self.comCount.font = [UIFont systemFontOfSize:12];
    //self.comCount.backgroundColor = [UIColor greenColor];
    
    [self.contentView addSubview:self.headImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.clockImage];
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.wordsLabel];
    [self.contentView addSubview:self.goodLabel];
    [self.contentView addSubview:self.goodButton];
    [self.contentView addSubview:self.commentButton];
    [self.contentView addSubview:self.comCount];
    
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(20);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.height.width.mas_equalTo(50);
    }];
    //------
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImageView.mas_top);
        make.height.equalTo(self.headImageView).multipliedBy(0.5);
        make.left.equalTo(self.headImageView.mas_right).offset(10);
        make.width.mas_equalTo(150);
    }];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(5);
        make.bottom.equalTo(self.headImageView);
        make.left.width.equalTo(self.nameLabel);
    }];
    [_clockImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.headImageView);
        make.right.equalTo(self.contentView).offset(-30);
        make.height.width.mas_equalTo(16);
    }];
    //--------
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImageView.mas_bottom).offset(10);
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
        make.height.mas_equalTo(1);
    }];
    //-----
    [_goodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.height.mas_equalTo(16);
        make.width.mas_equalTo(32);
    }];
    [_comCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.height.width.mas_equalTo(16);
    }];
    [_commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.comCount.mas_top);
        make.right.equalTo(self.comCount.mas_left);
        make.height.width.mas_equalTo(16);
    }];
    [_goodButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.commentButton);
        make.right.equalTo(self.commentButton.mas_left).offset(-15);
        make.height.width.mas_equalTo(16);
    }];
    //----
    [_wordsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView.mas_bottom).offset(15);
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.bottom.equalTo(self.goodLabel.mas_top).offset(-15);
    }];
}
//写在这里就不行，还不知道为啥
//- (void)layoutSubviews{
//    [super layoutSubviews];
//    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.contentView.mas_top).offset(10);
//        make.left.equalTo(self.contentView.mas_left).offset(10);
//        make.height.width.mas_equalTo(50);
//    }];
//    //------
//    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.headImageView.mas_top);
//        make.height.equalTo(self.headImageView).multipliedBy(0.5);
//        make.left.equalTo(self.headImageView.mas_right).offset(10);
//        make.width.mas_equalTo(150);
//    }];
//    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.nameLabel.mas_bottom).offset(5);
//        make.bottom.equalTo(self.headImageView);
//        make.left.width.equalTo(self.nameLabel);
//    }];
//    [_clockImage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.headImageView);
//        make.right.equalTo(self.contentView).offset(-10);
//        make.height.width.mas_equalTo(50);
//    }];
//    //--------
//    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.headImageView.mas_bottom).offset(10);
//        make.left.equalTo(self.contentView).offset(10);
//        make.right.equalTo(self.contentView).offset(-10);
//        make.height.mas_equalTo(2);
//    }];
//
//    [_goodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
//        make.left.equalTo(self.contentView.mas_left).offset(10);
//        make.height.width.mas_equalTo(50);
//    }];
//    [_comCount mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
//        make.right.equalTo(self.contentView.mas_right).offset(-10);
//        make.height.width.mas_equalTo(50);
//    }];
//    [_commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.comCount.mas_top);
//        make.right.equalTo(self.comCount.mas_left);
//        make.height.width.mas_equalTo(50);
//    }];
//    [_goodButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.commentButton);
//        make.right.equalTo(self.commentButton.mas_left).offset(-5);
//        make.height.width.mas_equalTo(50);
//    }];
//    //----
//    [_wordsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.lineView.mas_bottom).offset(10);
//        make.left.equalTo(self.contentView.mas_left).offset(10);
//        make.right.equalTo(self.contentView.mas_right).offset(-10);
//        make.bottom.equalTo(self.goodLabel.mas_top).offset(-10);
//    }];
//
//}
- (void)goodButtonMethod{
    if (self.goodClick) {
        self.goodClick();
    }
}
- (void)commentButtonMethod{
    if (self.commentClick) {
        self.commentClick();
    }
}
- (void)handlerButtonAction:(void(^)(void))block{
    self.goodClick = block;
}
@end
