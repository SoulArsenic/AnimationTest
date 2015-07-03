//
//  LayerTest.m
//  AnimationTest
//
//  Created by lengbinbin on 15/3/4.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import "LayerTest.h"


@interface LayerTest ()

@property (strong, nonatomic) NSTimer * timeControl;
@property (assign) NSInteger time;
@property (assign) NSInteger hTime;


@property (assign) NSInteger mStart;
@property (assign) NSInteger hStart;

@end

@implementation LayerTest
-(void)viewDidLoad{
    [super viewDidLoad];
    
    CALayer *maskLayer = [CALayer layer];
    maskLayer.frame = self.imageView.bounds;
    
    UIImage *maskImage = [UIImage imageNamed:@"test2.png"];
    maskLayer.contents = (__bridge id)maskImage.CGImage;
    self.imageView.layer.mask = maskLayer; //特殊样式透视

    //CGAffineTransformMakeRotationM_1_PI);
//   self.timeControl = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(clockUpdate) userInfo:nil repeats:YES];
}




@end
