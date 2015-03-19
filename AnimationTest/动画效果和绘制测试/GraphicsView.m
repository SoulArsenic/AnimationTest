//
//  GraphicsView.m
//  AnimationTest
//
//  Created by admin on 15-1-23.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import "GraphicsView.h"
#import "Tool.h"


#define   DEGREES_TO_RADIANS(degrees)  ((M_PI * degrees)/ 180)

/**
 *  拉扯点最大距离
 *
 *
 *  @return 70
 */
#define  MAX_Distance 90


@implementation GraphicsView




-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.pointWidth = 15;
    }
    return self;
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch * touch = [touches anyObject];
    self.outOfBounds = NO;
    self.start = self.end = [touch locationInView:self];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    self.end = [[touches anyObject] locationInView:self];
    if (self.outOfBounds) {
        [self setNeedsDisplay];

        return;
    }

    [self setNeedsDisplay];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if (CGRectContainsPoint(CGRectMake(self.start.x - 10, self.start.y-10, 20, 20), self.end)) {
        self.outOfBounds = NO;
    }
    self.end = self.start;
    [self setNeedsDisplay];
}

/**
 *  移动测试
 *
 *
 */

- (BOOL) isOnSpecial{
    // 能被45°整除的角度
    // 以起点为 （0，0) 的坐标系
    
    CGFloat x = self.end.x - self.start.x;
    CGFloat y = self.end.y - self.start.y;
    
    if ((x == 0) || (y == 0) || (ABS(x) == ABS(y))) {
        return YES;
    }
    
    return NO;
}

- (void)drawRect:(CGRect)rect {
    
    
    if (CGPointEqualToPoint(self.start, CGPointZero)) {
        return;
    }
    if (self.outOfBounds) {
        return;
    }

    
/*
 
 特殊点判断处理
 
 // 定位点 bug修复用
 //    self.start = CGPointMake(168.5, 140);
 //    self.end = CGPointMake(179, 161);
 
 
 //{215, 248.5}{191, 200.5}
 //        self.start = CGPointMake(215, 248.5);
 //        self.end = CGPointMake(191, 200.5);

 Printing description of self->_start:
 (CGPoint) _start = (x=170, y=162)
 Printing description of self->_end:
 (CGPoint) _end = (x=148, y=206)
 
 
 self.start = CGPointMake(170,162);
 self.end = CGPointMake(148, 206);

 */
    

    UIColor * red = [UIColor redColor];
        [red set];
    
    
    
    //需要的参数定义
    CGPoint centerPoint = CGPointMake((self.start.x + self.end.x)/2, (self.start.y + self.end.y)/2);
    
    //始点和终点之间的距离
    CGFloat xleng = ABS(self.end.x - self.start.x);
    CGFloat yleng = ABS(self.end.y - self.start.y);
    
    CGFloat lenthStoE = sqrt((xleng * xleng) + (yleng * yleng));
    

    
    if (lenthStoE >= (MAX_Distance - 10)) {
        self.outOfBounds = YES;
    }
    
    CGFloat radius = lenthStoE - (MAX_Distance - lenthStoE)/10;
    
    
    //第一个点
#pragma mark -手势的两个点
    UIBezierPath * bezPoint = [UIBezierPath bezierPathWithArcCenter:self.start
                                                             radius:(self.pointWidth - 2 - MIN(ABS(lenthStoE)/10*.6, 3))
                                                         startAngle:0
                                                           endAngle:2*M_PI
                                                          clockwise:YES];
    [bezPoint fill];
    
    
    UIBezierPath * bezPointo = [UIBezierPath bezierPathWithArcCenter:self.end
                                                              radius:self.pointWidth
                                                          startAngle:0 endAngle:2*M_PI clockwise:YES];
    [bezPointo fill];
    
    
    
#pragma mark -两点之间的绘制
    
    CGPoint tempp1 = CGPointZero;
    CGPoint tempp2 = CGPointZero;
    CGFloat x = self.end.x - self.start.x;
    CGFloat y = self.end.y - self.start.y;
    
    if ([self isOnSpecial]) {
        
        if (x == 0) {
            //在竖直同一条线
            CGFloat current =  ((y>0)? lenthStoE/2 : -lenthStoE/2);
            
            tempp1 = CGPointMake( centerPoint.x  + current, centerPoint.y);
            tempp2 = CGPointMake( centerPoint.x  - current, centerPoint.y );
            
            
        }else if (y == 0){
            
            CGFloat current =((x>0)?  lenthStoE/2 : -lenthStoE/2);
            tempp1 = CGPointMake(centerPoint.x , centerPoint.y - current);
            tempp2 = CGPointMake(centerPoint.x , centerPoint.y + current);
            
        }else{
            QuadrantLocation location = [Tool point:self.end RelativeToCenterPoint:self.start];
            
            switch (location) {
                case QuadrantLocation_1:
                {
                    tempp1 = CGPointMake(self.end.x, self.start.y);
                    tempp2 = CGPointMake(self.start.x, self.end.y);
                }
                    break;
                case QuadrantLocation_2:
                {
                    tempp2 = CGPointMake(self.end.x, self.start.y);
                    tempp1 = CGPointMake(self.start.x, self.end.y);
                }
                    break;
                case QuadrantLocation_3:
                {
                    // 这是对的
                    tempp1 = CGPointMake(self.end.x, self.start.y);
                    tempp2 = CGPointMake(self.start.x, self.end.y);
                }
                    break;
                case QuadrantLocation_4:
                {
                    tempp2 = CGPointMake(self.end.x, self.start.y);
                    tempp1 = CGPointMake(self.start.x, self.end.y);
                    
                }
                    break;
                default:
                {
                }
                    break;
            }

        }
        
    }else{
   
        //角度
        CGFloat temp =  atan2(ABS(x), ABS(y)) * 180 *M_1_PI;
        CGFloat need = 45 - temp;
        CGFloat xiebian = sqrt(2* (lenthStoE/2 * lenthStoE/2));
        
        //得到目标的点数值 相对数值（0,0）
        CGFloat xPox = sin(DEGREES_TO_RADIANS(need)) * xiebian;
        CGFloat yPox = cos(DEGREES_TO_RADIANS(need)) * xiebian;
        
        QuadrantLocation location = [Tool point:self.end RelativeToCenterPoint:self.start];
        
        switch (location) {
            case QuadrantLocation_1:
            {
                tempp1 = CGPointMake(self.start.x - yPox, self.start.y - xPox);
                tempp2 = CGPointMake(self.start.x + xPox, self.start.y - yPox);
            }
                break;
            case QuadrantLocation_2:
            {
                tempp1 = CGPointMake(self.start.x - xPox, self.start.y - yPox);
                tempp2 = CGPointMake(self.start.x + yPox, self.start.y - xPox);
            }
                break;
            case QuadrantLocation_3:
            {
                // 这是对的
                tempp1 = CGPointMake(self.start.x + yPox, self.start.y + xPox);
                tempp2 = CGPointMake(self.start.x - xPox, self.start.y + yPox);
            }
                break;
            case QuadrantLocation_4:
            {
                tempp1 = CGPointMake(self.start.x + xPox, self.start.y + yPox);
                tempp2 = CGPointMake(self.start.x - yPox, self.start.y + xPox);
            }
                break;
            default:
            {
            }
                break;
        }
        
    
    }
    
    
    //圆弧的圆心点 cyanColor
    CGPoint p1 = CGPointMake(tempp1.x * 2 - centerPoint.x , tempp1.y * 2 - centerPoint.y);
    CGPoint p2 = CGPointMake(tempp2.x * 2 - centerPoint.x , tempp2.y * 2 - centerPoint.y);

    
    

    /*
//两个圆弧的中点 绘制
     
     UIBezierPath * bezp1 = [UIBezierPath bezierPathWithArcCenter:p1
     radius:5
     startAngle:0
     endAngle:2*M_PI
     clockwise:YES];
     [bezp1 addLineToPoint:self.end];
     [bezp1 stroke];
   
     UIBezierPath * bezp2 = [UIBezierPath bezierPathWithArcCenter:p2
     radius:5
     startAngle:0
     endAngle:2*M_PI
     clockwise:YES];
     [bezp2 fill];
     

     */
    
     //弧度
    
    //起始位置的弧度值
    CGFloat startAngle = 0;

    if (self.end.x - p1.x) {
        
        startAngle  = atan(((self.end.y - p1.y))/((self.end.x - p1.x)));
        QuadrantLocation qu  = [Tool point:p1 RelativeToCenterPoint:self.end];
        switch (qu) {
            case QuadrantLocation_1:
                break;
            case QuadrantLocation_2:
            {
                startAngle = startAngle + M_PI ;
            }
                break;
            case QuadrantLocation_3:
            {
                startAngle = startAngle + M_PI ;
            }
                break;
            case QuadrantLocation_4:
                break;
                
            default:{
            
                if (self.end.y > p1.y) {
                    startAngle = 0;
                }else {
                    startAngle = M_PI;
                }
                
            }
                break;
        }

        
    }else{
        if (self.end.y >= p1.y) {
            
            startAngle = M_PI_2;
        }else{
            startAngle = M_PI_2 + M_PI;
        }
        //90 270
        
    }
    
    /**
     *  结束位置的弧度值
     */
    CGFloat endAngle = startAngle + M_PI_4;

    if ((self.start.x - p1.x)!= 0) {
        
        endAngle  = atan(((self.start.y - p1.y))/((self.start.x - p1.x)));
        //
        QuadrantLocation qu  = [Tool point:p1 RelativeToCenterPoint:self.start];
        switch (qu) {
            case QuadrantLocation_1:
            {
            }
                break;
            case QuadrantLocation_2:
            {
                endAngle = endAngle + M_PI ;
            }
                break;
            case QuadrantLocation_3:
            {
                endAngle = endAngle + M_PI ;
            }
                break;
            case QuadrantLocation_4:
            {
            }
                break;
                
            default:{

                if (p1.x <= self.start.x) {
                    endAngle = 0;
                }else{
                    endAngle  = M_PI;
                }
            }
                break;
        }
        
        
    }else{
        if (self.start.y > p1.y) {
            
            endAngle = M_PI_2;
        }else{
            endAngle = M_PI_2 + M_PI;

        }
        //90 270
        
    }
    
    
    
    UIBezierPath * bezierpath  = [UIBezierPath bezierPathWithArcCenter:p1
                                                                radius:radius
                                                            startAngle:startAngle
                                                              endAngle: endAngle
                                                             clockwise:YES];


    [bezierpath addArcWithCenter:p2
                          radius:radius
                      startAngle:M_PI + startAngle
                        endAngle:M_PI + endAngle
                       clockwise:YES];

    //填充色
    [red set];
    
    
    [bezierpath fill];
    
}





// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    
//
//    if (CGPointEqualToPoint(self.start, CGPointZero)) {
//        return;
//    }
//    if (self.outOfBounds) {
//        return;
//    }
//    CGFloat radius = (self.end.x - self.start.x);
//
//    UIColor * red = [UIColor redColor];
////    [red set];
//
//    //半径
//
//    
//    
////    NSLog(@"%f",radius);
//    //拉扯位置的中点
//    CGFloat locationx = self.end.x - radius/2;
//    CGFloat locationy = 200;
//    
//
//    if (CGPointEqualToPoint(self.start, self.end)) {
//        return;
//    }
//    if (ABS(radius) > 120) {
//        self.outOfBounds = YES;
//        return;
//    }
//    //第一个点
//
//    UIBezierPath * bezPoint = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.start.x + ((radius)/10), locationy) radius:(18 - MIN(ABS(radius)/10*.6, 5) ) startAngle:0 endAngle:DEGREES_TO_RADIANS(360) clockwise:YES];
//    [bezPoint fill];
//
//    
//    radius = ABS(radius);
//    //弧形的中心点
//    CGFloat xPox = locationx;
//    CGFloat yPox = locationy - radius - (20 - (radius - 50)/5)/2 ;
//    
//    
//    //所画的角度
//    NSInteger corner = 30 + (radius - 50)/5;
//
//    //开始的角度
//    NSInteger startradians = 90 - corner/2;
//    
//    
//    
//    UIBezierPath *bezierpath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(xPox, yPox)
//                                                       radius:radius
//                                                   startAngle:DEGREES_TO_RADIANS(startradians)
//                                                     endAngle:DEGREES_TO_RADIANS((startradians + corner))
//                                                    clockwise:YES];
//
//    
//    
//    //第二个点
//    CGFloat nXpox = xPox  ;
//    CGFloat nYpox = (radius*2 + 20 - (radius - 50)/5) + yPox;
//    
// 
//
//    UIBezierPath * bezPointo = [UIBezierPath bezierPathWithArcCenter:
//                                CGPointMake(self.end.x , locationy)
//                                                              radius:20
//                                                          startAngle:0 endAngle:DEGREES_TO_RADIANS(360) clockwise:YES];
//    [bezPointo fill];
//    
//    //填充色
//    [red set];
//    
//    [bezierpath addArcWithCenter:CGPointMake(nXpox ,
//                                             nYpox )
//                          radius:radius
//                      startAngle:DEGREES_TO_RADIANS((180 + startradians))
//                        endAngle:DEGREES_TO_RADIANS((180 + startradians + corner))
//                       clockwise:YES];
//    
//    [bezierpath fill];
//}


@end
