//
//  ScrollBrowShowViewController.m
//  AnimationTest
//
//  Created by lengbinbin on 15/5/27.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import "ScrollBrowShowViewController.h"



@interface ScrollBrowShowViewController ()
@property (weak, nonatomic) IBOutlet LScrollBrowView *contentView;
@end

@implementation ScrollBrowShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    // Do any additional setup after loading the view.
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.contentView setFrame: self.contentView.frame];
//    for (UIView * aVew in  _contentView.subviews) {
//        aVew.frame = CGRectMake(10, 10, _contentView.bounds.size.width - 20, _contentView.bounds.size.height  - 40);
//
//    }
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

@end
