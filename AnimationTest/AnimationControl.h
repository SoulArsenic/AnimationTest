//
//  AnimationControl.h
//  PodForAnimationTest
//
//  Created by admin on 15-1-21.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimationControl : NSObject

@property (nonatomic, strong) NSArray*circles;
@property (nonatomic) bool status;
@property (nonatomic) CGPoint oldPoint;
@property (nonatomic, strong) NSMutableArray *Points1;
@property (nonatomic, assign) CGPoint temp,center;
@property (nonatomic, weak) UIView * tempSuperView;
@property (nonatomic, strong) NSTimer * timer ;


+ (void) animationStartJump:(UIView *) animationView;
+ (void) animationStartMove:(UIView *)animationView withPoints:(NSArray *)array;
+ (void) animationStartCover:(UIView *) animationView;
+ (void) animationSystem:(UIView *)animationView;

+ (void) animationCombiationCircle:(NSArray *) circles andSuperView:(UIView *)superview;

@end
