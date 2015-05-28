//
//  LScrollBrowCell.m
//  AnimationTest
//
//  Created by lengbinbin on 15/5/28.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import "LScrollBrowCell.h"

@interface UIView (MyScale)
- (void) makeFrameScale:(CGFloat) scale;
@end
@implementation UIView(MyScale)

- (void)makeFrameScale:(CGFloat)scale{
    CGRect aTemp = self.frame;
    aTemp.size.height = aTemp.size.height * scale;
    aTemp.size.width = aTemp.size.width * scale;
    aTemp.origin.x  = aTemp.origin.x* scale;
    aTemp.origin.y  = aTemp.origin.y* scale;
    self.frame = aTemp;
}

@end
@implementation LScrollBrowCell
@synthesize index;

- (void)setShowScale:(CGFloat)showScale{
    _showScale = showScale;
    [self updateLScrollBrowCellSubViews];
}

- (void) updateLScrollBrowCellSubViews{
    [self makeFrameScale:self.showScale];
    for (UIView * view in self.subviews) {
        [view makeFrameScale:self.showScale];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
