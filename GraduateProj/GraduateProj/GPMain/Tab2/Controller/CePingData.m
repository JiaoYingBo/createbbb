//
//  CePingData.m
//  GraduateProj
//
//  Created by 焦英博 on 2018/12/9.
//  Copyright © 2018 mlg. All rights reserved.
//

#import "CePingData.h"

#define PlaceHolder @"-"

@implementation CePingData
static NSMutableArray *_contentArray;

+ (CePingCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CePingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ceping"];
    if (!cell) {
        cell = [[CePingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ceping"];
    }
    cell.titleLabel.text = [self nameArray][indexPath.row];
    cell.numberLabel.text = [self contentArray][indexPath.row];
    cell.unitLabel.text = [self unitArray][indexPath.row];
    cell.hideTopLine = indexPath.row == 0;
    
    return cell;
}

+ (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self nameArray].count;
}

+ (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

+ (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title = [self nameArray][indexPath.row];
    NSString *content = [NSString stringWithFormat:@"单位：%@", [self unitArray][indexPath.row]];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:content preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入";
        textField.keyboardType = UIKeyboardTypeDecimalPad;
    }];
    __weak typeof(alertController) weakAlert = alertController;
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textField = weakAlert.textFields.firstObject;
        NSString *result = textField.text;
        NSLog(@"输入：%.2f",[result floatValue]);
        if ([result floatValue] <= 0) {
            [[self contentArray] replaceObjectAtIndex:indexPath.row withObject:PlaceHolder];
        } else {
            [[self contentArray] replaceObjectAtIndex:indexPath.row withObject:result];
        }
        [tableView reloadData];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    dispatch_async(dispatch_get_main_queue(), ^{
        [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:alertController animated:YES completion:nil];
    });
}

+ (NSArray *)nameArray {
    return @[@"身高", @"体重", @"肺活量", @"50米跑", @"坐位体前屈", @"立定跳远", @"引体向上", @"1000米跑"];
}

+ (NSMutableArray *)contentArray {
    if (!_contentArray) {
        _contentArray = @[].mutableCopy;
        for (int i = 0; i < [self nameArray].count; i ++) {
            [_contentArray addObject:PlaceHolder];
        }
    }
    return _contentArray;
}

+ (NSArray *)unitArray {
    return @[@"厘米", @"公斤", @"毫升", @"秒", @"厘米", @"米", @"次", @"秒"];
}

@end
