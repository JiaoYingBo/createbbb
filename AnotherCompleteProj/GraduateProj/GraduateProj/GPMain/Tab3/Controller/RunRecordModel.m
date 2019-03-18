//
//  RunRecordModel.m
//  GraduateProj
//
//  Created by 焦英博 on 2019/3/16.
//  Copyright © 2019 mlg. All rights reserved.
//

#import "RunRecordModel.h"

@implementation RunRecordModel

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_lineGroupArray forKey:@"_lineGroupArray"];
    [aCoder encodeObject:_lineTempArray forKey:@"_lineTempArray"];
    [aCoder encodeObject:_dataArray forKey:@"_dataArray"];
    [aCoder encodeObject:_startRunDate forKey:@"_startRunDate"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        _lineGroupArray = [aDecoder decodeObjectForKey:@"_lineGroupArray"];
        _lineTempArray = [aDecoder decodeObjectForKey:@"_lineTempArray"];
        _dataArray = [aDecoder decodeObjectForKey:@"_dataArray"];
        _startRunDate = [aDecoder decodeObjectForKey:@"_startRunDate"];
    }
    return self;
}

@end
