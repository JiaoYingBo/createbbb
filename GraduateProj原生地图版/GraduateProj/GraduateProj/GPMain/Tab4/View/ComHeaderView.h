//
//  ComHeaderView.h
//  GraduateProj
//
//  Created by jay on 2019/1/15.
//  Copyright © 2019 mlg. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ComHeaderView : UIView

@property(nonatomic,strong)UILabel *daysLabel;
@property(nonatomic,strong)UILabel *allLabel;
@property(nonatomic,strong)UILabel *averageLabel;
@property(nonatomic,strong)UIView *lineView;
@property(nonatomic,strong)UIButton *diaryBtn;
@property(nonatomic,strong)UIButton *trainBtn;
@property(nonatomic,strong)UIButton *releaseBtn;



@end

NS_ASSUME_NONNULL_END
