//
//  CHKTagView.h
//  CHKTagView
//
//  Created by Hongkai Cui on 2017/11/23.
//  Copyright © 2017年 崔洪凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHKTagViewItem.h"

@class CHKTagView;

@protocol CHKTagViewDelegate <NSObject>

- (void)chk_tagView:(CHKTagView *)tagView didSelectItemAtIndex:(NSInteger)index;

@end

@interface CHKTagView : UIView

@property (nonatomic, strong) NSArray *tagNames;
@property (nonatomic, assign) UIEdgeInsets padding;
@property (nonatomic, assign) CGFloat itemHeight;
@property (nonatomic, assign) BOOL canMultiSelect;

@property (nonatomic,weak) id<CHKTagViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame tagNames:(NSArray *)names tagItemStyle:(CHKTagViewItemStyle *)style;

@end
