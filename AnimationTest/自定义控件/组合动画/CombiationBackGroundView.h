//
//  CombiationBackGroundView.h
//  AnimationTest
//
//  Created by lengbinbin on 15/1/22.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

/**
 *  刷新 等待 动画效果控件
 */


#import <UIKit/UIKit.h>

@interface CombiationBackGroundView : UIView
@property (nonatomic) CGFloat selfSize;
//移动部分
@property (nonatomic, strong) UIView * cellView;
//可移动部分的颜色 默认随机颜色
@property (nonatomic, strong) UIColor * cellColor;
//移动部分的大小 默认20*20
@property (nonatomic) CGFloat cellSize;

@property (nonatomic) BOOL state;
//带希望移动区域的初始化 移动区域默认 50

-(void)startAnimation;

@end
