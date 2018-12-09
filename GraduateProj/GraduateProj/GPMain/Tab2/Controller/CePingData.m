//
//  CePingData.m
//  GraduateProj
//
//  Created by 焦英博 on 2018/12/9.
//  Copyright © 2018 mlg. All rights reserved.
//

#import "CePingData.h"

@implementation CePingData

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

+ (NSArray *)nameArray {
    return @[@"身高", @"体重", @"肺活量", @"50米跑", @"坐位体前屈", @"立定跳远", @"引体向上", @"1000米跑"];
}

+ (NSArray *)contentArray {
    return @[@"180.3", @"71", @"2000", @"11.2", @"20.5", @"2.6", @"12", @"3"];
}

+ (NSArray *)unitArray {
    return @[@"厘米", @"公斤", @"毫升", @"秒", @"厘米", @"米", @"次", @"分"];
}

@end
