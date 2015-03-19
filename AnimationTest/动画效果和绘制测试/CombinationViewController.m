//
//  CombinationViewController.m
//  AnimationTest
//
//  Created by admin on 15-1-22.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import "CombinationViewController.h"
#import "CombinationView.h"
#import "AnimationControl.h"


@interface CombinationViewController ()
@property (weak, nonatomic) IBOutlet CombinationView *view1;
@property (weak, nonatomic) IBOutlet CombinationView *view1_1;
@property (weak, nonatomic) IBOutlet CombinationView *view1_2;
@property (weak, nonatomic) IBOutlet CombinationView *view1_3;
@property (weak, nonatomic) IBOutlet CombinationView *view1_4;
@property (weak, nonatomic) IBOutlet CombinationView *view1_5;

@property (weak, nonatomic) IBOutlet CombinationView *view1_6;
@property (weak, nonatomic) IBOutlet CombinationView *view1_7;


@property (weak, nonatomic) IBOutlet UIView *view2;
@end

@implementation CombinationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
}
- (IBAction)view1ResetAction:(id)sender {
//    if (self.view1.hidden) {
//        self.view1.hidden = NO;
//    }
    self.view1.hidden = NO;
    self.view2.hidden = YES;
    [self startAnimation];
}

-(void) startAnimation{


    NSArray * array = [NSArray arrayWithObjects:self.view1_1,self.view1_2,self.view1_3,self.view1_4,self.view1_5,self.view1_6,self.view1_7, nil];
    [AnimationControl animationCombiationCircle:array andSuperView:self.view1];
    
    
    
}
- (IBAction)otherViewAction:(id)sender {
    self.view1.hidden = YES;
    self.view2.hidden = NO;
    [AnimationControl animationCombiationSuperView:self.view2 withMaxSize: 100 andCellSize:10 andCellCount:20];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
