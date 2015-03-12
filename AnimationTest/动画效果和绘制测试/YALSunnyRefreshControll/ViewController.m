//
//  ViewController.m
//  AnimationTest
//
//  Created by admin on 15-1-21.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import "ViewController.h"
#import "TouchHandleView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void) setUp{
    
    
    __block typeof (self) weakSelf = self;
    NSMutableArray * temp = [NSMutableArray array];
    
    for (NSInteger i = 0; i < defaultshowNumber ; i++) {
        TouchHandleView * view = [[TouchHandleView alloc] init];
        view.frame = CGRectMake(0, 0, 150 , 200);
        view.center = self.view.center;
        view.handleAction = ^(UISwipeGestureRecognizerDirection direction,TouchHandleView *view){
            [weakSelf removeAction:direction andView:view];
        };
        [temp addObject:view];
    }
    [TouchHandleView addSub:temp to:self.view];
    
}

- (void) removeAction:(UISwipeGestureRecognizerDirection)direction andView:(TouchHandleView *)view{
    
    [TouchHandleView moveTheLess:self.view.subviews];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self setUp];
    
}

- (IBAction)refresh:(id)sender {
    
    for (UIView * temp  in self.view.subviews) {
        if (![temp isKindOfClass:[UIButton class]])
            [temp removeFromSuperview];
    }
    [self setUp];

}

@end
