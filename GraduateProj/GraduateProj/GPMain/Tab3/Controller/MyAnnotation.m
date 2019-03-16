//
//  MyAnnotation.m
//  百度地图轨迹
//
//  Created by 邬志成 on 2016/11/22.
//  Copyright © 2016年 邬志成. All rights reserved.
//

#import "MyAnnotation.h"

@implementation MyAnnotation

- (id)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.frame = CGRectMake(0, 0, 20, 20);
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        bgView.layer.cornerRadius = 10;
        bgView.layer.shadowOpacity = 1;
        bgView.layer.shadowOffset = CGSizeMake(0, 0);
        bgView.layer.shadowColor = [UIColor grayColor].CGColor;
        bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bgView];
        self.bgView = bgView;
        
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circleyuanquan"]];
        imgView.frame = CGRectMake(0, 0, 15, 15);
        imgView.center = self.center;
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        _bgImage = imgView;
        self.paopaoView = nil;
        [self addSubview:imgView];
    }
    return self;
}

- (void)setType:(MyAnnotationType)type {
    _type = type;
    if (type == MyAnnotationTypeGo) {
        self.bgImage.image = [UIImage imageNamed:@"start"];
        self.bgImage.frame = CGRectMake(0, 0, 20, 20);
        self.bgView.hidden = YES;
    } else if (type == MyAnnotationTypeEnd) {
        self.bgImage.image = [UIImage imageNamed:@"end"];
        self.bgImage.frame = CGRectMake(0, 0, 20, 20);
        self.bgView.hidden = YES;
    } else {
        self.bgImage.image = [UIImage imageNamed:@"circleyuanquan"];
        self.bgImage.frame = CGRectMake(0, 0, 15, 15);
        self.bgImage.center = self.center;
        self.bgView.hidden = NO;
    }
}

@end
