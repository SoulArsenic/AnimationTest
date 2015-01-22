//
//  AnimationControl.m
//  PodForAnimationTest
//
//  Created by admin on 15-1-21.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import "AnimationControl.h"

@implementation AnimationControl
/**
 *  跳动动画
 *
 *  @param animationView 需要操作的对象
 */
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

+(void) animationStartMove:(UIView *)animationView withPoints:(NSArray *)array{
    
    CAKeyframeAnimation  *animation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    //设置view行动的轨迹
    NSArray *values = nil;
    if (!array || !array.count) {
        values =[NSArray arrayWithObjects:
                 [NSValue valueWithCGPoint:animationView.center],
                 [NSValue valueWithCGPoint:CGPointMake(animationView.center.x -100,
                                                       animationView.center.y )],
                 [NSValue valueWithCGPoint:CGPointMake(animationView.center.x -100,
                                                       animationView.center.y +100)],
                 [NSValue valueWithCGPoint:CGPointMake(animationView.center.x +100,
                                                       animationView.center.y +100)],
                 [NSValue valueWithCGPoint:CGPointMake(animationView.center.x +100,
                                                       animationView.center.y )],
                 [NSValue valueWithCGPoint:animationView.center],nil];
    }
    
    //获得点
    [animation setValues:values];
    //设置时常
    [animation setDuration:2.0];
    
    [animationView.layer  addAnimation:animation forKey:@"view-position"];

    
}

+ (void) animationStartCover:(UIView *) animationView{


    __block typeof (animationView) otheranimationView = animationView;
    
    [UIView animateWithDuration:.5 animations:^{
        /**
         *  旋转说明
         *
         *  @param otheranimationView.transform 旋转方法
         *  @param 1.0                          水平
         *  @param -1.0                         竖直
         *
         *  @return 变幻后的结果
         */
        otheranimationView.transform = CGAffineTransformScale(otheranimationView.transform, 1.0, -1.0);

    }];

}
+ (void) animationSystem:(UIView *)animationView{
    
    CATransition *animation = [CATransition animation];
    //动画时间
    animation.duration = 1;
    //先慢后快
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.fillMode = kCAFillModeForwards;
    //animation.removedOnCompletion = NO;
    
    //各种动画效果
    /*
     kCATransitionFade;
     kCATransitionMoveIn;
     kCATransitionPush;z
     kCATransitionReveal;
     */
    /*
     kCATransitionFromRight;
     kCATransitionFromLeft;
     kCATransitionFromTop;
     kCATransitionFromBottom;
     */
    //各种组合
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    
    [animationView.layer addAnimation:animation forKey:@"animation"];
    
    /*
    fade     //交叉淡化过渡(不支持过渡方向) kCATransitionFade
    push     //新视图把旧视图推出去  kCATransitionPush
    moveIn   //新视图移到旧视图上面   kCATransitionMoveIn
    reveal   //将旧视图移开,显示下面的新视图  kCATransitionReveal
    cube     //立方体翻滚效果
    oglFlip  //上下左右翻转效果
    suckEffect   //收缩效果，如一块布被抽走(不支持过渡方向)
    rippleEffect //滴水效果(不支持过渡方向)
    pageCurl     //向上翻页效果
    pageUnCurl   //向下翻页效果
    cameraIrisHollowOpen  //相机镜头打开效果(不支持过渡方向)
    cameraIrisHollowClose //相机镜头关上效果(不支持过渡方向)
    */
    /* 过渡方向
     kCATransitionFromRight
     kCATransitionFromLeft
     kCATransitionFromBottom
     kCATransitionFromTop
     */

}


@end
