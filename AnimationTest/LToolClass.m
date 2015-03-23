//
//  LToolClass.m
//  AnimationTest
//
//  Created by lengbinbin on 15/3/20.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import "LToolClass.h"

@implementation LToolClass

@synthesize theView;

-(void)showInView:(UIView *)view WithLoop:(BOOL)loop{
    self.theView = view;
    
 
    
    if (loop) {
        [self loopAnimation:view];
    }else
    {
        CGPoint center = view.center;
        
        [self start:center];
        
        center.x -= 100;
        CGPoint left = center;
        [self start:left];
        
        center.x += 200;
        CGPoint right = center;
        [self start:right];

    }

}

- (void) loopAnimation:(UIView *)view{
    
    CGPoint center = view.center;
    
    [self start:center];
    
    center.x -= 100;
    CGPoint left = center;
    [self start:left];
    
    center.x += 200;
    CGPoint right = center;
    [self start:right];


    [self performSelector:_cmd withObject:view afterDelay:2.2];

}

-(void)showInView:(UIView *)view{
    [self showInView:view WithLoop:NO];
}

- (void) start:(CGPoint) touchPoint{
    CALayer *waveLayer=[CALayer layer];
    waveLayer.frame = CGRectMake(touchPoint.x-1, touchPoint.y-1, 10, 10);
    int index=arc4random()%7;
    switch (index) {
        case 0:
            waveLayer.backgroundColor =[UIColor redColor].CGColor;
            break;
        case 1:
            waveLayer.backgroundColor =[UIColor grayColor].CGColor;
            break;
        case 2:
            waveLayer.backgroundColor =[UIColor purpleColor].CGColor;
            break;
        case 3:
            waveLayer.backgroundColor =[UIColor orangeColor].CGColor;
            break;
        case 4:
            waveLayer.backgroundColor =[UIColor yellowColor].CGColor;
            break;
        case 5:
            waveLayer.backgroundColor =[UIColor greenColor].CGColor;
            break;
        case 6:
            waveLayer.backgroundColor =[UIColor blueColor].CGColor;
            break;
        default:
            waveLayer.backgroundColor =[UIColor blackColor].CGColor;
            break;
    }
    
    waveLayer.borderWidth =0;
    waveLayer.cornerRadius =5.0;
    [waveLayer setTransform:CATransform3DMakeScale( .01, .01, 1.0)];

    [theView.layer addSublayer:waveLayer];
    [self scaleBegin:waveLayer];
}

-(void)scaleBegin:(CALayer *)aLayer
{
    const float maxScale=10.0;
    if (aLayer.transform.m11<maxScale) {
        if (aLayer.transform.m11==1.0) {
            [aLayer setTransform:CATransform3DMakeScale( 1.1, 1.1, 1.0)];
            
        }else{
            [aLayer setTransform:CATransform3DScale(aLayer.transform, 1.1, 1.1, 1.0)];
        }
        [self performSelector:_cmd withObject:aLayer afterDelay:0.05];
    }else {
        
        [aLayer setTransform:CATransform3DMakeScale( .01, .01, 1.0)];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [aLayer removeFromSuperlayer];
        });
    }
}




@end
