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
    cell.hideTopLine = indexPath.row == 0;
    
    return cell;
}

+ (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

@end
