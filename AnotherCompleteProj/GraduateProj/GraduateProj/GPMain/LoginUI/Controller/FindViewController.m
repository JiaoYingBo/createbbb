//
//  FindViewController.m
//  GraduateProj
//
//  Created by jay on 2019/3/1.
//  Copyright © 2019 mlg. All rights reserved.
//

#import "FindViewController.h"

@interface FindViewController ()

@property (nonatomic,strong)UILabel *numberLabel;
@property (nonatomic,strong)UITextField *numberField;
@property (nonatomic,strong)UILabel *teleLabel;
@property (nonatomic,strong)UITextField *teleField;
@property (nonatomic,strong)UILabel *terifyLabel;
@property (nonatomic,strong)UITextField *terifyField;

@property (nonatomic,strong)UILabel *passwordLabel;
@property (nonatomic,strong)UITextField *passwordField;
@property (nonatomic,strong)UILabel *againPasswordLabel;
@property (nonatomic,strong)UITextField *againPasswordField;
@property (nonatomic,strong)UIButton *submitBtn;
@property (nonatomic,strong)UIButton *cancelBtn;

@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kColor(87, 169, 250, 1);
    [self setUI];
}

- (void)setUI{
    self.numberLabel = [[UILabel alloc] init];
    self.numberLabel.text = @"学号:";
    self.numberLabel.textAlignment = NSTextAlignmentRight;
    
    [self.view addSubview:self.numberLabel];
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.left.equalTo(self.view).offset(20);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
    }];
    self.numberField = [[UITextField alloc] init];
    //NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"请输入学号" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:self.numberField.font}];
    
    self.numberField.placeholder = @"请输入学号/身份证号";
    
    [self.view addSubview:self.numberField];
    [self.numberField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(self.numberLabel);
        make.left.equalTo(self.numberLabel.mas_right).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-20);
    }];
    //-----------
    UIView *numberLine = [[UIView alloc] init];
    numberLine.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:numberLine];
    [numberLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.numberLabel.mas_bottom).offset(1);
        make.left.right.equalTo(self.numberField);
        make.height.mas_equalTo(1);
    }];
    self.teleLabel = [[UILabel alloc] init];
    self.teleLabel.text = @"手机:";
    self.teleLabel.textAlignment = NSTextAlignmentRight;
    
    [self.view addSubview:self.teleLabel];
    [self.teleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.numberLabel.mas_bottom).offset(10);
        make.left.width.height.equalTo(self.numberLabel);
    }];
    self.teleField = [[UITextField alloc] init];
    self.teleField.placeholder = @"请输入注册时的手机";
    [self.view addSubview:self.teleField];
    [self.teleField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.teleLabel);
        make.left.height.width.equalTo(self.numberField);
    }];
    //-----------
    UIView *teleLine = [[UIView alloc] init];
    teleLine.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:teleLine];
    [teleLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.teleField.mas_bottom).offset(1);
        make.left.right.equalTo(self.teleField);
        make.height.mas_equalTo(1);
    }];
    self.terifyLabel = [[UILabel alloc] init];
    self.terifyLabel.text = @"验证码:";
    self.terifyLabel.textAlignment = NSTextAlignmentRight;
    
    [self.view addSubview:self.terifyLabel];
    [self.terifyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.teleLabel.mas_bottom).offset(10);
        make.left.width.height.equalTo(self.numberLabel);
    }];
    //点击发送验证码：
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sendBtn.backgroundColor = kColor(67, 149, 247, 1);
    [sendBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    sendBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:sendBtn];
    [sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(self.terifyLabel);
        make.right.equalTo(self.numberField);
        make.width.mas_equalTo(100);
    }];
    self.terifyField = [[UITextField alloc] init];
    self.terifyField.placeholder = @"请输入验证码";
    [self.view addSubview:self.terifyField];
    [self.terifyField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.terifyLabel);
        make.left.height.width.equalTo(self.numberField);
    }];
    //-----------
    UIView *terifyLine = [[UIView alloc] init];
    terifyLine.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:terifyLine];
    [terifyLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.terifyField.mas_bottom).offset(1);
        make.left.right.equalTo(self.terifyField);
        make.height.mas_equalTo(1);
    }];
    self.passwordLabel = [[UILabel alloc] init];
    self.passwordLabel.text = @"密码:";
    self.passwordLabel.textAlignment = NSTextAlignmentRight;
    
    [self.view addSubview:self.passwordLabel];
    [self.passwordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.terifyLabel.mas_bottom).offset(10);
        make.left.width.height.equalTo(self.numberLabel);
    }];
    self.passwordField = [[UITextField alloc] init];
    self.passwordField.placeholder = @"请输入密码";
    [self.view addSubview:self.passwordField];
    [self.passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordLabel);
        make.left.height.width.equalTo(self.numberField);
    }];
    //-----------
    UIView *passwordLine = [[UIView alloc] init];
    passwordLine.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:passwordLine];
    [passwordLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordField.mas_bottom).offset(1);
        make.left.right.equalTo(self.passwordField);
        make.height.mas_equalTo(1);
    }];
    
    self.againPasswordLabel = [[UILabel alloc] init];
    self.againPasswordLabel.text = @"确认密码:";
    self.againPasswordLabel.textAlignment = NSTextAlignmentRight;
    
    [self.view addSubview:self.againPasswordLabel];
    [self.againPasswordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordLabel.mas_bottom).offset(10);
        make.left.width.height.equalTo(self.numberLabel);
    }];
    self.againPasswordField = [[UITextField alloc] init];
    self.againPasswordField.placeholder = @"请再次输入密码";
    [self.view addSubview:self.againPasswordField];
    [self.againPasswordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.againPasswordLabel);
        make.left.height.width.equalTo(self.numberField);
    }];
    //-----------
    UIView *againPasswordLine = [[UIView alloc] init];
    againPasswordLine.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:againPasswordLine];
    [againPasswordLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.againPasswordField.mas_bottom).offset(1);
        make.left.right.equalTo(self.againPasswordField);
        make.height.mas_equalTo(1);
    }];
    
    self.submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.submitBtn.backgroundColor = kColor(67, 149, 247, 1);
    [self.submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [self.submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.submitBtn];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.againPasswordLabel.mas_bottom).offset(20);
        make.left.height.equalTo(self.numberLabel);
        make.right.equalTo(self.view.mas_right).offset(-20);
    }];
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //self.cancelBtn.backgroundColor = kColor(67, 149, 247, 1);
    self.cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    self.cancelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;//you对齐
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.cancelBtn];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.submitBtn.mas_bottom).offset(1);
        make.left.height.equalTo(self.numberLabel);
        make.right.equalTo(self.view.mas_right).offset(-20);
    }];
}
- (void)submitBtnClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
