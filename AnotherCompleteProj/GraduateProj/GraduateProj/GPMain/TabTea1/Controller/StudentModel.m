//
//  StudentModel.m
//  GraduateProj
//
//  Created by jay on 2018/12/18.
//  Copyright © 2018 mlg. All rights reserved.
//

#import "StudentModel.h"

@implementation StudentModel

+(instancetype)StudentModelWithDict:(NSDictionary*)dict
{
    return [[self alloc]initWithDict:dict];
}

-(instancetype)initWithDict:(NSDictionary*)dict
{
    if(self= [super init]) {
        self.name= dict[@"name"];
        self.grade= dict[@"grade"];
        self.number= dict[@"number"];
        self.score= dict[@"score"];
    }
    return self;
}

@end
