//
//  RunFileUtil.h
//  GraduateProj
//
//  Created by 焦英博 on 2019/3/16.
//  Copyright © 2019 mlg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RunFileUtil : NSObject

+ (void)saveRecordData:(NSData *)data;
+ (nullable NSArray<NSData *> *)getAllRecordFiles;
+ (void)deleteAllRecordDatas;
+ (void)deleteFileWithNumber:(NSInteger)number;

@end

NS_ASSUME_NONNULL_END
