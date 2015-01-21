//
//  AnimationViewController.m
//  AnimationTest
//
//  Created by admin on 15-1-21.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import "AnimationViewController.h"
#import "AnimationControl.h"
#import <QuartzCore/QuartzCore.h>

@interface AnimationViewController ()
@property (weak, nonatomic) IBOutlet UIView *showView;

@end

@implementation AnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.showView.layer.masksToBounds = YES;
    self.showView.layer.cornerRadius = 50;

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)jump:(id)sender {
    [AnimationControl animationStartJump:self.showView];
}
- (IBAction)cover:(id)sender {

    
    self.showView.layer.transform = CATransform3DMakeScale(-1.0, -1.0, 1.0);
    self.showView.layer.affineTransform =CGAffineTransformMakeRotation(45.0);

    CAKeyframeAnimation  *animation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    //设置view行动的轨迹
    NSArray *values=[NSArray arrayWithObjects:[NSValue valueWithCGPoint:CGPointMake(100,100)],
                     [NSValue valueWithCGPoint:self.showView.center],
                     [NSValue valueWithCGPoint:CGPointMake(150, 150)],
                     [NSValue valueWithCGPoint:CGPointMake(200, 200)],
                     [NSValue valueWithCGPoint:self.showView.center],nil];
    //获得点
    [animation setValues:values];
    //设置时常
    [animation setDuration:5.0];

    [self.showView.layer  addAnimation:animation forKey:@"img-position"];
    
}

@end
