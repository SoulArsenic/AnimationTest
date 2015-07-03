//
//  MarketingAnimationControl.m
//  MAKTTING
//
//  Created by lengbinbin on 15/4/27.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import "ViewAnimationControl.h"

typedef enum {
    Deriction_fromleft,
    Deriction_fromright,
    Deriction_frombottom,
    Deriction_fromtop,
}Deriction;

NSString  * const kAnimationKeyWordsDef = @"AnimationChain";


@implementation ViewAnimationControl
+ (void)setAnimationTo:(UIView *)aView andAfter:(NSTimeInterval)after andDurtion:(NSTimeInterval)duration andAnimationType:(AnimationType)type{
    
    [ViewAnimationControl ClearLastAnimation:aView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        switch (type) {
                /*
                 AnimationType_Fadein,//淡入
                 */
            case AnimationType_Fadein:
                [ViewAnimationControl AnimateFadeinWithView:aView AndAfter:after andDuration:duration];
                break;
                
                /*
                 AnimationType_FlyFromLeft,//向右移入
                 AnimationType_FlyFromRight,//向左移入
                 AnimationType_FlyFromBottom,//向上移入
                 AnimationType_FlyFromTop,//向下移入
                 */
            case AnimationType_FlyFromLeft:
                [ViewAnimationControl animateFly:Deriction_fromleft WithView:aView AndAfter:after andDuration:duration];
                break;
            case AnimationType_FlyFromRight:
                [ViewAnimationControl animateFly:Deriction_fromright WithView:aView AndAfter:after andDuration:duration];
                break;
            case AnimationType_FlyFromBottom:
                [ViewAnimationControl animateFly:Deriction_fromtop WithView:aView AndAfter:after andDuration:duration];
                break;
            case AnimationType_FlyFromTop:
                [ViewAnimationControl animateFly:Deriction_frombottom WithView:aView AndAfter:after andDuration:duration];
                break;
                
                /*
                 AnimationType_SlipFromLeft,//向右弹入
                 AnimationType_SlipFromRight,//向左弹入
                 AnimationType_SlipFromBottom,//向上弹入
                 AnimationType_SlipFromTop,//向下弹入
                 */
            case AnimationType_SlipFromLeft:
                [ViewAnimationControl animateSlipWithDeriction:Deriction_fromleft WithView:aView AndAfter:after andDuration:duration];
                break;
            case AnimationType_SlipFromRight:
                [ViewAnimationControl animateSlipWithDeriction:Deriction_fromright WithView:aView AndAfter:after andDuration:duration];
                break;
            case AnimationType_SlipFromTop:
                [ViewAnimationControl animateSlipWithDeriction:Deriction_fromtop WithView:aView AndAfter:after andDuration:duration];
                break;
            case AnimationType_SlipFromBottom:
                [ViewAnimationControl animateSlipWithDeriction:Deriction_frombottom WithView:aView AndAfter:after andDuration:duration];
                break;
                
                /*            
                 AnimationType_SlipFromCenter,//中心弹入
                 */
            case AnimationType_SlipFromCenter:
                [ViewAnimationControl animateSlipCenterWithView:aView AndAfter:after andDuration:duration];
                break;
                
                /*
                 AnimationType_Enlarge,//中心放大
                 */
            case AnimationType_Enlarge:
                [ViewAnimationControl animateElasticEnlargeWithView:aView AndAfter:after andDuration:duration];
                break;
                
                /*
                 AnimationType_ScrollIm,//滚入
                 */
            case  AnimationType_ScrollIn:
                [ViewAnimationControl animateScrollWithView:aView AndAfter:after andDuration:duration];
                break;
                
                /*
                 AnimationType_Miter,//光速进入
                 */
            case AnimationType_Miter:
                [ViewAnimationControl animateBrakesWithView:aView AndAfter:after andDuration:duration];
                break;
                
                /*
                 AnimationType_Swing,//摇摆
                 */
            case AnimationType_Swing:
                [ViewAnimationControl animateSwingWithView:aView AndAfter:after andDuration:duration];
                break;
                
                /*
                 AnimationType_Shake,//抖动
                 */
            case AnimationType_Shake:
                [ViewAnimationControl animateShakeWithView:aView AndAfter:after andDuration:duration];
                break;
                
                /*
                 AnimationType_Flip,//旋转
                 */
            case AnimationType_Flip:
                [ViewAnimationControl animateFlipWithView:aView AndAfter:after andDuration:duration];
                break;
                
                /*
                 AnimationType_Reversal,//翻转
                 */
            case AnimationType_Reversal:
                [ViewAnimationControl animateReversalWithView:aView AndAfter:after andDuration:duration];
                break;

                /*
                 AnimationType_Pendulum,//悬摆
                 */
            case AnimationType_Pendulum:
                [ViewAnimationControl animatePendulumWithView:aView AndAfter:after andDuration:duration];
                break;
                
                /*
                 AnimationType_FadeOut, //淡出
                 */
            case AnimationType_FadeOut:
                [ViewAnimationControl animateFadeOutWithView:aView AndAfter:after andDuration:duration];
                break;
                
                /*
                 AnimationType_ReversalOut, //翻转消失
                 */
            case AnimationType_ReversalOut:
                [ViewAnimationControl animateReversalOutWithView:aView AndAfter:after andDuration:duration];
                break;
            default:
                NSLog(@"do nothing in animation control");
                break;
        }
    });
}

+ (void) ClearLastAnimation:(UIView *) aView{
    [aView.layer removeAllAnimations];
}

/*       AnimationType_Fadein,                      //淡入          */
+ (void) AnimateFadeinWithView:(UIView *)aView AndAfter:(NSTimeInterval)after andDuration:(NSTimeInterval)duration{
    float alpha = aView.alpha;

    
    
    CABasicAnimation * animamtio = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animamtio.fromValue = [NSNumber numberWithFloat:0];
    animamtio.toValue = [NSNumber numberWithFloat:alpha];
    animamtio.duration = duration;
    
    [aView.layer addAnimation:animamtio forKey:kAnimationKeyWordsDef];
}
/*
 AnimationType_FlyFromLeft,                         //向右移入
 AnimationType_FlyFromRight,                        //向左移入
 AnimationType_FlyFromBottom,                      //向上移入
 AnimationType_FlyFromTop,                          //向下移入
 */
+ (void) animateFly:(Deriction)deriction WithView:(UIView *)aView AndAfter:(NSTimeInterval)after andDuration:(NSTimeInterval)duration{
    
    CGFloat alpha = aView.alpha;
    CGFloat xStart = 0;
    CGFloat yStart = 0;
    
    switch (deriction) {
        case Deriction_fromleft:
            xStart = aView.frame.size.width;
            yStart = 0;
            break;
        case Deriction_fromright:
            xStart = -aView.frame.size.width;
            yStart = 0;
            break;
        case Deriction_fromtop:
            xStart = 0;
            yStart = aView.frame.size.height;
            break;
        case Deriction_frombottom:
            xStart = 0;
            yStart = -aView.frame.size.height;
            break;
        default:
            break;
    }
    
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.values = [NSArray arrayWithObjects:
                        [NSValue valueWithCGPoint:CGPointMake(aView.center.x - xStart, aView.center.y - yStart)],
                        [NSValue valueWithCGPoint:CGPointMake(aView.center.x, aView.center.y )],
                        nil];
    animation.duration = duration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CABasicAnimation * animamtio = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animamtio.fromValue = [NSNumber numberWithFloat:0];
    animamtio.toValue = [NSNumber numberWithFloat:alpha];
    animamtio.duration = duration;

    CAAnimationGroup * group  = [CAAnimationGroup animation];
    group.duration = duration;
    group.animations = [NSArray arrayWithObjects:animation,animamtio, nil];
    
    [aView.layer addAnimation:animation forKey:kAnimationKeyWordsDef];
    
//    aView.center = CGPointMake(aView.center.x - xStart, aView.center.y - yStart);
//    aView.moveXY(xStart,yStart).easeOutExpo.makeOpacity(alpha).easeOutQuint.animate(duration);
}
/*
 AnimationType_SlipFromLeft,                        //向右弹入
 AnimationType_SlipFromRight,                       //向左弹入
 AnimationType_SlipFromBottom,                      //向上弹入
 AnimationType_SlipFromTop,                         //向下弹入
 */
+ (void)animateSlipWithDeriction:(Deriction)deriction WithView:(UIView *)aView AndAfter:(NSTimeInterval)after andDuration:(NSTimeInterval)duration{
    
    CGFloat xdistence1 = 3000;
    CGFloat xdistence2 = 25;
    CGFloat xdistence3 = 10;
    CGFloat xdistence4 = 5;
    
    CGFloat ydistence1 = 3000;
    CGFloat ydistence2 = 25;
    CGFloat ydistence3 = 10;
    CGFloat ydistence4 = 5;
    
    
    switch (deriction) {
        case Deriction_fromleft:
            xdistence1 = -xdistence1;
            xdistence2 = xdistence2;
            xdistence3 = -xdistence3;
            xdistence4 = xdistence4;
            
            ydistence1  = 0;
            ydistence2 = 0;
            ydistence3 = 0;
            ydistence4 = 0;
            break;
        case Deriction_fromright:
            xdistence1 = xdistence1;
            xdistence2 = -xdistence2;
            xdistence3 = xdistence3;
            xdistence4 = -xdistence4;
            
            ydistence1  = 0;
            ydistence2 = 0;
            ydistence3 = 0;
            ydistence4 = 0;
            break;
        case Deriction_fromtop:
            xdistence1 = 0;
            xdistence2 = 0;
            xdistence3 = 0;
            xdistence4 = 0;
            
            ydistence1  = -ydistence1;
            ydistence2 = ydistence2;
            ydistence3 = -ydistence3;
            ydistence4 = ydistence4;
            break;
        case Deriction_frombottom:
            xdistence1 = 0;
            xdistence2 = 0;
            xdistence3 = 0;
            xdistence4 = 0;
            
            ydistence1 = ydistence1;
            ydistence2 = -ydistence2;
            ydistence3 = ydistence3;
            ydistence4 = -ydistence4;
            break;
        default:
            break;
    }
    

    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.values = [NSArray arrayWithObjects:
                        [NSValue valueWithCGPoint:CGPointMake(
                                                              aView.layer.position.x + xdistence1,
                                                              aView.layer.position.y + ydistence1)],//0
                        [NSValue valueWithCGPoint:CGPointMake(
                                                              aView.layer.position.x + xdistence2,
                                                              aView.layer.position.y + ydistence2)],//-60
                        [NSValue valueWithCGPoint:CGPointMake(
                                                              aView.layer.position.x + xdistence3,
                                                              aView.layer.position.y + ydistence3)],//75
                        [NSValue valueWithCGPoint:CGPointMake(
                                                              aView.layer.position.x + xdistence4,
                                                              aView.layer.position.y + ydistence4)],//90
                        [NSValue valueWithCGPoint:aView.layer.position],
                        nil];
    animation.keyTimes =[NSArray arrayWithObjects:
                         [NSNumber numberWithFloat:0.0],//0
                         [NSNumber numberWithFloat:0.6],//-60
                         [NSNumber numberWithFloat:0.75],//75
                         [NSNumber numberWithFloat:0.90],//90
                         [NSNumber numberWithFloat:1.0],//100
                         nil];
    animation.duration = duration;
    animation.timingFunctions = [NSArray arrayWithObjects:
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                 
                                 nil];
    [aView.layer addAnimation:animation forKey:kAnimationKeyWordsDef];
    
//    aView.center = CGPointMake(aView.center.x - XStart , aView.center.y - yStart );
//    aView.moveXY(XStart, yStart).spring.animate(duration);
}
/*      AnimationType_SlipFromCenter,           //中心弹入        */
+ (void)animateSlipCenterWithView:(UIView *)aView AndAfter:(NSTimeInterval)after andDuration:(NSTimeInterval)duration{
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = - 1.0 / 500.0;
    transform = CATransform3DScale(aView.layer.transform, 0.3, 0.3, 1);
    
    CATransform3D transform1 = CATransform3DIdentity;
    transform1.m34 = - 1.0 / 500.0;
    transform1 = CATransform3DScale(aView.layer.transform, 1.2, 1.2, 1);
    
    CATransform3D transform2 = CATransform3DIdentity;
    transform2.m34 = - 1.0 / 500.0;
    transform2 = CATransform3DScale(aView.layer.transform, 0.8, 0.8, 1);
    
    CATransform3D transform3 = CATransform3DIdentity;
    transform3.m34 = - 1.0 / 500.0;
    transform3 = CATransform3DScale(aView.layer.transform, 1.05, 1.05, 1);
    
    CATransform3D transform4 = CATransform3DIdentity;
    transform4.m34 = - 1.0 / 500.0;
    transform4 = CATransform3DScale(aView.layer.transform, 0.95, 0.95, 1);
    
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.values = [NSArray arrayWithObjects:
                        [NSValue valueWithCATransform3D:transform],
                        [NSValue valueWithCATransform3D:transform1],
                        [NSValue valueWithCATransform3D:transform2],
                        [NSValue valueWithCATransform3D:transform3],
                        [NSValue valueWithCATransform3D:transform4],
                        [NSValue valueWithCATransform3D:aView.layer.transform],
                        nil];
    animation.duration = duration;
    animation.speed = 1;
    [aView.layer addAnimation:animation forKey:kAnimationKeyWordsDef];
    

}
/*      AnimationType_Enlarge,                   //中心放大         */
+ (void) animateElasticEnlargeWithView:(UIView *)aView AndAfter:(NSTimeInterval)after andDuration:(NSTimeInterval)duration{
    
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DScale(aView.layer.transform, 0.3, 0.3, 0);

    CATransform3D transform2 = CATransform3DIdentity;
    transform2 = CATransform3DScale(aView.layer.transform, 1, 1, 0);
    
    
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.values = [NSArray arrayWithObjects:
                        [NSValue valueWithCATransform3D:transform],
                        [NSValue valueWithCATransform3D:aView.layer.transform],
                        nil];
    animation.duration = duration;
    [aView.layer addAnimation:animation forKey:kAnimationKeyWordsDef];
    
}
/*      AnimationType_ScrollIm,                  //滚入              */
+ (void) animateScrollWithView:(UIView *)aView AndAfter:(NSTimeInterval)after andDuration:(NSTimeInterval)duration{
    
    
    CATransform3D  transform3d = CATransform3DIdentity;
    transform3d = CATransform3DRotate(aView.layer.transform, -M_PI_2, 0, 0, 1);
    
    
    CAKeyframeAnimation * transform  = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    transform.values = [NSArray arrayWithObjects:
                        [NSValue valueWithCATransform3D:transform3d],
                        [NSValue valueWithCATransform3D:aView.layer.transform],
                        nil];
    transform.duration = duration;
    
    CAKeyframeAnimation * move = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    move.values = [NSArray arrayWithObjects:
                   [NSNumber numberWithFloat:aView.layer.position.x - aView.layer.bounds.size.width],
                   [NSNumber numberWithFloat:aView.layer.position.x],
                   nil];
    move.duration = duration;
    
    
    CAKeyframeAnimation * fade = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    fade.values = [NSArray arrayWithObjects:
                   [NSNumber numberWithFloat:0],
                   [NSNumber numberWithFloat:aView.layer.opacity],
                   nil];
    fade.duration = duration*0.8;
    
    
    CAAnimationGroup * group = [CAAnimationGroup animation];
    group.animations = [NSArray arrayWithObjects:transform,move,fade, nil];
    group.duration = duration;
    
    [aView.layer addAnimation:group forKey:kAnimationKeyWordsDef];

}
/*      AnimationType_Miter,                    //光速进入         */
+ (void)animateBrakesWithView:(UIView *)aView AndAfter:(NSTimeInterval)after andDuration:(NSTimeInterval)duration{
    
    float start = aView.center.x + aView.bounds.size.width;
    float end = aView.center.x;
    
    CATransform3D trans1 = CATransform3DIdentity;
    trans1.m21 = (M_PI_2/180.0 * -40);
    CATransform3D trans2 = CATransform3DIdentity;
    trans2.m21 = (M_PI_2/180.0 * 30);
    CATransform3D trans3 = CATransform3DIdentity;
    trans3.m21 = (M_PI_2/180.0 * -15);
    
    CATransform3D transaction =  aView.layer.transform;

    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.values = [NSArray arrayWithObjects:
                        [NSValue valueWithCATransform3D:trans1],
                        [NSValue valueWithCATransform3D:trans2],
                        [NSValue valueWithCATransform3D:trans3],
                        [NSValue valueWithCATransform3D:transaction],
                        nil];
    animation.keyTimes = [NSArray arrayWithObjects:
                          [NSNumber numberWithFloat:0.0],
                          [NSNumber numberWithFloat:0.6],
                          [NSNumber numberWithFloat:0.8],
                          [NSNumber numberWithFloat:1.0],
                          nil];
    animation.duration = duration;

    CAKeyframeAnimation * move = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    move.values = [NSArray arrayWithObjects:[NSNumber numberWithFloat:start],[NSNumber numberWithFloat:end], nil];
    move.duration = duration*0.6;
    
    CAAnimationGroup * group = [CAAnimationGroup animation];
    group.animations = [NSArray arrayWithObjects:animation,move, nil];
    group.duration = duration;
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    [aView.layer addAnimation:group forKey:kAnimationKeyWordsDef];

    [CATransaction commit];
}
/*      AnimationType_Swing,                    //摇摆              */
+ (void)animateSwingWithView:(UIView *)aView AndAfter:(NSTimeInterval)after andDuration:(NSTimeInterval)duration{
    
    CATransform3D transformr5 = CATransform3DIdentity;
    //apply perspective
//    transformr5.m34 = - 1.0 / 500.0;
    //rotate by 180 degrees along the Y axis
    transformr5 = CATransform3DRotate(aView.layer.transform, -10/180.0*M_PI, 0, 0, 1);
    
    CATransform3D transforml3 = CATransform3DIdentity;
    //apply perspective
    transforml3.m34 = - 1.0 / 500.0;
    //rotate by 180 degrees along the Y axis
    transforml3 = CATransform3DRotate(aView.layer.transform, 3/180.0*M_PI, 0, 0, 1);
    
    CATransform3D transformr3 = CATransform3DIdentity;
    //apply perspective
    transformr3.m34 = - 1.0 / 500.0;
    //rotate by 180 degrees along the Y axis
    transformr3 = CATransform3DRotate(aView.layer.transform, -3/180.0*M_PI, 0, 0, 1);
    
    CATransform3D transforml2 = CATransform3DIdentity;
    //apply perspective
    transforml2.m34 = - 1.0 / 500.0;
    //rotate by 180 degrees along the Y axis
    transforml2 = CATransform3DRotate(aView.layer.transform, 2/180.0*M_PI, 0, 0, 1);
    
    CATransform3D transformr1 = CATransform3DIdentity;
    //apply perspective
    transformr1.m34 = - 1.0 / 500.0;
    //rotate by 180 degrees along the Y axis
    transformr1 = CATransform3DRotate(aView.layer.transform, -1/180.0*M_PI, 0, 0, 1);
    
    
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.values = [NSArray arrayWithObjects:
                        [NSValue valueWithCATransform3D:aView.layer.transform],
                        [NSValue valueWithCATransform3D:transformr5],
                        [NSValue valueWithCATransform3D:transforml3],
                        [NSValue valueWithCATransform3D:transformr3],
                        [NSValue valueWithCATransform3D:transforml2],
                        [NSValue valueWithCATransform3D:transformr1],
                        [NSValue valueWithCATransform3D:aView.layer.transform],
                        nil];
    animation.duration = duration;
    
    
    CAKeyframeAnimation * move = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    move.values = [NSArray arrayWithObjects:
                        [NSNumber numberWithFloat:aView.layer.position.x],
                        [NSNumber numberWithFloat:aView.layer.position.x - aView.layer.bounds.size.width * 0.25],
                        [NSNumber numberWithFloat:aView.layer.position.x + aView.layer.bounds.size.width * 0.2],
                        [NSNumber numberWithFloat:aView.layer.position.x - aView.layer.bounds.size.width * 0.15],
                        [NSNumber numberWithFloat:aView.layer.position.x + aView.layer.bounds.size.width * 0.1],
                        [NSNumber numberWithFloat:aView.layer.position.x - aView.layer.bounds.size.width * 0.05],
                        [NSNumber numberWithFloat:aView.layer.position.x],
                        nil];
    move.duration = duration;
    
    CAAnimationGroup * group = [CAAnimationGroup animation];
    group.animations = [NSArray arrayWithObjects:animation,move, nil];
    group.duration = duration;
    [aView.layer addAnimation:group forKey:kAnimationKeyWordsDef];
}
/*      AnimationType_Shake,                    //抖动              */
+ (void)animateShakeWithView:(UIView *)aView AndAfter:(NSTimeInterval)after andDuration:(NSTimeInterval)duration{

    
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DScale(aView.layer.transform, 1, 1, 1);

    CATransform3D transform1 = CATransform3DIdentity;
    transform1 = CATransform3DScale(aView.layer.transform, 1.25, 0.75, 1);
    
    CATransform3D transform2 = CATransform3DIdentity;
    transform2 = CATransform3DScale(aView.layer.transform, 0.75, 1.25, 1);
    
    CATransform3D transform3 = CATransform3DIdentity;
    transform3 = CATransform3DScale(aView.layer.transform, 1.15, 0.85, 1);
    
    CATransform3D transform4 = CATransform3DIdentity;
    transform4 = CATransform3DScale(aView.layer.transform, 0.95, 1.05, 1);
    
    
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.values = [NSArray arrayWithObjects:
                        [NSValue valueWithCATransform3D:transform],
                        [NSValue valueWithCATransform3D:transform1],
                        [NSValue valueWithCATransform3D:transform2],
                        [NSValue valueWithCATransform3D:transform3],
                        [NSValue valueWithCATransform3D:transform4],
                        [NSValue valueWithCATransform3D:transform],
                        [NSValue valueWithCATransform3D:aView.layer.transform],
                        nil];
    animation.duration = duration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [aView.layer addAnimation:animation forKey:kAnimationKeyWordsDef];
    
    //#warning  you wen ti

    

}
/*      AnimationType_Flip,                     //旋转               */
+ (void)animateFlipWithView:(UIView *)aView AndAfter:(NSTimeInterval)after andDuration:(NSTimeInterval)duration{
    
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DRotate(transform, M_PI - M_PI/180.0, 0, 0, 1);
    
    CATransform3D transform1 = CATransform3DIdentity;
    transform1 = CATransform3DRotate(transform, M_PI - M_PI/180.0, 0, 0, 1);
    
    CAKeyframeAnimation * reversAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    reversAnimation.values  = [NSArray arrayWithObjects:
                               [NSValue valueWithCATransform3D:aView.layer.transform],
                               [NSValue valueWithCATransform3D:transform],
                               [NSValue valueWithCATransform3D:transform1],
                               nil];
    reversAnimation.duration = duration;

    [aView.layer addAnimation:reversAnimation forKey:kAnimationKeyWordsDef];

}
/*      AnimationType_Reversal,                //翻转                */
+ (void)animateReversalWithView:(UIView *)aView AndAfter:(NSTimeInterval)after andDuration:(NSTimeInterval)duration{
   
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DRotate(aView.layer.transform, M_PI , 0, 1, 0);
    transform = CATransform3DScale(transform, 1.2, 1.2, 1);
    
    CATransform3D transform1 = CATransform3DIdentity;
    transform1 = CATransform3DRotate(aView.layer.transform, 2*M_PI , 0, 1, 0);
    transform1 = CATransform3DScale(transform1, 1.0, 1.0, 1.0);
    CAKeyframeAnimation * reversAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    reversAnimation.values  = [NSArray arrayWithObjects:
                               [NSValue valueWithCATransform3D:aView.layer.transform],
                               [NSValue valueWithCATransform3D:transform],
                               [NSValue valueWithCATransform3D:transform1],
                               nil];
    reversAnimation.duration = duration;
    
    
    CAAnimationGroup * group = [CAAnimationGroup animation];
    group.animations = [NSArray arrayWithObjects:reversAnimation, nil];
    group.duration = duration;
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [aView.layer addAnimation:group forKey:kAnimationKeyWordsDef];
    [CATransaction commit];
 
    
}
/*      AnimationType_Pendulum,               //悬摆                */
+ (void)animatePendulumWithView:(UIView *)aView AndAfter:(NSTimeInterval)after andDuration:(NSTimeInterval)duration{
    
    CATransform3D transforml15 = CATransform3DIdentity;
    transforml15 = CATransform3DRotate(aView.layer.transform, 15/180.0*M_PI, 0, 0, 1);
   
    CATransform3D transformr10 = CATransform3DIdentity;
    transformr10 = CATransform3DRotate(aView.layer.transform, -10/180.0*M_PI, 0, 0, 1);
    
    CATransform3D transforml5 = CATransform3DIdentity;
    transforml5 = CATransform3DRotate(aView.layer.transform, 5/180.0*M_PI, 0, 0, 1);
    
    CATransform3D transformr5 = CATransform3DIdentity;
    transformr5 = CATransform3DRotate(aView.layer.transform, -5/180.0*M_PI, 0, 0, 1);
    
    
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.values = [NSArray arrayWithObjects:
                        [NSValue valueWithCATransform3D:aView.layer.transform],
                        [NSValue valueWithCATransform3D:transforml15],
                        [NSValue valueWithCATransform3D:transformr10],
                        [NSValue valueWithCATransform3D:transforml5],
                        [NSValue valueWithCATransform3D:transformr5],
                        [NSValue valueWithCATransform3D:aView.layer.transform],
                        nil];
    animation.duration = duration;
    
    [aView.layer addAnimation:animation forKey:kAnimationKeyWordsDef];
}
/*      AnimationType_FadeOut,                //淡出                */
+ (void)animateFadeOutWithView:(UIView *)aView AndAfter:(NSTimeInterval)after andDuration:(NSTimeInterval)duration{
    
    CAKeyframeAnimation * fade = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    fade.values = [NSArray arrayWithObjects:
                   [NSNumber numberWithFloat:aView.layer.opacity],
                   [NSNumber numberWithFloat:0],
                   nil];
    fade.duration = duration;
    fade.removedOnCompletion = YES;
    
    [aView.layer addAnimation:fade forKey:kAnimationKeyWordsDef];
    
}
/*      AnimationType_ReversalOut,            //翻转消失           */
+ (void)animateReversalOutWithView:(UIView *)aView AndAfter:(NSTimeInterval)after andDuration:(NSTimeInterval)duration{
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DRotate(aView.layer.transform, M_PI_2, 0, 1, 0);

    CATransform3D transform1 = CATransform3DIdentity;
    transform1 = CATransform3DRotate(aView.layer.transform, -20 * M_PI / 180.0, 0, 1, 0);
    
    CAKeyframeAnimation * reversAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    reversAnimation.values  = [NSArray arrayWithObjects:
                               [NSValue valueWithCATransform3D:aView.layer.transform],
                               [NSValue valueWithCATransform3D:transform1],
                               [NSValue valueWithCATransform3D:transform],
                               nil];
    reversAnimation.keyTimes = [NSArray arrayWithObjects:
                                [NSNumber numberWithFloat:0],
                                [NSNumber numberWithFloat:0.3],
                                [NSNumber numberWithFloat:1.0],
                                nil];
    reversAnimation.duration = duration;

    CAKeyframeAnimation * fadeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    fadeAnimation.values  = [NSArray arrayWithObjects:
                              [NSNumber numberWithFloat:aView.layer.opacity],
                              [NSNumber numberWithFloat:0],
                              nil];
    fadeAnimation.keyTimes = [NSArray arrayWithObjects:
                              [NSNumber numberWithFloat:0.3],
                              [NSNumber numberWithFloat:1.0],
                              nil];
    fadeAnimation.duration = duration;
    fadeAnimation.removedOnCompletion = YES;
    
    CAAnimationGroup * group = [CAAnimationGroup animation];
    group.animations = [NSArray arrayWithObjects:reversAnimation,fadeAnimation, nil];
    group.duration = duration;
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [aView.layer addAnimation:group forKey:kAnimationKeyWordsDef];
    [CATransaction commit];

}

@end
