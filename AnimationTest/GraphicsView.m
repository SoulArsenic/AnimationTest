//
//  GraphicsView.m
//  AnimationTest
//
//  Created by admin on 15-1-23.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import "GraphicsView.h"
#define   DEGREES_TO_RADIANS(degrees)  ((M_PI * degrees)/ 180)
@implementation GraphicsView

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.radious = 50;
        
    }
    return self;
}

- (void) timeUpdate{
    if (_radious > 110) {
        _radious = 40;
    }
    
    self.radious +=10;
    [self setNeedsDisplay];

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch * touch = [touches anyObject];
    self.outOfBounds = NO;
    self.start = self.end = [touch locationInView:self];
    
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    self.end = [[touches anyObject] locationInView:self];
    if (self.outOfBounds) {
        return;
    }
    [self setNeedsDisplay];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    self.outOfBounds = NO;
    self.end = self.start;
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    

    if (CGPointEqualToPoint(self.start, CGPointZero)) {
        return;
    }
    if (self.outOfBounds) {
        return;
    }
    CGFloat radius = (self.end.x - self.start.x);

    UIColor * red = [UIColor redColor];
    [red set];

    //半径

    
    
    NSLog(@"%f",radius);
    //拉扯位置的中点
    CGFloat locationx = self.end.x - radius/2;
    CGFloat locationy = 200;
    

    //第一个点
    UIBezierPath * bezPoint = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.start.x + ((radius)/10), locationy) radius:(18 - MIN(ABS(radius)/10*.6, 5) ) startAngle:0 endAngle:DEGREES_TO_RADIANS(360) clockwise:YES];
    [bezPoint fill];
    if (CGPointEqualToPoint(self.start, self.end)) {
        return;
    }
    if (ABS(radius) > 120) {
        self.outOfBounds = YES;
        return;
    }
    
    radius = ABS(radius);
    //弧形的中心点
    CGFloat xPox = locationx;
    CGFloat yPox = locationy - radius - (20 - (radius - 50)/5)/2 ;
    
    
    //所画的角度
    NSInteger corner = 30 + (radius - 50)/5;

    //开始的角度
    NSInteger startradians = 90 - corner/2;
    
    
    
    UIBezierPath *bezierpath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(xPox, yPox)
                                                       radius:radius
                                                   startAngle:DEGREES_TO_RADIANS(startradians)
                                                     endAngle:DEGREES_TO_RADIANS((startradians + corner))
                                                    clockwise:YES];

    
    
    //第二个点
    CGFloat nXpox = xPox  ;
    CGFloat nYpox = (radius*2 + 20 - (radius - 50)/5) + yPox;
    
 

    UIBezierPath * bezPointo = [UIBezierPath bezierPathWithArcCenter:
                                CGPointMake(self.end.x , locationy)
                                                              radius:20
                                                          startAngle:0 endAngle:DEGREES_TO_RADIANS(360) clockwise:YES];
    [bezPointo fill];
    
    //填充色
    [red set];
    
    [bezierpath addArcWithCenter:CGPointMake(nXpox ,
                                             nYpox )
                          radius:radius
                      startAngle:DEGREES_TO_RADIANS((180 + startradians))
                        endAngle:DEGREES_TO_RADIANS((180 + startradians + corner))
                       clockwise:YES];
    
    [bezierpath fill];
}


@end
