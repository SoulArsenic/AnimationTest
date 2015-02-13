//
//  ScrollControlViewController.m
//  AnimationTest
//
//  Created by lengbinbin on 15/2/11.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import "ScrollControlViewController.h"


@interface ScrollControlViewController ()<UIScrollViewDelegate>
@property (assign) CGFloat temp;
@property (assign) CGPoint lastLocation;
@property (assign) BOOL pass;
@property (assign) CGPoint centerSave;

@end


@implementation ScrollControlViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    
//    self.contentController.contentSize = CGSizeMake(0, 1000);

}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    if (self.targetBackView && self.targetScrollView) {
        
        self.view.backgroundColor = [UIColor clearColor];
        
        UIView * percent30 = [[UIView alloc] initWithFrame:self.view.bounds];
        percent30.backgroundColor = [UIColor blackColor];
        percent30.alpha = .3;
        [self.view addSubview:percent30];
        [self.view sendSubviewToBack:percent30];
        
        self.centerSave = self.targetBackView.center;
        UIPanGestureRecognizer * recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
        [self.targetBackView addGestureRecognizer:recognizer];
    }else{
    
        assert(@"需要指定");
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if (_pass) {
        return;
    }
    if (self.targetScrollView.contentOffset.y<=0) {
        self.targetBackView.frame = CGRectMake(self.targetScrollView.contentOffset.x,
                                             -self.targetScrollView.contentOffset.y + self.temp,
                                             self.targetBackView.frame.size.width,
                                             self.targetBackView.frame.size.height);
    }
    
    if (self.targetBackView.frame.origin.y > 120) {
        self.pass = YES;
        [self dismiss:direction_down];
    }

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}
- (void)panAction:(UIPanGestureRecognizer *)sender {

    if (_pass) {
        return;
    }
    CGPoint touchPoint = [sender locationInView:self.targetBackView];
    if (CGPointEqualToPoint(self.lastLocation, CGPointZero)){
        self.lastLocation = touchPoint;
        return;
    }
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        
        self.lastLocation = CGPointZero;
        
        [self dismiss:direction_none];
        
        return;
    }else{
        
        if (self.lastLocation.x > touchPoint.x) {
            //向左 抖一下
            self.targetBackView.center = CGPointMake(self.targetBackView.center.x + (touchPoint.x - self.lastLocation.x)/3 , self.targetBackView.center.y);
        
        }else{
            
            self.targetBackView.center = CGPointMake(self.targetBackView.center.x + (touchPoint.x - self.lastLocation.x) , self.targetBackView.center.y);
            [self needBack];
            
        }
    }
    
    self.lastLocation = touchPoint;
    
}



- (BOOL) needBack{

    if (self.targetBackView.frame.origin.x > self.targetBackView.bounds.size.width/3) {

        [self dismiss:direction_right];
        return YES;
    }
    return NO;
}


-(void)dismiss:(direction) direct{

    if (direct == direction_down) {
        self.pass = YES;

        [UIView animateWithDuration:.3 animations:^{
        
            self.targetBackView.center = CGPointMake(self.targetBackView.center.x, self.targetBackView.center.y + self.targetBackView.bounds.size.height);
            
        } completion:^(BOOL finished) {
           
            [self dismissViewControllerAnimated:NO completion:nil];

        }];
        
        
    }else if (direct == direction_right){
        
        self.pass = YES;

        [UIView animateWithDuration:.3 animations:^{
            
            self.targetBackView.center = CGPointMake(self.centerSave.x + self.targetBackView.bounds.size.width, self.targetBackView.center.y );
            
        } completion:^(BOOL finished) {
            
            [self dismissViewControllerAnimated:NO completion:nil];
            
        }];
        
    }else if (direct == direction_none) {
    
        [self shake];
    }
    
}
-(void) shake{
    CGFloat tempMove =  self.targetBackView.center.x - self.centerSave.x;

    [UIView animateWithDuration:.3 animations:^{
        CGFloat move = 5;
        if (tempMove > 0) {
            move = -5;
        }
        
        self.targetBackView.center = CGPointMake(self.centerSave.x + move , self.centerSave.y);


    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.2 animations:^{
            self.targetBackView.center = self.centerSave;
        }];
    }];
    
    
   
    
}

@end
