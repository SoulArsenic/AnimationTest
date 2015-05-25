//
//  LTabbarView.h
//  AnimationTest
//
//  Created by lengbinbin on 15/5/21.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  TODO
 
 *  UITabBar 的拓展
 
 *  badgeValue
 */

// TODO 

@protocol LTabBarControllerDelegate <NSObject>
@optional

- (void) fobiddinSelectOtherVC;

@end



@interface LTabbarView : UIView

@property(nonatomic, assign) id< UITabBarDelegate ,LTabBarControllerDelegate> delegate;

@property (nonatomic, strong) UIColor * defaultForgroundColor;

- (instancetype)initWithTabbar:(UITabBarController *)aTabbar;

@end
