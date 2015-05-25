//
//  LogInViewController.m
//  AnimationTest
//
//  Created by lengbinbin on 15/5/25.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import "LogInViewController.h"
#import <QuartzCore/QuartzCore.h>

#define btnWidth 120
#define btnHeight 40

@interface LogInViewController ()<UINavigationControllerDelegate>
@property (weak, nonatomic) UIButton *MyButton;

@property (nonatomic, strong) UIView * shape;

@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.clipsToBounds = YES;
    
    self.MyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _MyButton.frame = CGRectMake(([UIScreen  mainScreen].bounds.size.width - btnWidth)/2,([UIScreen  mainScreen].bounds.size.height - btnHeight)/2  , btnWidth, btnHeight);
    [_MyButton setTitle:@"登录" forState:UIControlStateNormal];
    [_MyButton setBackgroundColor:[UIColor greenColor]];
    _MyButton.layer.cornerRadius = btnHeight/2;
    _MyButton.layer.shouldRasterize = YES;
    [_MyButton addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_MyButton];
    
    CGFloat radius  = sqrt(self.view.bounds.size.height * self.view.bounds.size.height + self.view.bounds.size.width * self.view.bounds.size.width);
    self.shape = [[UIView alloc] initWithFrame:CGRectMake(0, 0,
                                                          radius,
                                                          radius)];
    _shape.backgroundColor =_MyButton.backgroundColor;
    _shape.center = self.view.center;
    _shape.layer.transform = CATransform3DMakeScale(0.0001, 0.0001, 0.0001);
    _shape.layer.cornerRadius = radius/2;
    [self.view insertSubview:_shape atIndex:0];
    self.navigationController.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)clicked:(UIButton *)sender {
    
    [self doSomeThing];
    
    [_MyButton setTitle:@"" forState:UIControlStateNormal];
    CGPoint center = sender.center;
    
    UIActivityIndicatorView * active = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    active.frame = CGRectMake(0, 0, btnHeight, btnHeight);
    active.center  = center;
    [self.view addSubview:active];
    [active startAnimating];
    active.alpha = 0;
    
    [UIView animateWithDuration:0.75 animations:^{
        active.alpha = 1;
        _MyButton.frame = CGRectMake(0, 0, sender.frame.size.height, sender.frame.size.height);
        _MyButton.center = center;
     } completion:^(BOOL finished) {
         [active removeFromSuperview];
         active.frame = CGRectMake(0, 0, btnHeight, btnHeight);
         [_MyButton addSubview:active];
     }] ;
}

- (void) doSomeThing{
    [self performSelector:@selector(onEnd) withObject:nil afterDelay:4];
}

- (void) onEnd{

    for (UIView  * temp in     _MyButton.subviews) {
        if ([temp isKindOfClass:[UIActivityIndicatorView class]]) {
            
            CABasicAnimation *scaleAnimation =[self animateKeyPath:@"transform.scale"
                                                         fromValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0001, 0.0001, 0.0001)]
                                                           toValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]
                                                            timing:kCAMediaTimingFunctionEaseIn andTime:1.5];
            scaleAnimation.delegate = self;
            [self.shape.layer addAnimation:scaleAnimation forKey:@"bgchange"];

            _MyButton.layer.shouldRasterize = YES;
            temp.alpha = 0;
        }
    }
    
}
-(void)animationDidStart:(CAAnimation *)anim{

}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{

    [self dismissViewControllerAnimated:NO completion:nil];

}

- (CABasicAnimation *)animateKeyPath:(NSString *)keyPath fromValue:(id)from toValue:(id)to timing:(NSString *)timing andTime:(NSTimeInterval)duration
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:keyPath];
    animation.fromValue = from;
    animation.toValue = to;
    animation.repeatCount = 1;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:timing];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.duration = duration;
    return animation;
}

@end
