//
//  showCell.h
//  GraduateProj
//
//  Created by jay on 2019/1/10.
//  Copyright © 2019 mlg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "customShowView.h"

NS_ASSUME_NONNULL_BEGIN

@interface showCell : UITableViewCell

@property(nonatomic,strong)customShowView *frontView;
@property(nonatomic,strong)customShowView *rearView;

@end

NS_ASSUME_NONNULL_END
