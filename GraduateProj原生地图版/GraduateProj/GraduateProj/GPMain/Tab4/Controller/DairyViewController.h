//
//  DairyViewController.h
//  GraduateProj
//
//  Created by jay on 2019/1/16.
//  Copyright © 2019 mlg. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DairyViewController : UIViewController

@property(nonatomic,copy)NSString *timeStr;
@property(nonatomic,copy) void (^dairyBlock) (NSString *str);



@end

NS_ASSUME_NONNULL_END
