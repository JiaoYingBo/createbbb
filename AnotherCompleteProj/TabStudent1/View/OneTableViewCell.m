//
//  OneTableViewCell.m
//  GraduateProj
//
//  Created by jay on 2018/11/19.
//  Copyright © 2018 mlg. All rights reserved.
//

#import "OneTableViewCell.h"

#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
//自定义绿色
#define MY_GREEN [UIColor colorWithRed:0/255.0f green:205/255.0f blue:133/255.0f alpha:1]


@implementation OneTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //布局cell内部控件
        [self setupUI];
    }
    return self;
}
- (void)setupUI{
    //设置cell背景颜色
    self.contentView.backgroundColor = [UIColor colorWithRed:244/255.f green:244/255.f blue:244/255.f alpha:1];
    //背景view
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, SCREEN_SIZE.width-20, 80)];
    self.bgView.backgroundColor  =[UIColor whiteColor];
    self.bgView.layer.cornerRadius = 5;
    self.bgView.layer.masksToBounds = YES;
    
    //首先去除 bgview两边的20；小圆点+间隔 dotWidth; 剩下的宽度restWidth;
    float bgViewWidth = SCREEN_SIZE.width-20;
    float dotWidth = 30;
    float restWidth = bgViewWidth-dotWidth;
    
   //前面的图标 ,图片先不要，换成小圆点
    //y:(80-10)/2
    self.frontImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 35, 10, 10)];
    self.frontImage.layer.cornerRadius = 5;
    self.frontImage.layer.masksToBounds = YES;
    
    self.frontImage.backgroundColor = MY_GREEN;//bg
  
    //指标label(身高，体重)+20
    self.proLable = [[UILabel alloc] initWithFrame:CGRectMake(dotWidth, 0, restWidth/2, 80)];
    self.proLable.textAlignment = NSTextAlignmentLeft;
    self.proLable.textColor = MY_GREEN;
    self.proLable.font = [UIFont systemFontOfSize:22];
    //self.proLable.backgroundColor = [UIColor redColor];//bg
    
    
    //等级label：优秀 良好
    self.rangeLable = [[UILabel alloc] initWithFrame:CGRectMake(dotWidth+restWidth/2, 0, restWidth/4, 80)];
    self.rangeLable.textAlignment = NSTextAlignmentCenter;
    self.rangeLable.textColor = MY_GREEN;
    self.rangeLable.font = [UIFont systemFontOfSize:22];
    //self.rangeLable.backgroundColor = [UIColor blueColor];//bg
    
    
    //分数label-20
    self.gradeLabel = [[UILabel alloc] initWithFrame:CGRectMake(dotWidth+restWidth*3/4, 0, restWidth/4, 80)];
    self.gradeLabel.textAlignment = NSTextAlignmentRight;
    self.gradeLabel.textColor = MY_GREEN;
    self.gradeLabel.font = [UIFont systemFontOfSize:22];
    //self.gradeLabel.backgroundColor = [UIColor blackColor];//bg

    [self.bgView addSubview:self.frontImage];
    [self.bgView addSubview:self.proLable];
    [self.bgView addSubview:self.rangeLable];
    [self.bgView addSubview:self.gradeLabel];
    
    [self.contentView addSubview:self.bgView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
