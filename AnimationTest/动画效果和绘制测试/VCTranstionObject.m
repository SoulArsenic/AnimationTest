//
//  VCTranstionObject.m
//  AnimationTest
//
//  Created by lengbinbin on 15/5/25.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import "VCTranstionObject.h"

@implementation VCTranstionObject
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    return 1.0;
}
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{

}

@end
