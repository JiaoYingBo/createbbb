//
//  ZiCeData.m
//  GraduateProj
//
//  Created by 焦英博 on 2018/12/9.
//  Copyright © 2018 mlg. All rights reserved.
//

#import "ZiCeData.h"

@implementation ZiCeData

+ (JiLuCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JiLuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"jilu"];
    if (!cell) {
        cell = [[JiLuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"jilu"];
    }
    
    return cell;
}

+ (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

@end