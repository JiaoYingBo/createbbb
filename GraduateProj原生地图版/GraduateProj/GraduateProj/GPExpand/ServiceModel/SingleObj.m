//
//  SingleObj.m
//  GraduateProj
//
//  Created by jay on 2019/2/19.
//  Copyright © 2019 mlg. All rights reserved.
//

#import "SingleObj.h"

static SingleObj *_obj;

@implementation SingleObj

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_obj == nil) {
            _obj = [super allocWithZone:zone];
        }
    });
    return _obj;
}
+ (instancetype)share{
    return [[self alloc] init];
}
- (id)copyWithZone:(NSZone *)zone{
    return [SingleObj share];
}
- (id)mutableCopyWithZone:(NSZone *)zone{
    return [SingleObj share];
}
@end
