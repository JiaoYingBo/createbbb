//
//  RunFileUtil.m
//  GraduateProj
//
//  Created by 焦英博 on 2019/3/16.
//  Copyright © 2019 mlg. All rights reserved.
//

#import "RunFileUtil.h"

@implementation RunFileUtil

#pragma mark - 文件存储
+ (void)saveRecordData:(NSData *)data {
    NSInteger number = [[[NSUserDefaults standardUserDefaults] objectForKey:RunRecordLocalStorageNumber] integerValue];
    NSString *path = [self filePathWithNumber:number];
    [data writeToFile:path atomically:NO];
    number ++;
    [[NSUserDefaults standardUserDefaults] setInteger:number forKey:RunRecordLocalStorageNumber];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)deleteAllRecordDatas {
    NSInteger number = [[[NSUserDefaults standardUserDefaults] objectForKey:RunRecordLocalStorageNumber] integerValue];
    for (NSInteger i = 0; i < number; i ++) {
        [self deleteFileWithNumber:number];
    }
}

+ (void)deleteFileWithNumber:(NSInteger)number {
    NSString *path = [self filePathWithNumber:number];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    }
}

+ (BOOL)hasFileWithNumber:(NSInteger)number {
    if ([[NSFileManager defaultManager] fileExistsAtPath:[self filePathWithNumber:number]]) {
        return YES;
    }
    return NO;
}

+ (NSData *)getRecordDataWithNumber:(NSInteger)number {
    return [NSData dataWithContentsOfFile:[self filePathWithNumber:number]];
}

+ (NSString *)filePathWithNumber:(NSInteger)number {
    NSString *path = [NSString stringWithFormat:@"Documents/RunRecordList%td.plist", number];
    return [NSHomeDirectory() stringByAppendingPathComponent:path];
}

+ (nullable NSArray<NSData *> *)getAllRecordFiles {
    NSInteger number = [[[NSUserDefaults standardUserDefaults] objectForKey:RunRecordLocalStorageNumber] integerValue];
    NSMutableArray *files = @[].mutableCopy;
    for (NSInteger i = 0; i < number; i ++) {
        NSData *data = [self getRecordDataWithNumber:i];
        if (data) {
            [files addObject:data];
        }
    }
    return files;
}

@end
