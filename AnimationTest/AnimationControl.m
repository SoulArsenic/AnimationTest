//
//  AnimationControl.m
//  PodForAnimationTest
//
//  Created by admin on 15-1-21.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import "AnimationControl.h"

@implementation AnimationControl
+(void)animationStartJump:(UIView *)animationView{

    AnimationControl * control = [[AnimationControl alloc] init];
    __block typeof (control) weakSelf = control;
    control.center = control.temp = animationView.center;
#define startlocation 8
    [UIView animateWithDuration:.3 animations:^{
        //temp 调整位置
        weakSelf.temp = CGPointMake( weakSelf.temp.x,  weakSelf.center.y -  weakSelf.center.y/startlocation);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.2 animations:^{
             weakSelf.temp = CGPointMake(weakSelf.temp.x,  weakSelf.center.y +  weakSelf.center.y/(startlocation +1));
            animationView.center = weakSelf.temp;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:.15 animations:^{
                 weakSelf.temp = CGPointMake( weakSelf.temp.x,  weakSelf.center.y -  weakSelf.center.y/(startlocation +2));
                animationView.center =  weakSelf.temp;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:.1 animations:^{
                    //temp 调整位置
                     weakSelf.temp = CGPointMake(weakSelf.temp.x,  weakSelf.center.y +  weakSelf.center.y/(startlocation +3));
                    animationView.center =  weakSelf.temp;
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:.05 animations:^{
                        //temp 调整位置
                         weakSelf.temp = CGPointMake( weakSelf.temp.x,  weakSelf.center.y -  weakSelf.center.y/(startlocation +4));
                        animationView.center =  weakSelf.temp;
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:.05 animations:^{
                            //temp 调整位置
                             weakSelf.temp = CGPointMake( weakSelf.center.x,  weakSelf.center.y);
                            animationView.center =  weakSelf.temp;
                        }completion:^(BOOL finished) {
                            animationView.center =  weakSelf.center;
                        }];
                        
                    }];
                }] ;
                
            }];
            
        }];
    }];

}


+ (void) animationStartCover:(UIView *) animationView{

    __block typeof (animationView) otheranimationView = animationView;
    
    CGAffineTransform endAngle = CGAffineTransformMakeRotation((M_PI / 180.0f));
    
    [UIView animateWithDuration:0.01 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        otheranimationView.transform = endAngle;
    } completion:^(BOOL finished) {
    }];
}
@end
