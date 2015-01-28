//
//  AnimationControl.m
//  PodForAnimationTest
//
//  Created by admin on 15-1-21.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import "AnimationControl.h"
#import "CombiationBackGroundView.h"

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


/**
 *  组合动画
 *
 *  @param circles   内部的图形
 *  @param superview 外部view
 *
 *#mark sina c = 3/1
        cos c  = 2/3
 
              C
             /|
           1/ | 2
           /  |
          -----
            3
 */
+(void)animationCombiationCircle:(NSArray *)circles andSuperView:(UIView *)superview{
    
    AnimationControl  * control = [[AnimationControl alloc] init];
    control.circles = circles;
    control.tempSuperView = superview;
    control.Points1 = [NSMutableArray array];
    UIView * temp = circles.lastObject;
    NSInteger  count = circles.count;
    
    CGFloat oneCorner = 360.0/count;
    CGPoint center = control.oldPoint = CGPointMake(superview.frame.size.width/2, superview.frame.size.height/2);

        //定义出边
    CGFloat width = temp.frame.size.width*1.5;

    //    float a = sin(30*M_PI/180);


    //顺时针计算
    for (NSInteger i =0; i<count; i++) {
        CGPoint newCneter ;

        //计算角度 求出圆上点相对圆心的坐标值 无符号
        CGFloat x , y;
        CGFloat currentAngle =oneCorner*i + 90;
        if (currentAngle > 360 ) {
            currentAngle -=360;
        }
        if (currentAngle == 0) {
            //x轴负向 0°
            x = - width;
            y = 0;
        }
        else if (currentAngle < 90){
            
            //第一象限 0°<   < 90°
            float cos_a = cos(currentAngle*M_PI/180);
            float sin_a = sin(currentAngle*M_PI/180);
            x = -cos_a *width;
            y = -sin_a *width;
        }
        else if (currentAngle == 90){
            //y轴正向 90°
            x  = 0;
            y  = -width;
        }
        else if ((90 < currentAngle) && ( currentAngle < 180)){
            //第二象限 90°<   < 180°
            
            x  = cos((180 - currentAngle)*M_PI/180)*width;
            y  = -sin((180 - currentAngle)*M_PI/180)*width;
        }
        else if (currentAngle == 180){
            //x正向 180°
            x = width;
            y = 0;
        }
        else if ((180 < currentAngle) && ( currentAngle < (270))){
            //第三象限 180°<   < 270°
            
            x  = cos((currentAngle - 180)*M_PI/180)*width;
            y  = sin((currentAngle - 180)*M_PI/180)*width;
            
        }
        else if (currentAngle == (270)){
            //270°
            x  = 0;
            y  = width;
        }
        else if (((270) < currentAngle) && ( currentAngle < (360))){
            //第三象限 270°<   < 360°
            
            x  = -cos((360 - currentAngle) *M_PI/180)*width;
            y  = sin((360 - currentAngle) *M_PI/180)*width;

        }else{
            
        }
        CGAffineTransform endAngle = CGAffineTransformMakeRotation((currentAngle-90) * (M_PI / 180.0f));
        UIView * tempView =  control.circles[i];
        tempView.transform = endAngle;

        newCneter = CGPointMake(center.x + x, center.y + y);
//        tempView.center = newCneter;
        [control.Points1 addObject:NSStringFromCGPoint(newCneter)];
    }
    
    
    control.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:control selector:@selector(change) userInfo:nil repeats:YES];
    
}
- (void) change{

    [UIView animateWithDuration:1 animations:^{
        self.tempSuperView.transform = CGAffineTransformScale(self.tempSuperView.transform, -1, -1);
    }];
    
    if (!self.status) {
        
        [UIView animateWithDuration:1 animations:^{
            
            for (NSInteger i = 0; i<self.circles.count; i++) {
                UIView* temp = self.circles[i];
                temp.center = CGPointFromString(self.Points1[i]);
                temp.transform = CGAffineTransformScale(temp.transform, -1, -1);
                temp.alpha = 1;
            }
            
        }];
        

    }else{
        [UIView animateWithDuration:1 animations:^{
            
            for (NSInteger i = 0; i<self.circles.count; i++) {
                UIView* temp = self.circles[i];
                temp.center = self.oldPoint;
                temp.alpha = .4;
            }
        }];
        

    }
    
    self.status = !self.status;
}


+ (void) animationCombiationSuperView:(UIView *)superview withMaxSize:(CGFloat )maxSize andCellSize:(CGFloat)cellsize  andCellCount:(NSInteger)count{
    CGFloat oneCorner = 360.0/count;

    for (NSInteger i = 0; i<count; i++) {
        
        CombiationBackGroundView * view = [[CombiationBackGroundView alloc] init];
        view.selfSize = maxSize;
        view.cellSize = cellsize;
        view.center = CGPointMake(superview.frame.size.width/2, superview.frame.size.height/2);
        [view startAnimation];
        [superview addSubview:view];
//        view.transform = CGAffineTransformMakeRotation((oneCorner * i + 90) * (M_PI / 180.0f));
        view.transform = CGAffineTransformRotate(view.transform, (oneCorner * i + 90) * (M_PI / 180.0f)); //实现的是旋转
    }
    
}

@end

















