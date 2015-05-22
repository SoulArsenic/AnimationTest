//
//  LTabbarCoverView.m
//  AnimationTest
//
//  Created by lengbinbin on 15/5/22.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import "LTabbarCoverView.h"
typedef struct {
    CGRect topRect;
    CGRect bottomRect;
    CGRect leftRect;
    CGRect rightRect;
}SeparateRect ;


@implementation LTabbarCoverView{
    NSInteger count;
    NSTimer *timer ;
    CGFloat move;
    CGRect targetFrame;
    CGRect orgRect;
}
-(void)animationMoveCoverTo:(CGRect)aimRect withDuration:(NSTimeInterval)duration{

    CGFloat step = 0.01;
    count = duration/step;
    targetFrame = aimRect;
    orgRect = self.coverView.frame;
    move = (aimRect.origin.x - self.coverView.frame.origin.x)/count;
    if (timer) {
        [timer invalidate];
    }
    timer = [NSTimer scheduledTimerWithTimeInterval:step target:self selector:@selector(updateCoverViewFrame) userInfo:nil repeats:YES];
}
static int i = 0;
- (void) updateCoverViewFrame{
    
    self.coverView.frame = CGRectMake( orgRect.origin.x +  i * move , self.coverView.frame.origin.y, self.coverView.frame.size.width, self.coverView.frame.size.height);
    [self setNeedsDisplay];
    i++;
    if (i==count) {
        i=0;
        self.coverView.frame = targetFrame;
        [timer invalidate];
        timer = nil;
    }
}


- (SeparateRect) sepRect:(CGRect)outerRect WithInner:(CGRect)innerRect {
    SeparateRect rect;
    rect.leftRect = CGRectMake(0, 0, innerRect.origin.x, outerRect.size.height);
    rect.rightRect = CGRectMake(innerRect.origin.x + innerRect.size.width, 0, outerRect.size.width - innerRect.origin.x + innerRect.size.width, outerRect.size.height);
    return rect;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    [[UIColor whiteColor] setFill];
    
//    CGRectDivide
    SeparateRect rectBg =[self sepRect:self.frame WithInner:self.coverView.frame];
    UIRectFill(rectBg.leftRect);
    UIRectFill(rectBg.rightRect);
    
    [[UIColor clearColor] setFill];
    CGRect aRect =  CGRectIntersection(self.coverView.frame,self.frame);
    UIRectFill(aRect);    
}


@end
