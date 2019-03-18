//
//  CHKTagViewItem.h
//  CHKTagView
//
//  Created by Hongkai Cui on 2017/11/23.
//  Copyright © 2017年 崔洪凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHKTagViewItemStyle.h"

@interface CHKTagViewItem : UIButton

@property (nonatomic,copy) NSString *tagName;

@property (nonatomic,strong) CHKTagViewItemStyle *style;

@property (nonatomic,copy) void(^tagViewItemTapAction)(CHKTagViewItem *);

+ (instancetype)buttonWithType:(UIButtonType)buttonType frame:(CGRect)frame itemTitle:(NSString *)title itemStyle:(CHKTagViewItemStyle *)itemStyle;

@end
