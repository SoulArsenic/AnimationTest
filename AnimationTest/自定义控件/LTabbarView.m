//
//  LTabbarView.m
//  AnimationTest
//
//  Created by lengbinbin on 15/5/21.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import "LTabbarView.h"
#import "LTabbarControllerClearView.h"
#import "LTabbarCoverView.h"

@interface LTabbarView ()
@property (nonatomic, weak) UITabBarController * tabbarController;
@property (nonatomic, strong) LTabbarCoverView * coverView;
@property (nonatomic, weak) UIButton *selectedBtn;
@property (nonatomic, strong) LTabbarControllerClearView* aView;
@end

@implementation LTabbarView

-(instancetype)initWithTabbar:(UITabBarController *)aTabbar{
    self = [super init];
    if (self) {

        self.tabbarController = aTabbar;
        NSArray * temp = aTabbar.viewControllers;
        CGRect aFrame   = aTabbar.tabBar.frame;
        aTabbar.tabBar.hidden = YES;
        self.frame = aFrame;
        

        NSInteger count = temp.count;
        //    UITabBarItem
        for (NSInteger i=0; i<count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(i * aFrame.size.width/count, 0, aFrame.size.width/count, aFrame.size.height);
            btn.backgroundColor = [self randomColor:i];
            btn.tag = i;
            [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
        }
        
        /**
         *  添加一个透视的阴影
         */
        
        self.aView = [[LTabbarControllerClearView alloc] initWithFrame:CGRectMake(0, 0, aFrame.size.width/count, aFrame.size.height)];
        _aView.backgroundColor = [UIColor clearColor];
        
        self.coverView = [[LTabbarCoverView alloc] initWithFrame:self.bounds];
        _coverView.backgroundColor = [UIColor clearColor];
        _coverView.coverView =_aView;
        _coverView.userInteractionEnabled = NO;
        [_coverView addSubview:_aView];
        [self addSubview:_coverView];
        
        /**
         *  添加bar item
         */
        for (NSInteger i=0; i<count; i++) {
            
            UILabel * title = [[UILabel alloc] init];
            title.text = ((UIViewController *) [aTabbar.viewControllers objectAtIndex:i]).tabBarItem.title;
            title.frame = CGRectMake(i * aFrame.size.width/count, 0, aFrame.size.width/count, aFrame.size.height);
            title.textAlignment = NSTextAlignmentCenter;
            title.backgroundColor = [UIColor clearColor];
            [self addSubview:title];
        }
        
    }
    return self;
}
- (void) click:(UIButton *)btn {
    
    self.tabbarController.selectedIndex = btn.tag;
    [self.coverView animationMoveCoverTo:btn.frame withDuration:0.5];
}
- (NSArray *) getColors{
    return [NSArray arrayWithObjects:
            [UIColor redColor],
            [UIColor orangeColor],
            [UIColor yellowColor],
            [UIColor greenColor],
            [UIColor cyanColor],
            [UIColor blueColor],
            [UIColor purpleColor],nil];
}
- (UIColor *) randomColor:(NSInteger)index{
    
    UIColor *color  = nil;
    NSArray * colors = [self getColors];
    @try {
        color = [colors objectAtIndex:index];
    }
    @catch (NSException *exception) {
        color = [UIColor whiteColor];
    }
    return color;
}


@end
