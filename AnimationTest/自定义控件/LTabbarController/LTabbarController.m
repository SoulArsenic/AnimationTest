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
#import "LogInViewController.h"


@interface LTabbarController ()<UITabBarControllerDelegate,LTabBarControllerDelegate>
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
    a.delegate = self;
    [self.view addSubview:a];
}


-(id<UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController animationControllerForTransitionFromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    //    一个视图左右切换的动画
    return    [[LTabbarControllerMoveAnimation alloc] initWithDrict:_type];
}
-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    return NO;
}
-(void)setSelectedIndex:(NSUInteger)selectedIndex{
    self.type = Dirct_toleft;
    if (selectedIndex < self.lastLocation) {
        _type = Dirct_toright;
    }
    [super setSelectedIndex:selectedIndex];
    self.lastLocation = self.selectedIndex;
}

-(void)fobiddinSelectOtherVC{

        NSLog(@"fobiddn");

    [self presentViewController: [self.storyboard instantiateViewControllerWithIdentifier:@"LogInViewController"] animated:YES completion:^{
        
    }];
}

@end
