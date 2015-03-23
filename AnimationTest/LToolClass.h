//
//  LToolClass.h
//  AnimationTest
//
//  Created by lengbinbin on 15/3/20.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LToolClass : NSObject
@property (nonatomic, weak) UIView * theView;

- (void) showInView:(UIView *) view ;
- (void) showInView:(UIView *) view WithLoop:(BOOL) loop;

@end
