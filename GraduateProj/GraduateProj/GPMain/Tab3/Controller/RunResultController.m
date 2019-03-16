//
//  RunResultController.m
//  GraduateProj
//
//  Created by 焦英博 on 2019/3/14.
//  Copyright © 2019 mlg. All rights reserved.
//

#import "RunResultController.h"

@interface RunResultController ()

@end

@implementation RunResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.dismissClick) {
//        self.dismissClick();
    }
    [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RunControllerDidEndRun" object:nil];
}

- (void)dealloc {
    NSLog(@"result dealloc");
}

@end
