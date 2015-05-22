//
//  LTabbarCoverView.h
//  AnimationTest
//
//  Created by lengbinbin on 15/5/22.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LTabbarCoverView : UIView
/**
 *  顶部透视视图
 */
@property (nonatomic, weak) UIView * coverView;
@property (nonatomic, strong) UIColor * wantForgroundColor;
/**
 *  动画过渡效果
 *
 *  @param aimRect  目标位置
 *  @param duration 持续时间
 */
- (void) animationMoveCoverTo:(CGRect) aimRect withDuration:(NSTimeInterval) duration;
@end
