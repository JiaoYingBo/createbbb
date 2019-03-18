//
//  MyAnnotation.h
//  百度地图轨迹
//
//  Created by 邬志成 on 2016/11/22.
//  Copyright © 2016年 邬志成. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Map/BMKAnnotationView.h>

typedef NS_ENUM(NSUInteger, MyAnnotationType) {
    MyAnnotationTypeNormal = 0,
    MyAnnotationTypeGo     = 1,
    MyAnnotationTypeEnd    = 2,
};

@interface MyAnnotation : BMKAnnotationView

@property (nonatomic, weak) UIView *bgView;
@property (nonatomic, weak) UIImageView *bgImage;
@property (nonatomic, assign) MyAnnotationType type;

@end
