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
    
    //apply mask to image layer￼
    self.imageView.layer.mask = maskLayer; //特殊样式透视
    
    self.clockView.layer.cornerRadius = 75;
    
    
    self.mControlView.transform =   CGAffineTransformMakeRotation(90 *M_PI/180);
    self.hControlView.transform =  CGAffineTransformMakeRotation(90 *M_PI/180);
    // CATransform3DMakeRotation(45 *M_PI/180, 1, 0, 0);

    //CGAffineTransformMakeRotation(M_1_PI);
   self.timeControl = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(clockUpdate) userInfo:nil repeats:YES];
}


-(void) clockUpdate{

    self.mControlView.transform =  CGAffineTransformMakeRotation((_time*6 + 90) *M_PI/180);
    _time ++;
    if (_time == 60) {
        _time = 0;
        _hTime ++;
        self.hControlView.transform =  CGAffineTransformMakeRotation((_hTime*6 + 90) *M_PI/180);
        if (_hTime == 60) {
            _hTime = 0;
        }
    }
}

@end
