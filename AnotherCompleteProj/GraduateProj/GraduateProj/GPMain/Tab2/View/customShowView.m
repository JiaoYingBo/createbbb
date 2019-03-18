//
//  customShowView.m
//  GraduateProj
//
//  Created by jay on 2019/1/10.
//  Copyright © 2019 mlg. All rights reserved.
//

#import "customShowView.h"

@implementation customShowView


- (instancetype)init{
    if (self == [super init]) {
        self.triangleImage = [[UIImageView alloc] init];
        self.triangleImage.image = [UIImage imageNamed:@"sanjiaoxing-2"];
        //self.triangleImage.backgroundColor = [UIColor redColor];
        [self addSubview:self.triangleImage];
        
        self.scoreLabel = [[UILabel alloc] init];
        //self.scoreLabel.backgroundColor = [UIColor yellowColor];
        self.scoreLabel.numberOfLines = 2;
        self.scoreLabel.adjustsFontSizeToFitWidth = YES;
        self.scoreLabel.text = @"体重:\n89分";
        self.scoreLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.scoreLabel];
        
        self.rankLabel = [[UILabel alloc] init];
        self.rankLabel.font = [UIFont systemFontOfSize:10];
        self.rankLabel.text = @"优秀";
        self.rankLabel.textColor = kColor(236, 236, 236, 1);
        //self.rankLabel.backgroundColor = [UIColor greenColor];
        [self addSubview:self.rankLabel];
        
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.triangleImage.frame = CGRectMake(self.bounds.size.width-50, 0, 50, 50);
    self.scoreLabel.frame = CGRectMake(0, 0, self.bounds.size.width-50, self.bounds.size.height);
    self.rankLabel.frame = CGRectMake(self.bounds.size.width-25, 0, 25, 25);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
