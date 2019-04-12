//
//  CHKTagView.m
//  CHKTagView
//
//  Created by Hongkai Cui on 2017/11/23.
//  Copyright © 2017年 崔洪凯. All rights reserved.
//

#import "CHKTagView.h"

@interface CHKTagView ()

@property (nonatomic, strong) NSMutableArray <CHKTagViewItem *>*items;
@property (nonatomic, strong) CHKTagViewItemStyle *style;

@end

@implementation CHKTagView


- (instancetype)initWithFrame:(CGRect)frame tagNames:(NSArray *)names tagItemStyle:(CHKTagViewItemStyle *)style
{
    self = [super initWithFrame:frame];
    if (self) {
        self.style = style;
        self.tagNames = names;
        [self chk_tagViewSelectAtIndex:0];
    }
    return self;
}

- (void)setTagNames:(NSArray *)tagNames {
    _tagNames = tagNames;
    
    CGFloat x = self.padding.left;
    CGFloat y = self.padding.top;
    CGFloat marginH = 15;
    CGFloat marginV = 15;
    
    NSInteger count = tagNames.count < self.items.count ? self.items.count : tagNames.count;
    
    for (int i = 0; i < count; i++) {
        CHKTagViewItem *item = nil;
        if (i < self.items.count) {
            item.frame = CGRectMake(x, y, 100, self.itemHeight);
            item = self.items[i];
            item.hidden = NO;
            item.tagName = tagNames[i];
        } else if (i > tagNames.count) {
            item = self.items[i];
            item.hidden = YES;
        } else {
            item = [CHKTagViewItem buttonWithType:UIButtonTypeCustom frame:CGRectMake(x, y, 100, self.itemHeight) itemTitle:tagNames[i] itemStyle:self.style];
            [self.items addObject:item];
        }
        item.tag = 1000 + i;
        if (item) {
            __weak CHKTagView *weakSelf = self;
            item.tagViewItemTapAction = ^(CHKTagViewItem *tagItem) {
                if (!weakSelf.canMultiSelect) {
                    [weakSelf chk_tagViewSelectAtIndex:tagItem.tag - 1000];
                }
                if (weakSelf.delegate) {
                    [weakSelf.delegate chk_tagView:weakSelf didSelectItemAtIndex:(tagItem.tag - 1000)];
                }
            };
        }
        
        if (item.frame.origin.x + item.frame.size.width + marginH > self.frame.size.width) {
            y += marginV + item.frame.size.height;
            x = self.padding.left;
            item.frame = CGRectMake(x, y, item.frame.size.width, item.frame.size.height);
        }
        [self addSubview:item];
        x += item.frame.size.width + self.padding.right;
        
        if (i == tagNames.count - 1) {
            CGRect frame = self.frame;
            frame.size.height = item.frame.origin.y + item.frame.size.height + self.padding.bottom;
            self.frame = frame;
        }

    }
}

- (void)chk_tagViewSelectAtIndex:(NSInteger)index {
    for (int i = 0; i < self.items.count; i++) {
        self.items[i].selected = i == index;
    }
}


- (UIEdgeInsets)padding {
    if (_padding.top == 0 && _padding.left == 0 && _padding.bottom == 0 && _padding.right == 0) {
        _padding = UIEdgeInsetsMake(15, 11, 15, 11);
    }
    return _padding;
}

- (CGFloat)itemHeight {
    if (_itemHeight <= 0) {
        _itemHeight = 34;
    }
    return _itemHeight;
}


- (NSMutableArray <CHKTagViewItem *>*)items {
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}


@end
