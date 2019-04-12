//
//  ActivityCell.m
//  GraduateProj
//
//  Created by jay on 2019/2/18.
//  Copyright © 2019 mlg. All rights reserved.
//

#import "ActivityCell.h"
#import <MBProgressHUD.h>

@implementation ActivityCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configUI];
    }
    return self;
}

- (void)configUI{
    self.contentView.backgroundColor = kColor(235, 245, 255, 1);
    self.localImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xiaodidian"]];
    [self.contentView addSubview:self.localImage];
    [self.localImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(15);
        make.left.equalTo(self.contentView).offset(15);
        make.height.width.mas_equalTo(16);
    }];
    
    self.loacalLabel = [[UILabel alloc] init];
    //self.loacalLabel.backgroundColor = [UIColor yellowColor];
    self.loacalLabel.numberOfLines = 0;
    self.loacalLabel.font = [UIFont systemFontOfSize:15];
    self.loacalLabel.text = @"活动地点：体育场二号门";
    [self.contentView addSubview:self.loacalLabel];
    [self.loacalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.localImage.mas_right).offset(10);
        make.top.equalTo(self.localImage);
        make.right.equalTo(self.contentView).offset(-15);
    }];
    
    self.detailImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xiaohuodong"]];
    [self.contentView addSubview:self.detailImage];
    [self.detailImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.localImage);
        make.top.equalTo(self.loacalLabel.mas_bottom).offset(10);
        make.height.width.mas_equalTo(16);
    }];
    
    self.detailLabel = [[UILabel alloc] init];
    self.detailLabel.numberOfLines = 0;
    self.detailLabel.font = [UIFont systemFontOfSize:15];
    self.detailLabel.text = @"活动内容：计算机研究生协会晨间运动（羽毛球、跑步、跳绳...）";
   // self.detailLabel.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.detailLabel];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.detailImage);
        make.left.equalTo(self.detailImage.mas_right).offset(10);
        make.right.equalTo(self.loacalLabel);
    }];
    
    self.timeImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xiaoshijian"]];
    [self.contentView addSubview:self.timeImage];
    [self.timeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.localImage);
        make.top.equalTo(self.detailLabel.mas_bottom).offset(10);
        make.height.width.mas_equalTo(16);
    }];
    
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.numberOfLines = 0;
    self.timeLabel.font = [UIFont systemFontOfSize:15];
    self.timeLabel.text = @"活动时间：2019.02.25上午6:00--2019.02.25上午7:30";
    //self.timeLabel.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeImage);
        make.left.equalTo(self.timeImage.mas_right).offset(10);
        make.right.equalTo(self.loacalLabel);
    }];
    
    self.personImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xiaofaqiren"]];
    [self.contentView addSubview:self.personImage];
    [self.personImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.localImage);
        make.top.equalTo(self.timeLabel.mas_bottom).offset(10);
        make.height.width.mas_equalTo(16);
    }];
    
    self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addBtn.backgroundColor = kColor(0, 191, 242, 1);
    self.addBtn.layer.cornerRadius = 3;
    self.addBtn.layer.masksToBounds = YES;
    [self.contentView addSubview:self.addBtn];
    self.addBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.addBtn setTitle:@"点击参与" forState:UIControlStateNormal];
    [self.addBtn addTarget:self action:@selector(addButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.personImage);
        make.right.equalTo(self.loacalLabel);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(17);
    }];
    
    self.statusLabel = [[UILabel alloc] init];
    self.statusLabel.layer.cornerRadius = 3;
    self.statusLabel.layer.masksToBounds = YES;
    self.statusLabel.numberOfLines = 0;
    self.statusLabel.font = [UIFont systemFontOfSize:12];
    self.statusLabel.textAlignment = NSTextAlignmentCenter;
    self.statusLabel.text = @"正在进行";
    self.statusLabel.textColor = [UIColor whiteColor];
    self.statusLabel.backgroundColor = kColor(0, 191, 242, 1);
    [self.contentView addSubview:self.statusLabel];
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.personImage);
        make.right.equalTo(self.addBtn.mas_left).offset(-5);
        make.width.mas_equalTo(60);
    }];
    
    self.personLabel = [[UILabel alloc] init];
    self.personLabel.numberOfLines = 0;
    self.personLabel.font = [UIFont systemFontOfSize:15];
    self.personLabel.text = @"发起人：钟老师";
    //self.personLabel.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:self.personLabel];
    [self.personLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.personImage);
        make.left.equalTo(self.personImage.mas_right).offset(10);
        make.right.equalTo(self.statusLabel.mas_left).offset(-10);
    }];
    
    
    
    self.followerLabel = [[UILabel alloc] init];
    self.followerLabel.backgroundColor = kColor(232, 232, 232, 1);
    self.followerLabel.numberOfLines = 0;
    self.followerLabel.textColor = kColor(89, 106, 151, 1);
    self.followerLabel.font = [UIFont systemFontOfSize:12];
    //self.followerLabel.text = @"丁宁、刘诗雯、马龙、樊振东、王皓、石川佳纯、丁宁、刘诗雯、马龙、樊振东、王皓、石川佳纯、丁宁、刘诗雯、马龙、樊振东、王皓、石川佳纯";
   // self.followerLabel.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.followerLabel];
    [self.followerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.personLabel.mas_bottom).offset(10);
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
}
- (void)addButtonMethod{
    if (self.addClick) {
        self.addClick();
    }
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    hud.label.text = @"参与成功";
    hud.mode = MBProgressHUDModeText;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:0.7];
}
@end
