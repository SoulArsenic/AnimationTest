//
//  LogInViewController.m
//  AnimationTest
//
//  Created by lengbinbin on 15/5/25.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import "LogInViewController.h"
#import "VCTranstionObject.h"


#define btnWidth 120
#define btnHeight 40

@interface LogInViewController ()<UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *accountArea;

@property (strong, nonatomic) UIButton *MyButton;

@property (nonatomic, strong) UIView * shape;

@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //试用自定义动画
    self.navigationController.delegate = self;
    self.view.clipsToBounds = YES;

    [self addLoginBtnAndScaleLayer];

}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.navigationController) {
        self.navigationController.navigationBar.hidden = YES;
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.navigationController) {
        self.navigationController.delegate = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
}
#pragma -mark Mymethod


- (void) addLoginBtnAndScaleLayer{
    
    
    
    
    
    
    
    
    /**
     *  添加界面元素
     ＊ 按钮
     */
    self.MyButton = [UIButton buttonWithType:UIButtonTypeCustom];

    _MyButton.frame = [self getBtnFrame];
    
    [_MyButton setTitle:@"登录" forState:UIControlStateNormal];
    [_MyButton setBackgroundColor:[UIColor redColor]];
    _MyButton.layer.cornerRadius = btnHeight/2;
    _MyButton.alpha = 0.7;
    [_MyButton addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_MyButton];
    
    
    
    /**
     *  添加扩散用到的视图，因为放大会失真， 所以先加一个大的， 缩小后放大
     *
     *  radius 为 能填充包含当前视图的最小圆半径
     
     */
    
    
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height + ( _MyButton.center.y);
    CGFloat radius  = sqrt(width * width + height * height);
    CGFloat scale = self.MyButton.frame.size.height/radius;

    self.shape = [[UIView alloc] initWithFrame:CGRectMake(0, 0,
                                                          radius,
                                                          radius)];
    _shape.backgroundColor =_MyButton.backgroundColor;
    _shape.alpha = _MyButton.alpha;
    _shape.center = _MyButton.center;
    _shape.layer.transform = CATransform3DMakeScale(scale, scale, scale);
    _shape.layer.cornerRadius = radius/2;
    _shape.hidden = YES;
    
    [self.view insertSubview:_shape belowSubview:_MyButton];
}
- (CGRect ) getBtnFrame {
    return  CGRectMake(([UIScreen  mainScreen].bounds.size.width - btnWidth)/2,
                       [UIScreen mainScreen].bounds.size.height*4/5,
                       //                                 ([UIScreen  mainScreen].bounds.size.height - btnHeight)/2  ,
                       btnWidth,
                       btnHeight);
}
- (void)clicked:(UIButton *)sender {
    
    [self doSomeThing];
    
//    [self.accountArea removeConstraints:self.accountArea.constraints];
    

    
    [_MyButton setTitle:@"" forState:UIControlStateNormal];
    CGPoint center = sender.center;
    
    UIActivityIndicatorView * active = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    active.frame = CGRectMake(0, 0, btnHeight, btnHeight);
    active.center  = center;
    [self.view addSubview:active];
    [active startAnimating];
    active.alpha = 0;
    
    [UIView animateWithDuration:0.5 animations:^{

//        self.accountArea.alpha  = 0;
        active.alpha = 1;
        _MyButton.frame = CGRectMake(0, 0, sender.frame.size.height, sender.frame.size.height);
        _MyButton.center = center;
        self.accountArea.transform = CGAffineTransformMakeScale(0.001, 0.001);
     } completion:^(BOOL finished) {
         [active removeFromSuperview];
         active.frame = CGRectMake(0, 0, btnHeight, btnHeight);
         [_MyButton addSubview:active];
     }] ;
}

- (void) doSomeThing{
    if (self.callDoSomeThing) {
        self.callDoSomeThing(self,@"userName",@"pwd");
    }else{
        // 未初始化， 试用模拟场景
        [self performSelector:@selector(onEnd) withObject:nil afterDelay:2];
    }
}


-(void)methodLoginSucess{
    [self onEnd];
}
-(void)methodLoginFaild{
    
    for (UIView * temp in _MyButton.subviews ) {
        if ([temp isKindOfClass:[UIActivityIndicatorView class]]) {
            [temp removeFromSuperview];
        }
    }
    
    [UIView animateWithDuration:0.6 animations:^{
        self.accountArea.transform = CGAffineTransformMakeScale(1, 1);
        _MyButton.frame = [self getBtnFrame];
        
    } completion:^(BOOL finished) {
        [_MyButton setTitle:@"登录" forState:UIControlStateNormal];
    }];
}

- (void) onEnd{
    _shape.hidden = NO;
    _MyButton.hidden = YES;
    
    CABasicAnimation *scaleAnimation =[self animateKeyPath:@"transform.scale"
                                                 fromValue:[NSValue valueWithCATransform3D:_shape.layer.transform]
                                                   toValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]
                                                    timing:kCAMediaTimingFunctionEaseIn andTime:1];
    [self.shape.layer addAnimation:scaleAnimation forKey:@"bgchange"];
    [self performSelector:@selector(removeFromTheStack) withObject:self afterDelay:0.8];
}





- (void) removeFromTheStack{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }else
        [self dismissViewControllerAnimated:NO completion:nil];

}

- (CABasicAnimation *)animateKeyPath:(NSString *)keyPath fromValue:(id)from toValue:(id)to timing:(NSString *)timing andTime:(NSTimeInterval)duration
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:keyPath];
    animation.fromValue = from;
    animation.toValue = to;
    animation.repeatCount = 1;
    animation.timingFunction = [CAMediaTimingFunction functionWithControlPoints: 0.351 : 0.000 : 0.910 : 0.215];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.duration = duration;
    return animation;
}

#pragma -mark nativegation antimation

-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    
    return [[VCTranstionObject alloc] init];
}

@end
