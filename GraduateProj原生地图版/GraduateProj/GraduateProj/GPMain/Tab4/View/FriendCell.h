//
//  FriendCell.h
//  GraduateProj
//
//  Created by jay on 2019/1/14.
//  Copyright © 2019 mlg. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FriendCell : UITableViewCell

@property (nonatomic,strong)UIImageView *headImageView;//头像
@property (nonatomic,strong)UILabel *nameLabel;//姓名
@property (nonatomic,strong)UILabel *timeLabel;//发布时间
@property (nonatomic,strong)UIImageView *clockImage;//钟表图片
@property (nonatomic,strong)UIView *lineView;//中间横线
@property (nonatomic,strong)UILabel *wordsLabel;//内容
@property (nonatomic,strong)UILabel *goodLabel;//♥️赞的次数
@property (nonatomic,strong)UIButton *goodButton;//点赞按钮
@property (nonatomic,strong)UIButton *commentButton;//评论按钮
@property (nonatomic,strong)UILabel *comCount;//评论数

@property (nonatomic, copy) void(^goodClick)(void);
@property (nonatomic, copy) void(^commentClick)(void);


//自定义block方法
- (void)handlerButtonAction:(void(^)(void))block;

@end

NS_ASSUME_NONNULL_END
