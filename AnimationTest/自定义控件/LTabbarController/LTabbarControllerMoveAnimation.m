//
//  LTabbarControllerMoveAnimation.m
//  AnimationTest
//
//  Created by lengbinbin on 15/5/21.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import "LTabbarControllerMoveAnimation.h"

@implementation LTabbarControllerMoveAnimation

-(instancetype)initWithDrict:(Dirct)driction{
    self = [super init];
    if (self) {
        self.type = driction;
    }
    return self;
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return  0.5f;
}
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    /**
     *  目标VC
     */
    UIViewController *desController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    /**
     *  源
     */
    UIViewController *srcController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    [[transitionContext containerView] addSubview:desController.view];
    
    
    desController.view.alpha = 0.0;
    CGRect rect;
    CGRect frame ;
    CGRect start ;
    rect = frame = start = srcController.view.frame;
    frame.origin.x -= frame.size.width*(_type == Dirct_toleft ? 1 : -1);
    start.origin.x += frame.size.width*(_type == Dirct_toleft ? 1 : -1);
    desController.view.frame = start;

    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                     animations:^{
                         srcController.view.frame = frame;
                         desController.view.frame = rect;
                         desController.view.alpha = 1.0;
                     }
                     completion:^(BOOL finished) {
                         srcController.view.frame = rect;

                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
}

@end
