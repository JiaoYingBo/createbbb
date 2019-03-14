//
//  CircleSpreadTransition.m
//  GraduateProj
//
//  Created by 焦英博 on 2019/3/10.
//  Copyright © 2019 mlg. All rights reserved.
//

#import "CircleSpreadTransition.h"
#import "Tab3ViewController.h"
#import <RTRootNavigationController.h>

@implementation CircleSpreadTransition

+ (instancetype)transitionWithTransitionType:(XWCircleSpreadTransitionType)type {
    return [[self alloc] initWithTransitionType:type];
}

- (instancetype)initWithTransitionType:(XWCircleSpreadTransitionType)type {
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    switch (_type) {
        case XWCircleSpreadTransitionTypePresent:
            [self presentAnimation:transitionContext];
            break;
            
        case XWCircleSpreadTransitionTypeDismiss:
            [self dismissAnimation:transitionContext];
            break;
        case XWCircleSpreadTransitionTypeNormal:
            [self normalDismissAnimation:transitionContext];
            break;
    }
}

- (void)normalDismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView *toView = nil;
    UIView *fromView = nil;
    UIView *transView = nil;
    
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    } else {
        fromView = fromViewController.view;
        toView = toViewController.view;
    }
    transView = fromView;
    [[transitionContext containerView] insertSubview:toView belowSubview:fromView];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    transView.frame = CGRectMake(0, 0, width, height);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        transView.frame = CGRectMake(0, height, width, height);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

- (void)dismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UINavigationController *toVC = (UINavigationController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UITabBarController *tabbar = ((RTContainerController *)toVC.viewControllers.firstObject).contentViewController;
    Tab3ViewController *temp = ((UINavigationController *)(tabbar.viewControllers[2])).viewControllers.lastObject;
    UIView *containerView = [transitionContext containerView];
    // 不使用UIModalPresentationCustom时，返回的时候toVC是空白的，因为系统回收了，所以需要手动放置一个toView
//    [[transitionContext containerView] insertSubview:temp.view belowSubview:fromVC.view];
    //画两个圆路径
    CGFloat radius = sqrtf(containerView.frame.size.height * containerView.frame.size.height + containerView.frame.size.width * containerView.frame.size.width) / 2;
    UIBezierPath *startCycle = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    UIBezierPath *endCycle =  [UIBezierPath bezierPathWithOvalInRect:temp.buttonFrame];
    //创建CAShapeLayer进行遮盖
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.fillColor = [UIColor greenColor].CGColor;
    maskLayer.path = endCycle.CGPath;
    fromVC.view.layer.mask = maskLayer;
    //创建路径动画
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue = (__bridge id)(startCycle.CGPath);
    maskLayerAnimation.toValue = (__bridge id)((endCycle.CGPath));
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.delegate = self;
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [maskLayerAnimation setValue:transitionContext forKey:@"transitionContext"];
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
}

- (void)presentAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    /**
     present的时候，这个fromVC是上个页面的最外层父页面
     比如这里是TabbarViewController，而不是Tab3ViewControlelr
     实际上TabbarViewController外面还包裹了一层NavigationController，最外层是这个NavigationController
     */
    UINavigationController *fromVC = (UINavigationController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UITabBarController *tabbar = ((RTContainerController *)fromVC.viewControllers.firstObject).contentViewController;
    Tab3ViewController *temp = ((UINavigationController *)(tabbar.viewControllers[2])).viewControllers.lastObject;
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    //画两个圆路径
    UIBezierPath *startCycle =  [UIBezierPath bezierPathWithOvalInRect:temp.buttonFrame];
    CGFloat x = MAX(temp.buttonFrame.origin.x, containerView.frame.size.width - temp.buttonFrame.origin.x);
    CGFloat y = MAX(temp.buttonFrame.origin.y, containerView.frame.size.height - temp.buttonFrame.origin.y);
    CGFloat radius = sqrtf(pow(x, 2) + pow(y, 2));
    UIBezierPath *endCycle = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    //创建CAShapeLayer进行遮盖
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = endCycle.CGPath;
    //将maskLayer作为toVC.View的遮盖
    toVC.view.layer.mask = maskLayer;
    //创建路径动画
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.delegate = self;
    //动画是加到layer上的，所以必须为CGPath，再将CGPath桥接为OC对象
    maskLayerAnimation.fromValue = (__bridge id)(startCycle.CGPath);
    maskLayerAnimation.toValue = (__bridge id)((endCycle.CGPath));
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.delegate = self;
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [maskLayerAnimation setValue:transitionContext forKey:@"transitionContext"];
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    switch (_type) {
        case XWCircleSpreadTransitionTypePresent:{
            id<UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"transitionContext"];
            [transitionContext completeTransition:YES];
        }
            break;
        case XWCircleSpreadTransitionTypeDismiss:{
            id<UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"transitionContext"];
            [transitionContext completeTransition:YES];
        }
            break;
        case XWCircleSpreadTransitionTypeNormal:{
//            id<UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"transitionContext"];
//            [transitionContext completeTransition:YES];
        }
            break;
    }
}

@end
