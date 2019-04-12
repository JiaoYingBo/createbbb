//
//  IndexTableViewCell.m
//  GraduateProj
//
//  Created by jay on 2018/11/20.
//  Copyright © 2018 mlg. All rights reserved.
//

#import "IndexTableViewCell.h"

#define SCREEN_SIZE [UIScreen mainScreen].bounds.size

@implementation IndexTableViewCell

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
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, SCREEN_SIZE.width-20, 200)];
    self.bgView.backgroundColor  =[UIColor whiteColor];
    self.bgView.layer.cornerRadius = 5;
    self.bgView.layer.masksToBounds = YES;
    
    //设置展示label  高200  展示label高80
    self.showLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width-20, 80)];
    self.showLabel.textAlignment = NSTextAlignmentCenter;
    self.showLabel.font = [UIFont boldSystemFontOfSize:30];
    //self.showLabel.backgroundColor = [UIColor redColor];//bg
    self.showLabel.text = @"当前BMI值: 15.5";
    self.showLabel.textColor = [UIColor colorWithRed:0/255.0f green:205/255.0f blue:133/255.0f alpha:1];
    
    
    [self.bgView addSubview:self.showLabel];

    
    [self.contentView addSubview:self.bgView];
}
//设置frame的代码放在layoutsubview ，如果放在上面，数据还没传进来不起作用
- (void)layoutSubviews{
    [super layoutSubviews];
    //
    float bgWidth =[UIScreen mainScreen].bounds.size.width-20;
    float restWidth = bgWidth-100;//两边极值固定长度各50
    float totalWidth = [[self.dataArray lastObject] floatValue]-[self.dataArray[0] floatValue];//作为分母
    float segmentWidth = 50;
    float segmentX = 50;
    for (int i = 0; i<self.dataArray.count; i++) {
        //创建线段view
        UIView * lineView = [[UIView alloc] init];
        lineView.layer.cornerRadius = 3;
        lineView.layer.masksToBounds = YES;
        //创建线段下边的label
        UILabel * tagLabel = [[UILabel alloc] init];
        tagLabel.textAlignment = NSTextAlignmentCenter;
        tagLabel.textColor = [UIColor lightGrayColor];
        tagLabel.font = [UIFont systemFontOfSize:12];
        tagLabel.text = [self.cellDataArray objectAtIndex:i];
        //创建view上边的label
        UILabel * valueLabel = [[UILabel alloc] init];
        valueLabel.textAlignment = NSTextAlignmentCenter;
        valueLabel.textColor = [UIColor grayColor];
        valueLabel.font = [UIFont systemFontOfSize:15];
        valueLabel.text = [self.dataArray objectAtIndex:i];
        
        
        
        if (i == 0) {
            lineView.frame = CGRectMake(0, 135, segmentWidth, 10);
            lineView.backgroundColor = [UIColor orangeColor];
            
            tagLabel.frame = CGRectMake(0, 160, segmentWidth, 30);
           // tagLabel.backgroundColor = [UIColor yellowColor];
            
//            valueLabel.frame = CGRectMake(segmentX-30, 80, 60, 20);
//            valueLabel.backgroundColor = [UIColor redColor];
        }else{
            float upNumber =  [[self.dataArray objectAtIndex:i] floatValue]-[[self.dataArray objectAtIndex:i-1] floatValue];//作为分子
            segmentWidth = upNumber/totalWidth*restWidth;
            
            lineView.frame = CGRectMake(segmentX, 135, segmentWidth, 10);
            tagLabel.frame = CGRectMake(segmentX, 160, segmentWidth, 30);
            
            //tagLabel.backgroundColor = [UIColor colorWithRed:50*i/255.f green:30*i/255.f blue:10*i/255.f alpha:1];
            lineView.backgroundColor = [UIColor colorWithRed:100*(3-i)/255.f green:80*i/255.f blue:80*(3-i)/255.f alpha:1];
            
            segmentX +=segmentWidth;
//            valueLabel.frame = CGRectMake(segmentX-30, 80, 60, 20);
//            valueLabel.backgroundColor = [UIColor redColor];
        }
        valueLabel.frame = CGRectMake(segmentX-30, 95, 60, 20);
       // valueLabel.backgroundColor = [UIColor redColor];
        
        [self.bgView addSubview:valueLabel];
        [self.bgView addSubview:tagLabel];
        [self.bgView addSubview:lineView];
    }
    //补上最后一个label与lineview
    UIView * lineView = [[UIView alloc] init];
    lineView.frame = CGRectMake(segmentX, 135, 50, 10);
    lineView.backgroundColor = [UIColor purpleColor];
    lineView.layer.cornerRadius = 3;
    lineView.layer.masksToBounds = YES;
    
    UILabel * tagLabel = [[UILabel alloc] init];
     tagLabel.frame = CGRectMake(segmentX, 160, 50, 30);
    tagLabel.font = [UIFont systemFontOfSize:12];
    tagLabel.textAlignment = NSTextAlignmentCenter;
    tagLabel.textColor = [UIColor lightGrayColor];
    tagLabel.text = [self.cellDataArray objectAtIndex:self.cellDataArray.count-1];
  
    [self.bgView addSubview:lineView];
    [self.bgView addSubview:tagLabel];
    
    //这里显示我的坐标点
    float userValue = [self.currentValue floatValue]-[self.dataArray[0] floatValue];
    UIImageView * localView = [[UIImageView alloc] initWithFrame:CGRectMake(userValue/totalWidth*restWidth+50, 120, 16, 16)];
    localView.image = [UIImage imageNamed:@"daosanjiao"];
    localView.backgroundColor = [UIColor clearColor];
     [self.bgView addSubview:localView];
    NSLog(@"total:%f--rest:%f",totalWidth,restWidth);
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
