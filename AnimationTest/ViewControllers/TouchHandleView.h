//
//  TouchHandleView.h
//  PodForAnimationTest
//
//  Created by admin on 15-1-21.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//



///
/**
 *  卡片切换效果
 *
 *
 *
 */
#import <UIKit/UIKit.h>
#define defaultshowNumber 10
#define sepceMark 5
@class TouchHandleView;
typedef void(^HandleSwip)(UISwipeGestureRecognizerDirection direction,TouchHandleView * view);

@interface TouchHandleView : UIView

@property (nonatomic, copy) HandleSwip handleAction;

+ (void) addSub:(NSArray *)tsubViews to:(UIView *) superView;
+ (void) moveTheLess:(NSArray *)tsubViews;
@end
