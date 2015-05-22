//
//  LTabbarController.m
//  AnimationTest
//
//  Created by lengbinbin on 15/5/21.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import "LTabbarController.h"
#import "LTabbarControllerMoveAnimation.h"
#import "LTabbarView.h"


@interface LTabbarController ()<UITabBarControllerDelegate>
@property (nonatomic, assign) NSInteger lastLocation;
@property (nonatomic, assign) Dirct type;
@property (nonatomic, assign) CGFloat xPox;

@end

@implementation LTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;

    // Do any additional setup after loading the view.
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    /**
     替换系统自带tabbar
     */
    __unused    LTabbarView * a =  [[LTabbarView alloc] initWithTabbar:self];
    a.defaultForgroundColor = [UIColor purpleColor];
    [self.view addSubview:a];
}


-(id<UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController animationControllerForTransitionFromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    //    一个视图左右切换的动画
    return    [[LTabbarControllerMoveAnimation alloc] initWithDrict:_type];
}
-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    return YES;
}
-(void)setSelectedIndex:(NSUInteger)selectedIndex{
    self.type = Dirct_toleft;
    if (selectedIndex < self.lastLocation) {
        _type = Dirct_toright;
    }
    [super setSelectedIndex:selectedIndex];
    self.lastLocation = self.selectedIndex;
}


@end
