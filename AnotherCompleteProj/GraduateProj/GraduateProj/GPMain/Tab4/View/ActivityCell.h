//
//  ActivityCell.h
//  GraduateProj
//
//  Created by jay on 2019/2/18.
//  Copyright © 2019 mlg. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ActivityCell : UITableViewCell

@property(nonatomic,strong)UIImageView *localImage;
@property(nonatomic,strong)UILabel *loacalLabel;
@property(nonatomic,strong)UIImageView *detailImage;
@property(nonatomic,strong)UILabel *detailLabel;
@property(nonatomic,strong)UIImageView *timeImage;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UIImageView *personImage;
@property(nonatomic,strong)UILabel *personLabel;
@property(nonatomic,strong)UILabel *statusLabel;
@property(nonatomic,strong)UILabel *followerLabel;
@property(nonatomic,strong)UIButton *addBtn;

@property (nonatomic, copy) void(^addClick)(void);

@end

NS_ASSUME_NONNULL_END
