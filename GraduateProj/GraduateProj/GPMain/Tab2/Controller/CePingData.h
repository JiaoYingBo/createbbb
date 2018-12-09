//
//  CePingData.h
//  GraduateProj
//
//  Created by 焦英博 on 2018/12/9.
//  Copyright © 2018 mlg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CePingCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface CePingData : NSObject

+ (CePingCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
+ (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
