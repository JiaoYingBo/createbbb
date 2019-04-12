//
//  CHKTagViewItem.m
//  CHKTagView
//
//  Created by Hongkai Cui on 2017/11/23.
//  Copyright © 2017年 崔洪凯. All rights reserved.
//

#import "CHKTagViewItem.h"

@implementation CHKTagViewItem

+ (instancetype)buttonWithType:(UIButtonType)buttonType frame:(CGRect)frame itemTitle:(NSString *)title itemStyle:(CHKTagViewItemStyle *)itemStyle {
    CHKTagViewItem *item = [CHKTagViewItem buttonWithType:buttonType];
    
    [item addTarget:item action:@selector(chk_tagViewItemTapAction) forControlEvents:UIControlEventTouchUpInside];
    
    [item setTitleColor:itemStyle.textColorNormal forState:UIControlStateNormal];
    [item setTitleColor:itemStyle.textColorSelected forState:UIControlStateSelected];
    
    item.layer.cornerRadius = itemStyle.cornerraduis;
    item.titleLabel.font = [UIFont systemFontOfSize:itemStyle.fontSize];
    item.layer.borderWidth = itemStyle.borderWidth;
    item.backgroundColor = item.selected ? itemStyle.backgroundColorSelected : itemStyle.backgroundColorNormal;
    
    item.frame = frame;
    item.style = itemStyle;
    item.tagName = title;
    
    return item;
}

- (void)setTagName:(NSString *)tagName {
    _tagName = tagName;
    
    [self setTitle:tagName forState:UIControlStateNormal];
    [self setItemMargin];
    
}

- (void)chk_tagViewItemTapAction {
    self.selected = !self.selected;
    
    if (self.tagViewItemTapAction) {
        self.tagViewItemTapAction(self);
    }
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    if (selected) {
        self.layer.borderColor = self.style.borderColorSelected.CGColor;
        self.backgroundColor = self.style.backgroundColorSelected;
    } else {
        self.layer.borderColor = self.style.borderColorNormal.CGColor;
        self.backgroundColor = self.style.backgroundColorNormal;
    }
}

- (void)setItemMargin {
    CGFloat height = self.frame.size.height;
    [self sizeToFit];
    CGRect frame = self.frame;
    frame.size.width += self.style.fontMarginHorizontal * 2;
    frame.size.height = height > frame.size.height + self.style.fontMarginVertical * 2 ? height : frame.size.height + self.style.fontMarginVertical * 2;
    self.frame = frame;
}





@end
