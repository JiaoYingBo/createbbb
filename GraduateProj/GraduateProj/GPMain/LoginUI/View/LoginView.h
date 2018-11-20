//
//  LoginView.h
//  GraduateProj
//
//  Created by 焦英博 on 2018/11/19.
//  Copyright © 2018年 mlg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginView : UIView

@property (nonatomic, strong) UIImageView *bgImgView;
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) UITextField *userNameTf;
@property (nonatomic, strong) UITextField *passwordTf;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, copy) void(^loginClick)(NSUInteger type, NSString *username, NSString *pwd);

@end
