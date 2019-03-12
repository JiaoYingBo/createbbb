//
//  MyAnnotation.h
//  百度地图轨迹
//
//  Created by 邬志成 on 2016/11/22.
//  Copyright © 2016年 邬志成. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Map/BMKAnnotationView.h>

@interface MyAnnotation : BMKAnnotationView

/** 图片 */
@property (nonatomic,weak) UIImageView *bgImage;

@end
