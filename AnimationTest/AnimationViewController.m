//
//  AnimationViewController.m
//  AnimationTest
//
//  Created by admin on 15-1-21.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import "AnimationViewController.h"
#import "AnimationControl.h"


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

@end
