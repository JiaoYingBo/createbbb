//
//  StudentModel.h
//  GraduateProj
//
//  Created by jay on 2018/12/18.
//  Copyright © 2018 mlg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface StudentModel : NSObject

@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *number;
@property (nonatomic,copy)NSString *grade;
@property (nonatomic,copy)NSString *score;

+(instancetype)StudentModelWithDict:(NSDictionary*)dict;
-(instancetype)initWithDict:(NSDictionary*)dict;

@end

NS_ASSUME_NONNULL_END
