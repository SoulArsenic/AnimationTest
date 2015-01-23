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
    
    //3.添加路径到图形上下文
//    CGContextAddPath(context, bezierpath);
//    
//    //4.设置图形上下文状态属性
//    CGContextSetRGBStrokeColor(context, 1.0, 0, 0, 1);//设置笔触颜色
//    CGContextSetRGBFillColor(context, 0, 1.0, 0, 1);//设置填充色
//    CGContextSetLineWidth(context, 2.0);//设置线条宽度
//    CGContextSetLineCap(context, kCGLineCapRound);//设置顶点样式,（20,50）和（300,100）是顶点
//    CGContextSetLineJoin(context, kCGLineJoinRound);//设置连接点样式，(20,100)是连接点
//    /*设置线段样式
//     phase:虚线开始的位置
//     lengths:虚线长度间隔（例如下面的定义说明第一条线段长度8，然后间隔3重新绘制8点的长度线段，当然这个数组可以定义更多元素）
//     count:虚线数组元素个数
//     */
//    CGFloat lengths[2] = { 18, 9 };
//    CGContextSetLineDash(context, 0, lengths, 2);
//    /*设置阴影
//     context:图形上下文
//     offset:偏移量
//     blur:模糊度
//     color:阴影颜色
//     */
//    CGColorRef color = [UIColor grayColor].CGColor;//颜色转化，由于Quartz 2D跨平台，所以其中不能使用UIKit中的对象，但是UIkit提供了转化方法
//    CGContextSetShadowWithColor(context, CGSizeMake(2, 2), 0.8, color);
//    
//    //5.绘制图像到指定图形上下文
//    /*CGPathDrawingMode是填充方式,枚举类型
//     kCGPathFill:只有填充（非零缠绕数填充），不绘制边框
//     kCGPathEOFill:奇偶规则填充（多条路径交叉时，奇数交叉填充，偶交叉不填充）
//     kCGPathStroke:只有边框
//     kCGPathFillStroke：既有边框又有填充
//     kCGPathEOFillStroke：奇偶填充并绘制边框
//     */
//    CGContextDrawPath(context, kCGPathFillStroke);//最后一个参数是填充类型
//    
//    //6.释放对象
//    CGPathRelease(path);
//    
    
    return;
    /*
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGFloat arrowHeight = 15.0;
    CGFloat arrowWidth = 13.0;
    CGPoint arrowPoint = CGPointMake(rect.origin.x+rect.size.width/2.0f,rect.origin.y);
    CGMutablePathRef arrowPath = CGPathCreateMutable();
    CGPathMoveToPoint(arrowPath, NULL, arrowPoint.x, arrowPoint.y);
    CGPathAddLineToPoint(arrowPath, NULL, arrowPoint.x, arrowPoint.y+arrowHeight);
    CGPathAddLineToPoint(arrowPath, NULL, rect.origin.x, rect.origin.y+arrowHeight);
    CGPathAddLineToPoint(arrowPath, NULL, rect.origin.x, rect.origin.y+rect.size.height);
    CGPathAddLineToPoint(arrowPath, NULL, rect.origin.x+rect.size.width, rect.origin.y+rect.size.height);
    
    CGPathAddLineToPoint(arrowPath, NULL, rect.origin.x+rect.size.width, rect.origin.y+arrowHeight);
    CGPathAddLineToPoint(arrowPath, NULL, arrowPoint.x+arrowWidth, rect.origin.y+arrowHeight);
    CGPathCloseSubpath(arrowPath); //封口
    CGContextAddPath(ctx, arrowPath);
    
    [[UIColor redColor] setFill];
    CGContextDrawPath(ctx,kCGPathFill);
    CGContextClip(ctx);
    CGPathRelease(arrowPath);
    
    return;
    // Drawing code
    
    //画布上下文

    
    //存一份
    CGContextSaveGState(ctx);

    
    CGContextAddRect(ctx, CGRectMake(10, 10, 150, 100));
    
    // set : 同时设置为实心和空心颜色
    // setStroke : 设置空心颜色
    // setFill : 设置实心颜色
    [[UIColor cyanColor] setStroke];
    
    [[UIColor lightGrayColor] setFill];
    //    CGContextSetRGBFillColor(ctx, 0, 0, 1, 1);
    
    //画一个空心矩形
    CGContextStrokeRect(ctx, CGRectMake(10, 10, 100, 100));

    //画一个实心矩形
    CGContextFillRect(ctx, CGRectMake(110, 10, 100, 100));
    
    
    //还原

    CGContextRestoreGState(ctx);
    */
}


@end
