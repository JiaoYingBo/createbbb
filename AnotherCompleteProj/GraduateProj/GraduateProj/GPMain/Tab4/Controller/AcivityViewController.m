//
//  AcivityViewController.m
//  GraduateProj
//
//  Created by jay on 2019/1/16.
//  Copyright © 2019 mlg. All rights reserved.
//

#import "AcivityViewController.h"
#import "WSDatePickerView.h"

@interface AcivityViewController ()

@end

@implementation AcivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kColor(0, 191, 242, 1);
    [self configUI];
}
- (void)configUI{
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    startBtn.backgroundColor = kColor(0, 191, 242, 1);
    [startBtn setTitle:@"请选择活动开始时间" forState:UIControlStateNormal];
    startBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    startBtn.layer.borderWidth = 2;
    startBtn.layer.cornerRadius = 5;
    startBtn.layer.masksToBounds = YES;
    [startBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:startBtn];
    [startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(64+20);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.mas_equalTo(50);
    }];
    
    UIButton *endBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    endBtn.backgroundColor = kColor(0, 189, 240, 1);
    [endBtn setTitle:@"请选择活动结束时间" forState:UIControlStateNormal];
    endBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    endBtn.layer.borderWidth = 2;
    endBtn.layer.cornerRadius = 5;
    endBtn.layer.masksToBounds = YES;
    [endBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [endBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:endBtn];
    [endBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(startBtn.mas_bottom).offset(20);
        make.left.equalTo(startBtn.mas_left);
        make.right.equalTo(startBtn.mas_right);
        make.height.mas_equalTo(50);
    }];
    
    UILabel *addressLabel = [[UILabel alloc] init];
    addressLabel.text = @"活动地址 :";
    addressLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:addressLabel];
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(endBtn.mas_bottom).offset(20);
        make.left.equalTo(startBtn.mas_left);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(30);
    }];
    
    
    UITextView *addTextView = [[UITextView alloc] init];
    addTextView.font = [UIFont systemFontOfSize:18];
    addTextView.backgroundColor = kColor(236, 236, 236, 1);
    [self.view addSubview:addTextView];
    [addTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addressLabel.mas_top);
        make.left.equalTo(addressLabel.mas_right).offset(20);
        make.right.equalTo(startBtn.mas_right);
        make.height.mas_equalTo(100);
    }];
    
    UILabel *aLabel = [[UILabel alloc] init];
    aLabel.text = @"活动内容 :";
    aLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:aLabel];
    [aLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addTextView.mas_bottom).offset(20);
        make.left.equalTo(startBtn.mas_left);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(30);
    }];
    
    UITextView *aTextView = [[UITextView alloc] init];
    aTextView.font = [UIFont systemFontOfSize:18];
    aTextView.backgroundColor = kColor(236, 236, 236, 1);
    [self.view addSubview:aTextView];
    [aTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(aLabel.mas_top);
        make.left.equalTo(aLabel.mas_right).offset(20);
        make.right.equalTo(startBtn.mas_right);
        make.height.mas_equalTo(100);
    }];
    //submit
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.backgroundColor = kColor(0, 180, 231, 1);
    [submitBtn setTitle:@"发布" forState:UIControlStateNormal];
    submitBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    submitBtn.layer.borderWidth = 2;
    submitBtn.layer.cornerRadius = 5;
    submitBtn.layer.masksToBounds = YES;
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:submitBtn];
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(aTextView.mas_bottom).offset(20);
        make.left.equalTo(startBtn.mas_left);
        make.right.equalTo(startBtn.mas_right);
        make.height.mas_equalTo(50);
    }];
}
- (void)submitAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)selectAction:(UIButton *)sender{
    //年-月-日-时-分
    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDayHourMinute CompleteBlock:^(NSDate *selectDate) {
        
        NSString *dateString = [selectDate stringWithFormat:@"yyyy-MM-dd HH:mm"];
        NSLog(@"选择的日期：%@",dateString);
        [sender setTitle:dateString forState:UIControlStateNormal];
    }];
    datepicker.dateLabelColor = kColor(0, 191, 242, 1);//年-月-日-时-分 颜色
    datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
    datepicker.doneButtonColor = kColor(0, 191, 242, 1);//确定按钮的颜色
    [datepicker show];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
