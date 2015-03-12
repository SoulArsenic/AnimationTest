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
    self.showView.layer.cornerRadius = 45;
    self.showView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.showView.layer.shadowOpacity = 0.5;
    self.showView.layer.shadowOffset = CGSizeMake(0, 1.5);
    self.showView.layer.shouldRasterize = YES;
    self.showView.layer.rasterizationScale = [[UIScreen mainScreen] scale];

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
    [AnimationControl animationStartCover:self.showView];
}
- (IBAction)move:(id)sender {
    [AnimationControl animationStartMove:self.showView withPoints:nil];
}
- (IBAction)sys_action:(id)sender {
    
    [self.showView performSelector:@selector(setBackgroundColor:) withObject:[UIColor colorWithRed:arc4random()%10 *.1 green:arc4random()%10 *.1 blue:arc4random()%10 *.1 alpha:1] afterDelay:.8];
    [AnimationControl animationSystem:self.showView];
}

@end
