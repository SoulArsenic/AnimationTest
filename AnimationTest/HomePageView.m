//
//  HomePageView.m
//  AnimationTest
//
//  Created by lengbinbin on 15/2/3.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import "HomePageView.h"

#define   DEGREES(degrees)  ((M_PI * degrees)/ 180)

@implementation HomePageView


-(void)updateRed:(CGFloat)numberRed andGren:(CGFloat)numbergreen andBlue:(CGFloat)numberblue andPurple:(CGFloat)numberPurple
{
    if(numberRed){
        self.oldpercentred = self.percentred;
        self.percentred = numberRed;
    }
    if(numbergreen){
        self.oldpercentgreen = self.percentgreen;
        self.percentgreen = numbergreen;
    }
    if(numberblue){
        self.oldpercentblue = self.percentblue;
        self.percentblue = numberblue;
    }
    if(numberPurple){
        self.oldpercentpurple = self.percentpurple;
        self.percentpurple = numberPurple;
    }
//    [self setNeedsDisplay];

}

-(void)drawAction{
    
    [self anmiationDrawLayer];

}
-(void)anmiationDrawLayer{
    /**
     *  这里要注意 需要用一个备份做遍历
     */
    NSArray * array = self.layer.sublayers;
    NSArray * tempArray = [NSArray arrayWithArray:array];
    for (id temp in tempArray) {
        if ([temp isKindOfClass:[CAShapeLayer class]]) {
            [temp removeFromSuperlayer];
        }
    }
    
    CGPoint center  = CGPointMake(200, 200);
    CGFloat widthRed = 60;
    CGFloat widthGreen = widthRed - 4;
    CGFloat widthbule = widthGreen - 4;
    CGFloat widthPurple = widthbule - 4;

    
    
    //红
    UIBezierPath * bezPointRed = [UIBezierPath bezierPathWithArcCenter:center
                                                                radius:widthRed
                                                            startAngle:DEGREES(182)
                                                              endAngle:DEGREES((182 + _percentred * 358))
                                                             clockwise:YES];
    
    [self.layer addSublayer:[self getShapeLayerWith:bezPointRed.CGPath andStrokeColor:[UIColor redColor] ndFillColor:nil andLineWidth:2]];
    
    
    //绿
    UIBezierPath * bezPointGreen = [UIBezierPath bezierPathWithArcCenter:center
                                                                  radius:widthGreen
                                                              startAngle:DEGREES(182)
                                                                endAngle:DEGREES((182 + _percentgreen * 358))
                                                               clockwise:YES];
    [self.layer addSublayer:[self getShapeLayerWith:bezPointGreen.CGPath andStrokeColor:[UIColor greenColor] ndFillColor:nil andLineWidth:2]];
    
    
    //蓝
    UIBezierPath * bezPointblueColor = [UIBezierPath bezierPathWithArcCenter:center
                                                                      radius:widthbule
                                                                  startAngle:DEGREES(182)
                                                                    endAngle:DEGREES((182 + _percentblue * 358))
                                                                   clockwise:YES];

    [self.layer addSublayer:[self getShapeLayerWith:bezPointblueColor.CGPath andStrokeColor:[UIColor blueColor] ndFillColor:nil andLineWidth:2]];
    //紫
    UIBezierPath * bezPointpurpleColor = [UIBezierPath bezierPathWithArcCenter:center
                                                                        radius:widthPurple
                                                                    startAngle:DEGREES(182)
                                                                      endAngle:DEGREES((182 + _percentpurple * 358))
                                                                     clockwise:YES];

        [self.layer addSublayer:[self getShapeLayerWith:bezPointpurpleColor.CGPath andStrokeColor:[UIColor purpleColor] ndFillColor:nil andLineWidth:2]];
}

- (CABasicAnimation *) getAnimation{
    CABasicAnimation *bas=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    bas.duration=1;
    bas.fromValue=[NSNumber numberWithInteger:0];
    bas.toValue=[NSNumber numberWithInteger:1];
    return bas;
}

- (CAShapeLayer *) getShapeLayerWith:(CGPathRef )ref andStrokeColor:(UIColor *)storkeColor ndFillColor:(UIColor *)fillColor andLineWidth:(CGFloat )linewidth
{
    CAShapeLayer *  arcLayer=[CAShapeLayer layer];
    arcLayer.strokeColor =storkeColor.CGColor;
    if (fillColor) arcLayer.fillColor = fillColor.CGColor;
    else arcLayer.fillColor = [UIColor clearColor].CGColor;
    arcLayer.path = ref;
    arcLayer.lineWidth = linewidth;
    [arcLayer addAnimation:[self getAnimation] forKey:@"key"];
    return arcLayer;
}

-(void)drawRect:(CGRect)rect{
    return;
    CGPoint center  = CGPointMake(200, 200);
    CGFloat widthRed = 50;
    CGFloat widthGreen = widthRed - 3;
    CGFloat widthbule = widthGreen - 2;
    CGFloat widthPurple = widthbule - 2;
    //红
    UIBezierPath * bezPointRed = [UIBezierPath bezierPathWithArcCenter:center
                                                             radius:widthRed
                                                         startAngle:DEGREES(182)
                                                           endAngle:DEGREES((182 + _percentred * 358))
                                                          clockwise:YES];
    bezPointRed.lineWidth = 4;
    [[UIColor redColor] set];
    [UIView animateWithDuration:5 animations:^{
        [bezPointRed stroke];        
    }];

       //绿
    UIBezierPath * bezPointGreen = [UIBezierPath bezierPathWithArcCenter:center
                                                                radius:widthGreen
                                                            startAngle:DEGREES(182)
                                                              endAngle:DEGREES((182 + _percentgreen * 358))
                                                             clockwise:YES];
    bezPointGreen.lineWidth = 3;
    [[UIColor greenColor] set];
    [bezPointGreen stroke];
        //蓝
    UIBezierPath * bezPointblueColor = [UIBezierPath bezierPathWithArcCenter:center
                                                                radius:widthbule
                                                            startAngle:DEGREES(182)
                                                              endAngle:DEGREES((182 + _percentblue * 358))
                                                             clockwise:YES];
    bezPointblueColor.lineWidth = 2;
    [[UIColor blueColor] set];
    [bezPointblueColor stroke];
        //紫
    UIBezierPath * bezPointpurpleColor = [UIBezierPath bezierPathWithArcCenter:center
                                                                radius:widthPurple
                                                            startAngle:DEGREES(182)
                                                              endAngle:DEGREES((182 + _percentpurple * 358))
                                                             clockwise:YES];
    bezPointpurpleColor.lineWidth = 1;
    [[UIColor purpleColor] set];
    [bezPointpurpleColor stroke];

}

@end
