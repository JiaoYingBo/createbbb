//
//  RunCountView.m
//  GraduateProj
//
//  Created by 焦英博 on 2019/3/10.
//  Copyright © 2019 mlg. All rights reserved.
//

#import "RunCountView.h"

@interface RunCountView ()

@property (nonatomic, strong) UIView *gps1;
@property (nonatomic, strong) UIView *gps2;
@property (nonatomic, strong) UIView *gps3;
@property (nonatomic, strong) UIImageView *detailImg;

@end

@implementation RunCountView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configUI];
        self.GPSStrength = 0;
    }
    return self;
}

- (void)setGPSStrength:(NSInteger)GPSStrength {
    _GPSStrength = GPSStrength;
    // 0:无效 1:弱 2:强 3:超强
    UIColor *gray = kColor(230, 230, 250, 1);
    UIColor *green = kColor(78, 176, 11, 1);
    if (GPSStrength == 0) {
        self.gps1.backgroundColor = gray;
        self.gps2.backgroundColor = gray;
        self.gps3.backgroundColor = gray;
    } else if (GPSStrength == 1) {
        self.gps1.backgroundColor = green;
        self.gps2.backgroundColor = gray;
        self.gps3.backgroundColor = gray;
    } else if (GPSStrength == 2) {
        self.gps1.backgroundColor = green;
        self.gps2.backgroundColor = green;
        self.gps3.backgroundColor = gray;
    } else if (GPSStrength == 3) {
        self.gps1.backgroundColor = green;
        self.gps2.backgroundColor = green;
        self.gps3.backgroundColor = green;
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.userInteractionEnabled = YES;
    });
    if (self.delegate) {
        [self.delegate didClickedRunCountView:self];
    }
}

- (void)configUI {
    self.backgroundColor = [UIColor clearColor];
    
    UIView *bgView = [UIView new];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 17;
    bgView.layer.shadowOpacity = 0.7;
    bgView.layer.shadowOffset = CGSizeMake(0, 1);
    bgView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    UILabel *countLab = [UILabel new];
    countLab.text = @"总次数";
    countLab.textColor = [UIColor grayColor];
    countLab.font = [UIFont systemFontOfSize:13];
    [self addSubview:countLab];
    [countLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.top.equalTo(self).offset(20);
    }];
    
    self.countLabel = [UILabel new];
    self.countLabel.text = @"0";
    self.countLabel.textColor = kColor(21, 144, 252, 1);
    self.countLabel.font = [UIFont boldSystemFontOfSize:34];
    [self addSubview:self.countLabel];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(countLab);
        make.top.equalTo(countLab.mas_bottom).offset(7);
    }];
    
    UILabel *mileageLab = [UILabel new];
    mileageLab.text = @"总里程（km）";
    mileageLab.textColor = [UIColor grayColor];
    mileageLab.font = [UIFont systemFontOfSize:13];
    [self addSubview:mileageLab];
    [mileageLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(countLab);
        make.right.equalTo(self).offset(-20);
    }];
    
    self.mileageLabel = [UILabel new];
    self.mileageLabel.text = @"0.00";
    self.mileageLabel.textColor = kColor(21, 144, 252, 1);
    self.mileageLabel.font = [UIFont boldSystemFontOfSize:34];
    [self addSubview:self.mileageLabel];
    [self.mileageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.countLabel);
        make.right.equalTo(mileageLab).offset(-3);
    }];
    
    UIView *line1 = [UIView new];
    line1.backgroundColor = kColor(200, 200, 200, 1);
    [self addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(-30);
        make.height.mas_equalTo(0.5);
    }];
    
    // 绿色：78, 176, 11
    self.gps1 = [UIView new];
    self.gps1.backgroundColor = kColor(78, 176, 11, 1);
    [self addSubview:self.gps1];
    [self.gps1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(countLab).offset(3);
        make.bottom.equalTo(self).offset(-10);
        make.width.mas_equalTo(3);
        make.height.mas_equalTo(6);
    }];
    self.gps2 = [UIView new];
    self.gps2.backgroundColor = kColor(78, 176, 11, 1);
    [self addSubview:self.gps2];
    [self.gps2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.gps1.mas_right).offset(2);
        make.bottom.equalTo(self.gps1);
        make.width.mas_equalTo(3);
        make.height.mas_equalTo(9);
    }];
    self.gps3 = [UIView new];
    self.gps3.backgroundColor = kColor(78, 176, 11, 1);
    [self addSubview:self.gps3];
    [self.gps3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.gps2.mas_right).offset(2);
        make.bottom.equalTo(self.gps1);
        make.width.mas_equalTo(3);
        make.height.mas_equalTo(12);
    }];
    
    UILabel *gpsLab = [UILabel new];
    gpsLab.text = @"GPS";
    gpsLab.textColor = [UIColor lightGrayColor];
    gpsLab.font = [UIFont systemFontOfSize:14];
    [self addSubview:gpsLab];
    [gpsLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.gps3);
        make.left.equalTo(self.gps3).offset(8);
    }];
    
    self.detailImg = [[UIImageView alloc] init];
    self.detailImg.image = [UIImage imageNamed:@"run-next"];
    [self addSubview:self.detailImg];
    [self.detailImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20);
        make.centerY.equalTo(gpsLab);
        make.width.height.mas_equalTo(18);
    }];
}

@end
