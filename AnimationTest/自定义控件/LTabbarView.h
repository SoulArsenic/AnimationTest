//
//  LTabbarView.h
//  AnimationTest
//
//  Created by lengbinbin on 15/5/21.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTabbarView : UIView

@property (nonatomic, strong) UIColor * defaultForgroundColor;

- (instancetype)initWithTabbar:(UITabBarController *)aTabbar;

@end
