//
//  AnimationControl.h
//  PodForAnimationTest
//
//  Created by admin on 15-1-21.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimationControl : NSObject

@property (nonatomic, assign) CGPoint temp,center;

+ (void) animationStartJump:(UIView *) animationView;
+ (void) animationStartCover:(UIView *) animationView;
@end
