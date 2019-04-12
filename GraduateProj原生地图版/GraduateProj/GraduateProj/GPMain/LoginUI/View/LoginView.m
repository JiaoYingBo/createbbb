//
//  LoginView.m
//  GraduateProj
//
//  Created by 焦英博 on 2018/11/19.
//  Copyright © 2018年 mlg. All rights reserved.
//

#import "LoginView.h"
#import "MOFSPickerManager.h"



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
    //self.bgImgView.image = [UIImage imageNamed:@"login_bg"];
    self.bgImgView.image = [UIImage imageNamed:@"bgLogo3"];
    
    self.bgImgView.contentMode = UIViewContentModeScaleAspectFill;
    self.bgImgView.alpha = 1;
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
        make.top.equalTo(self.mas_centerY).offset(-80*kScreen_W_Scale);//40
        make.height.mas_equalTo(40*kScreen_W_Scale);
    }];
    
    self.selectBtnLabel = [[UILabel alloc] init];
    self.selectBtnLabel.font = [UIFont boldSystemFontOfSize:18*kScreen_W_Scale];
    self.selectBtnLabel.textColor = [UIColor whiteColor];
    self.selectBtnLabel.text = @"请选择身份";
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
    self.userNameTf.keyboardType = UIKeyboardTypeNumberPad;
    self.userNameTf.borderStyle = UITextBorderStyleNone;
    self.userNameTf.font = [UIFont boldSystemFontOfSize:16*kScreen_W_Scale];
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
    self.passwordTf.keyboardType = UIKeyboardTypeNamePhonePad;
    self.passwordTf.borderStyle = UITextBorderStyleNone;
    self.passwordTf.font = [UIFont boldSystemFontOfSize:16*kScreen_W_Scale];
    self.passwordTf.textColor = [UIColor whiteColor];
    [pwdView addSubview:self.passwordTf];
    [self.passwordTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(pwdView);
        make.left.equalTo(pwdImg.mas_right).offset(10*kScreen_W_Scale);
    }];
    //验证码
    UIView *verifyView = [UIView new];
    [self addSubview:verifyView];
    [verifyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(pwdView.mas_bottom).offset(15*kScreen_W_Scale);
        make.left.right.height.equalTo(pwdView);
    }];
    UIImageView *verifyImg = [[UIImageView alloc] init];
    verifyImg.image = [UIImage imageNamed:@"verify"];
    [verifyView addSubview:verifyImg];
    [verifyImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(20*kScreen_W_Scale);
        make.left.equalTo(verifyView);
        make.centerY.equalTo(verifyView);
    }];
    UIView *line3 = [UIView new];
    line3.backgroundColor = [UIColor whiteColor];
    [verifyView addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(verifyView);
        make.left.right.equalTo(verifyView);
        make.height.mas_equalTo(0.5);
    }];
    _pooCodeView = [[PooCodeView alloc] initWithFrame:CGRectMake(10, 100, 120, 50) andChangeArray:nil];
    [verifyView addSubview:_pooCodeView];
    [self.pooCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(verifyView);
        make.width.mas_equalTo(120);
    }];
    
    
    self.verityField = [[UITextField alloc] init];
    NSAttributedString *placeholder3 = [[NSAttributedString alloc] initWithString:@"请输入验证码" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    self.verityField.attributedPlaceholder = placeholder3;
    self.verityField.keyboardType = UIKeyboardTypeNamePhonePad;
    self.verityField.borderStyle = UITextBorderStyleNone;
    self.verityField.font = [UIFont boldSystemFontOfSize:16*kScreen_W_Scale];
    self.verityField.textColor = [UIColor whiteColor];
    [verifyView addSubview:self.verityField];
    [self.verityField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(verifyView);
        make.left.equalTo(verifyImg.mas_right).offset(10*kScreen_W_Scale);
        make.right.equalTo(self.pooCodeView.mas_left).offset(-10*kScreen_W_Scale);
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
        make.top.equalTo(verifyView.mas_bottom).offset(35*kScreen_W_Scale);
        make.height.mas_equalTo(40*kScreen_W_Scale);
    }];
    //注册
    self.registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.registerBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14*kScreen_W_Scale];
    [self.registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [self.registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.registerBtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.registerBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;//左对齐
    [self addSubview:self.registerBtn];
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.selectBtn);
        make.width.mas_equalTo(80*kScreen_W_Scale);
        make.top.equalTo(self.loginBtn.mas_bottom).offset(5*kScreen_W_Scale);
        make.height.mas_equalTo(40*kScreen_W_Scale);
    }];
    //找回密码
    self.findPasswordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.findPasswordBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14*kScreen_W_Scale];
    [self.findPasswordBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [self.findPasswordBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.findPasswordBtn addTarget:self action:@selector(findPasswordBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.findPasswordBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;//左对齐
    [self addSubview:self.findPasswordBtn];
    [self.findPasswordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.selectBtn);
        make.width.mas_equalTo(80*kScreen_W_Scale);
        make.top.equalTo(self.loginBtn.mas_bottom).offset(5*kScreen_W_Scale);
        make.height.mas_equalTo(40*kScreen_W_Scale);
    }];
}

- (void)selectBtnClick {
    __weak typeof(self) weakSelf = self;
    [[MOFSPickerManager shareManger] showPickerViewWithDataArray:@[@"学生",@"老师"] tag:1 title:@"选择身份" cancelTitle:@"取消" commitTitle:@"确定" commitBlock:^(NSString *string) {
        weakSelf.selectBtnLabel.text = [NSString stringWithFormat:@"%@登录", string];
    } cancelBlock:^{

    }];
}

- (void)loginBtnClick {
    [self endEditing:YES];
    if (self.loginClick) {
        NSUInteger type = [self.selectBtnLabel.text containsString:@"老师"];
        self.loginClick(type, self.userNameTf.text, self.passwordTf.text);
    }
}
- (void)registerBtnClick{
    [self endEditing:YES];
    if (self.addClick) {
        self.addClick(@"register");
    }
}
- (void)findPasswordBtnClick{
    [self endEditing:YES];
    if (self.addClick) {
        self.addClick(@"find");
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}

@end
