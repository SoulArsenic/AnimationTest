//
//  FlexibleViewController.m
//  AnimationTest
//
//  Created by lengbinbin on 15/5/14.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import "FlexibleViewController.h"

#import "FlexibleButtonView.h"


@implementation FlexibleViewController


-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    FlexibleButtonView * aButton = [[FlexibleButtonView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    [self.view addSubview:aButton];
    
    
    
    
    
}
	

@end
