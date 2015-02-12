//
//  ScrollControlViewController.m
//  AnimationTest
//
//  Created by lengbinbin on 15/2/11.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import "ScrollControlViewController.h"


@interface ScrollControlViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *bgController;
@property (weak, nonatomic) IBOutlet UIScrollView *contentController;
@property (assign) CGFloat temp;
@end


@implementation ScrollControlViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    
//    self.bgController.contentSize = CGSizeMake(1000, 0);
    self.contentController.contentSize = CGSizeMake(0, 1000);

}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.temp = self.bgController.contentOffset.y;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (self.contentController.contentOffset.y<=0) {
        self.bgController.contentOffset= CGPointMake(self.contentController.contentOffset.x, self.contentController.contentOffset.y + self.temp);
    }
    if (self.bgController.contentOffset.y < -160) {
        [self.navigationController popViewControllerAnimated:YES];
    }

}
//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    CATransition *animation = [CATransition animation];
//    animation.duration = 1.0;
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    animation.type = @"rippleEffect";
//    //animation.type = kCATransitionPush;
//    animation.subtype = kCATransitionFromLeft;
//    [self.view.window.layer addAnimation:animation forKey:nil];
//}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    CATransition *animation = [CATransition animation];
    animation.duration = 1.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = @"rippleEffect";
    //animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:animation forKey:nil];
//    [self presentModalViewController:nextViewController animated:NO completion:nil];
}
-(void)dismiss:(direction) direct{

    if (direct == direction_down) {
        
    }else if (direct == direction_right){
    
    }
    
}

@end
