//
//  LoginView.h
//  GraduateProj
//
//  Created by 焦英博 on 2018/11/19.
//  Copyright © 2018年 mlg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PooCodeView.h"

typedef void(^myBlock)(NSUInteger type, NSString *username, NSString *pwd);
typedef void(^ourBlock) (NSString *string);

@interface LoginView : UIView

@property (nonatomic, strong) UIImageView *bgImgView;
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) UITextField *userNameTf;
@property (nonatomic, strong) UITextField *passwordTf;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIButton *registerBtn;
@property (nonatomic, strong) UIButton *findPasswordBtn;
@property (nonatomic, copy) myBlock loginClick;
@property (nonatomic, copy) ourBlock addClick;
@property (nonatomic, strong)PooCodeView *pooCodeView;//验证码
@property (nonatomic, strong)UITextField *verityField;//输入验证码

@end
