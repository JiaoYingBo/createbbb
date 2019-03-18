//
//  ZiCeData.m
//  GraduateProj
//
//  Created by 焦英博 on 2018/12/9.
//  Copyright © 2018 mlg. All rights reserved.
//

#import "ZiCeData.h"
#import "TestRecordVC.h"

@implementation ZiCeData

+ (JiLuCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JiLuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"jilu"];
    if (!cell) {
        cell = [[JiLuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"jilu"];
    }
    
    return cell;
}

+ (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 13;
}

+ (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

+ (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self alertShow];
}

//--
+ (void)navigationController:(UINavigationController*)navigation tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TestRecordVC *vc = [[TestRecordVC alloc] init];
    vc.currentWeight = (int)indexPath.row;
    [navigation pushViewController:vc animated:YES];
}

+ (void)alertShow {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"你这成绩已经废了！" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okAction];
    dispatch_async(dispatch_get_main_queue(), ^{
        [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:alert animated:YES completion:nil];
    });
}

@end
