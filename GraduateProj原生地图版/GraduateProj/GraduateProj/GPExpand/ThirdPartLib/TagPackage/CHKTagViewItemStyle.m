//
//  CHKTagViewItemStyle.m
//  CHKTagView
//
//  Created by Hongkai Cui on 2017/11/23.
//  Copyright © 2017年 崔洪凯. All rights reserved.
//

#import "CHKTagViewItemStyle.h"

@implementation CHKTagViewItemStyle

- (instancetype)initWithType:(CHKTagViewItemStyleType)type
{
    self = [super init];
    if (self) {
        switch (type) {
            case CHKTagViewItemStyleTypeDefault:
            {
                self.textColorNormal = COLOR_WITH_HEX(0x888888);
                self.textColorSelected = COLOR_WITH_HEX(0xef0f1a);
                self.backgroundColorNormal = [UIColor whiteColor];
                self.backgroundColorSelected = COLOR_WITH_HEX(0xfef1f2);
                self.borderColorNormal = self.textColorNormal;
                self.borderColorSelected = self.textColorSelected;
                self.borderWidth = 0.5;
                self.cornerraduis = 17;
                self.fontSize = 14;
                self.fontMarginVertical = 0;
                self.fontMarginHorizontal = 10;
            }
                break;
            case CHKTagViewItemStyleTypeCustom:
            {
                
            }
                break;
                
            default:
                break;
        }
    }
    return self;
}

@end
