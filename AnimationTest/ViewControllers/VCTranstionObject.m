//
//  VCTranstionObject.m
//  AnimationTest
//
//  Created by lengbinbin on 15/5/25.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import "VCTranstionObject.h"
#import "RootViewController.h"
@implementation VCTranstionObject
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    return 1.0;
}
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{

    /**
     *  目标VC
     */
    UIViewController *desController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    /**
     *  源
     */
    UIViewController *srcController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    [[transitionContext containerView] addSubview:desController.view];
    desController.view.alpha  = 0;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        desController.view.alpha = 1;
        srcController.view.alpha = 0.1;
    } completion:^(BOOL finished) {
         [transitionContext completeTransition:YES];
    }];
    
    
}

@end
