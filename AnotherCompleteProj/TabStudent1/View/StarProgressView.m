//
//  StarProgressView.m
//  GraduateProj
//
//  Created by jay on 2018/11/21.
//  Copyright © 2018 mlg. All rights reserved.
//

#import "StarProgressView.h"




@implementation StarProgressView

// 1.重写initWithFrame:方法，创建子控件并添加到自己上面
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        // 1.
        UILabel *titleLab = [UILabel new];
        self.titleLabel = titleLab;
        self.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.backgroundColor = [UIColor colorWithRed:0/255.0f green:205/255.0f blue:133/255.0f alpha:1];;//bg
        [self addSubview:self.titleLabel];
        
        
    }
    return self;
}

// 2.重写layoutSubviews，给自己内部子控件设置frame
- (void)layoutSubviews {
    [super layoutSubviews];
    
    float size = self.frame.size.width*2/5;
    self.titleLabel.frame = CGRectMake(10, 0, size , 30);
    
    float starWidth = 16;//星星大小暂定16
    
    for (int i = 0; i<5; i++) {
        UIImageView * starImagView = [[UIImageView alloc] init];
        
        starImagView.frame = CGRectMake(size+15+i*(starWidth+15), 7, starWidth, starWidth);
        starImagView.backgroundColor = [UIColor clearColor];
        if (i<_starNumber) {
            starImagView.image = [UIImage imageNamed:@"allStar1"];
        }else{
            starImagView.image = [UIImage imageNamed:@"emptyStar1"];
        }
        [self addSubview:starImagView];
    }
    
}

@end
