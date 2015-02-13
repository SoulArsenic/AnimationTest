//
//  NoAnimation.m
//  AnimationTest
//
//  Created by lengbinbin on 15/2/11.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import "NoAnimation.h"

@implementation NoAnimation
-(void) perform{
    [[self sourceViewController] navigationController].modalPresentationStyle= UIModalPresentationCurrentContext;

    [[self sourceViewController] presentationController:[self   destinationViewController] viewControllerForAdaptivePresentationStyle:UIModalPresentationOverCurrentContext];
}
@end
