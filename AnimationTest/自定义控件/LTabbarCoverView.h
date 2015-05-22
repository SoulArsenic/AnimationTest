//
//  LTabbarCoverView.h
//  AnimationTest
//
//  Created by lengbinbin on 15/5/22.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LTabbarCoverView : UIView
@property (nonatomic, weak) UIView * coverView;
- (void) animationMoveCoverTo:(CGRect) aimRect withDuration:(NSTimeInterval) duration;
@end
