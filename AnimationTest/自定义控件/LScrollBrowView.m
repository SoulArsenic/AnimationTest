//
//  LScrollBrowView.m
//  AnimationTest
//
//  Created by lengbinbin on 15/5/27.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import "LScrollBrowView.h"


// 拓展

@implementation UIView (MyRectTool)

-(CGFloat)centerX{
    return self.frame.size.width/2 + self.frame.origin.x;
}
-(CGFloat)centerY{
    return self.frame.size.height/2 + self.frame.origin.y;
}

- (CGFloat) boundsWidthHelf{
    return self.bounds.size.width/2.0;
}
- (CGFloat) boundsHeightHelf{
    return self.bounds.size.height/2.0;
}

@end



@interface LScrollBrowView ()
@property (nonatomic, assign) CGPoint gestureStart;

@property (nonatomic, assign) NSInteger defaultVisibleCount;//default 3
@property (nonatomic, assign) NSInteger current;
@end

@implementation LScrollBrowView


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initAllContent];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initAllContent];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initAllContent];
    }
    return self;
}
//初始化 内容视图
- (void) initAllContent{
    
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self addGestureRecognizer:pan];

    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self addGestureRecognizer:tap];
    NSInteger totalCount = 5;
    
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(LScrollBrowViewDataSourceCount)]) {
            
            totalCount = [_delegate LScrollBrowViewDataSourceCount];
            
        }else{
            NSAssert(YES, @"未实现  LScrollBrowViewDataSourceCount  方法" );
            return;
        }
        
        if ([self.delegate respondsToSelector:@selector(LScrollBrowViewDefaultShowCount)]) {
            self.defaultVisibleCount = [self.delegate LScrollBrowViewDefaultShowCount];
        }else{
            self.defaultVisibleCount = 3;
        }
        
    }else{
            self.defaultVisibleCount = 3;
    }
    
//下一级 缩小
    CGFloat step = 0.95;
    self.current = 0;
    //防止 有其他元素
    NSInteger insertIndex = self.subviews.count - 1;
    if (insertIndex < 0) {
        insertIndex = 0;
    }

    for (int i = 0 ; i< self.defaultVisibleCount; i++) {

        LScrollBrowCell * contentView = nil;
        CGFloat thescale = [self getScaleWithScale:step andTimes:i];

        if (self.delegate && [self.delegate respondsToSelector:@selector(LScrollBrowViewCellView:)]) {
            contentView = [self.delegate LScrollBrowViewCellView:i];
        }else{
            CGFloat width = self.bounds.size.width - 20;
            CGFloat height = self.bounds.size.height - 10 - self.defaultVisibleCount * 10;
            
            contentView = [[LScrollBrowCell alloc] initWithFrame:CGRectMake(
                                                                   10 ,
                                                                   10 + i * (self.defaultVisibleCount * 10) ,
                                                                   width,
                                                                   height)];
            contentView.backgroundColor = [UIColor whiteColor];
            contentView.tag = 4455;
        }
        contentView.showScale = thescale;
        contentView.layer.shouldRasterize  = YES;
        contentView.backgroundColor = [self getColor:i];
        [self insertSubview:contentView atIndex:0];
//        [self addSubview:contentView];
    }
}

- (UIColor *) getColor:(NSInteger) index{
    UIColor * color = nil;
    switch (index) {
        case 0:
            color = [UIColor redColor];
            break;
        case 1:
            color = [UIColor yellowColor];
            break;
        case 2:
            color = [UIColor greenColor];
            break;
            
        default:
            color = [UIColor whiteColor];
            break;
    }
    return color;
}

- (CGFloat) getScaleWithScale : (CGFloat )scale andTimes:(NSInteger ) loopCount{

    CGFloat aSacle = 1;
    for (int i = 0; i < loopCount; i++) {
        aSacle = scale * aSacle;
    }
    return aSacle;
}
- (NSInteger) getTimesWithScale:(CGFloat)scale{
    NSInteger i = 0;
    
    while (!(( scale < 1.0001) && (scale > 0.99999))) {
        i = i+1;
        scale = scale /0.95;
    }
    
    return i;
}

#pragma -mark 更新子视图
- (void) setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self updateSubViews];
}
- (void) updateSubViews{

    for (LScrollBrowCell * content in self.subviews) {
        if ([content isKindOfClass:[LScrollBrowCell class]]) {
            
            //更新frame
            content.frame = CGRectMake(10, 10, self.bounds.size.width - 20, self.bounds.size.height  - 30);
            [((LScrollBrowCell *) content) setShowScale:((LScrollBrowCell *) content).showScale];
            
            // 更新子视图显示位置
            content.center = CGPointMake(
                                         self.centerX,
                                         self.boundsHeightHelf + 2 * ((self.boundsHeightHelf - content.frame.origin.y * 2) - content.boundsHeightHelf)
                                         );
            
        }
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(LScrollBrowViewWillShowSubView:)]) {
        [self.delegate LScrollBrowViewWillShowSubView:[self foraroundView]];
    }
    
}


- (LScrollBrowCell *)foraroundView{
    return (LScrollBrowCell *)self.subviews.lastObject;
}


#pragma -mark  手势触发


- (void) tap{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(LScrollBrowViewOnclickedSubView:)]) {
        [self.delegate LScrollBrowViewOnclickedSubView:[self foraroundView]];
    }
}

- (void) panAction : (UIPanGestureRecognizer *) gestureRecognizer{
    CGPoint apoint = [gestureRecognizer locationInView:self];
    
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
        {
            //        start prepare
            self.gestureStart = apoint;
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            //            move
            
            for (LScrollBrowCell * content in self.subviews) {
                
                CGPoint center = CGPointMake(self.bounds.size.width/2, content.centerY);
                center.x = (center.x - (_gestureStart.x - apoint.x)* [self getScaleWithScale:0.3 andTimes:[self getTimesWithScale:content.showScale]]  ) ;
                content.center = center;
                [self onChangeTheRotal:content withBounds:self.bounds];
            }
        }
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
        {
            
            //            backCenter or remove
            
//            遍历子视图
            for (LScrollBrowCell * content in self.subviews) {
                //          旋转角度
                
                [self onChangeTheRotal:content withBounds:self.bounds];
                
                CGPoint scrollCenter = CGPointMake(self.bounds.size.width/2, content.centerY);
                
                CGPoint  contentCenter= CGPointMake(content.frame.origin.x + content.frame.size.width/2 , content.centerY);
                if ((contentCenter.x < 0 ) || (content.center.x > self.bounds.size.width)) {
                    //                move out
                    
                    [UIView animateWithDuration:0.4 animations:^{
                        
                        CGPoint afterCenter = CGPointMake(scrollCenter.x + ((contentCenter.x < scrollCenter.x)? - self.bounds.size.width : self.bounds.size.width), scrollCenter.y);
                        content.center = afterCenter;
                        [self onChangeTheRotal:content withBounds:self.bounds];
                        
                    } completion:^(BOOL finished) {
                        
                        content.center = CGPointMake(self.bounds.size.width/2, content.centerY);
                        content.hidden = YES;
                        [self sendSubviewToBack:content];
                        [self onChangeTheRotal:content withBounds:self.bounds];
                        content.hidden = YES;
                        
                        [UIView animateWithDuration:1 animations:^{
                            
                            for (int i = 0; i<self.subviews.count; i++) {
                                CGFloat thescale = [self getScaleWithScale:0.95 andTimes:i];
                                LScrollBrowCell * cell = [self.subviews objectAtIndex:(self.subviews.count -1 - i)];
                                cell.showScale = thescale;
                            }
                            [self updateSubViews];
                            
                        } completion:^(BOOL finished) {
                            LScrollBrowCell * cell = [self.subviews firstObject];
                            cell.hidden = NO;
                            cell.alpha = 0;
                            [UIView animateWithDuration:0.3 animations:^{
                                cell.alpha = 1;
                            }];
 
                        }];

                    }];
                    
                    return;
                }else{
                    //                move back
//                    CGPoint first = CGPointMake(self.bounds.size.width/2 + 0.3 * (self.bounds.size.width/2 - content.centerX), content.centerY);
//                    CGPoint second = CGPointMake(self.bounds.size.width/2 - 0.15 * (self.bounds.size.width/2 - content.centerX), content.centerY);
//                    CGPoint third = CGPointMake(self.bounds.size.width/2 + 0.05 * (self.bounds.size.width/2 - content.centerX), content.centerY);
                    CGPoint endPoint = CGPointMake(self.bounds.size.width/2, content.centerY);

                    [UIView animateWithDuration:0.3 animations:^{
//                        content.center = first;
//                        [self onChangeTheRotal:content withBounds:self.bounds];
//                    } completion:^(BOOL finished) {
//                    
//                        [UIView animateWithDuration:0.3 animations:^{
//                            content.center = second;
//                            [self onChangeTheRotal:content withBounds:self.bounds];
//                        } completion:^(BOOL finished) {
//                            [UIView animateWithDuration:0.2 animations:^{
//                                content.center = third;
//                                [self onChangeTheRotal:content withBounds:self.bounds];
//                            } completion:^(BOOL finished) {
//                               [UIView animateWithDuration:0.1 animations:^{
                                   content.center = endPoint;
                                   [self onChangeTheRotal:content withBounds:self.bounds];
//                               }];
//                            }];
//                        }];
//                        
                    }];
                    
                   
                }
            }
            
            
            
        }
            break;
        default:
            break;
    }
}

- (void) onChangeTheRotal:(UIView *)aView withBounds:(CGRect)aRect{
    //  判断是否是在两端的边界 是的话 做旋转
    CGFloat change =  (aView.centerX - aRect.size.width/2) / aRect.size.width/2;
    aView.transform = CGAffineTransformMakeRotation(M_PI_4 * 0.15 * change);
    
}

@end
