//
//  LoginView.m
//  GraduateProj
//
//  Created by 焦英博 on 2018/11/19.
//  Copyright © 2018年 mlg. All rights reserved.
//

#import "LoginView.h"

@interface LoginView ()

@property (nonatomic, strong) UILabel *selectBtnLabel;
@property (nonatomic, strong) UIImageView *selectBtnImg;

@end

@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    // 背景图
    self.bgImgView = [[UIImageView alloc] init];
    self.bgImgView.image = [UIImage imageNamed:@"login_bg"];
    self.bgImgView.contentMode = UIViewContentModeScaleAspectFill;
    self.bgImgView.alpha = 0.8;
    [self addSubview:self.bgImgView];
    [self.bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    // 选择按钮
    self.selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selectBtn.layer.cornerRadius = 5*kScreen_W_Scale;
    self.selectBtn.layer.masksToBounds = YES;
    self.selectBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.selectBtn.layer.borderWidth = 0.5;
    self.selectBtn.backgroundColor = kColor(255, 255, 255, 0);
    self.selectBtn.titleLabel.font = [UIFont systemFontOfSize:17*kScreen_W_Scale];
    [self.selectBtn addTarget:self action:@selector(selectBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.selectBtn];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20*kScreen_W_Scale);
        make.right.equalTo(self).offset(-20*kScreen_W_Scale);
        make.top.equalTo(self.mas_centerY).offset(-40*kScreen_W_Scale);
        make.height.mas_equalTo(40*kScreen_W_Scale);
    }];
    
    self.selectBtnLabel = [[UILabel alloc] init];
    self.selectBtnLabel.font = [UIFont systemFontOfSize:18*kScreen_W_Scale];
    self.selectBtnLabel.textColor = [UIColor whiteColor];
    self.selectBtnLabel.text = @"学生登录";
    [self.selectBtn addSubview:self.selectBtnLabel];
    [self.selectBtnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.selectBtn).offset(10*kScreen_W_Scale);
        make.centerY.equalTo(self.selectBtn);
    }];
    self.selectBtnImg = [[UIImageView alloc] init];
    self.selectBtnImg.image = [UIImage imageNamed:@"xiala2-1"];
    [self.selectBtn addSubview:self.selectBtnImg];
    [self.selectBtnImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(17*kScreen_W_Scale);
        make.right.equalTo(self.selectBtn).offset(-10*kScreen_W_Scale);
        make.centerY.equalTo(self.selectBtn);
    }];
    
    // 用户名
    UIView *userView = [UIView new];
    [self addSubview:userView];
    [userView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.selectBtn.mas_bottom).offset(35*kScreen_W_Scale);
        make.left.equalTo(self).offset(15*kScreen_W_Scale);
        make.height.mas_equalTo(35*kScreen_W_Scale);
        make.right.equalTo(self).offset(-15*kScreen_W_Scale);
    }];
    UIImageView *userImg = [[UIImageView alloc] init];
    userImg.image = [UIImage imageNamed:@"yonghu"];
    [userView addSubview:userImg];
    [userImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(20*kScreen_W_Scale);
        make.left.equalTo(userView);
        make.centerY.equalTo(userView);
    }];
    UIView *line1 = [UIView new];
    line1.backgroundColor = [UIColor whiteColor];
    [userView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(userView);
        make.left.right.equalTo(userView);
        make.height.mas_equalTo(0.5);
    }];
    self.userNameTf = [[UITextField alloc] init];
    NSAttributedString *placeholder1 = [[NSAttributedString alloc] initWithString:@"请输入学号" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    self.userNameTf.attributedPlaceholder = placeholder1;
    self.userNameTf.keyboardType = UIKeyboardTypePhonePad;
    self.userNameTf.borderStyle = UITextBorderStyleNone;
    self.userNameTf.font = [UIFont systemFontOfSize:16*kScreen_W_Scale];
    self.userNameTf.textColor = [UIColor whiteColor];
    [userView addSubview:self.userNameTf];
    [self.userNameTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(userView);
        make.left.equalTo(userImg.mas_right).offset(10*kScreen_W_Scale);
    }];
    
    // 密码
    UIView *pwdView = [UIView new];
    [self addSubview:pwdView];
    [pwdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userView.mas_bottom).offset(15*kScreen_W_Scale);
        make.left.right.height.equalTo(userView);
    }];
    UIImageView *pwdImg = [[UIImageView alloc] init];
    pwdImg.image = [UIImage imageNamed:@"mima"];
    [pwdView addSubview:pwdImg];
    [pwdImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(20*kScreen_W_Scale);
        make.left.equalTo(pwdView);
        make.centerY.equalTo(pwdView);
    }];
    UIView *line2 = [UIView new];
    line2.backgroundColor = [UIColor whiteColor];
    [pwdView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(pwdView);
        make.left.right.equalTo(pwdView);
        make.height.mas_equalTo(0.5);
    }];
    self.passwordTf = [[UITextField alloc] init];
    NSAttributedString *placeholder2 = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    self.passwordTf.attributedPlaceholder = placeholder2;
    self.passwordTf.keyboardType = UIKeyboardTypePhonePad;
    self.passwordTf.borderStyle = UITextBorderStyleNone;
    self.passwordTf.font = [UIFont systemFontOfSize:16*kScreen_W_Scale];
    self.passwordTf.textColor = [UIColor whiteColor];
    [pwdView addSubview:self.passwordTf];
    [self.passwordTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(pwdView);
        make.left.equalTo(pwdImg.mas_right).offset(10*kScreen_W_Scale);
    }];
    
    // 登录按钮
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginBtn.layer.cornerRadius = 5*kScreen_W_Scale;
    self.loginBtn.layer.masksToBounds = YES;
    self.loginBtn.backgroundColor = kColor(67, 149, 247, 1);
    self.loginBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17*kScreen_W_Scale];
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.selectBtn);
        make.top.equalTo(pwdView.mas_bottom).offset(45*kScreen_W_Scale);
        make.height.mas_equalTo(40*kScreen_W_Scale);
    }];
}

- (void)selectBtnClick {
    
}

- (void)loginBtnClick {
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}

@end
