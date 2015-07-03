//
//  MarketingAnimationControl.h
//  MAKTTING
//
//  Created by lengbinbin on 15/4/27.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import <UIKit/UIKit.h>

//动画
typedef enum {
    AnimationType_none = 0,//无动画
    AnimationType_Fadein,// 淡入
    
    AnimationType_FlyFromLeft,//向右移入
    AnimationType_FlyFromRight,//向左移入
    AnimationType_FlyFromBottom,//向上移入
    AnimationType_FlyFromTop,//向下移入
    
    AnimationType_SlipFromLeft,//向右弹入
    AnimationType_SlipFromRight,//向左弹入
    AnimationType_SlipFromBottom,//向上弹入
    AnimationType_SlipFromTop,//向下弹入
    AnimationType_SlipFromCenter,//中心弹入
    
    AnimationType_Enlarge,//中心放大
    
    AnimationType_ScrollIn,//滚入
    
    AnimationType_Miter,//光速进入
    
    AnimationType_Swing,//摇摆
    
    AnimationType_Shake,//抖动
    
    AnimationType_Flip,//旋转
    
    AnimationType_Reversal,//翻转
    
    AnimationType_Pendulum,//悬摆
    
    AnimationType_FadeOut, //淡出
    AnimationType_ReversalOut, //翻转消失
    
    
    
    //    AnimationType_UnfoldToRight,//向右展开20
    //    AnimationType_UnfoldToLeft,//向左展开21
    //    AnimationType_UnfoldToBottom,//向上展开22
    //    AnimationType_UnfoldToTop,//向下展开23
    
}AnimationType;

@interface ViewAnimationControl : NSObject
+ (void) setAnimationTo:(UIView *)aView andAfter:(NSTimeInterval)after andDurtion:(NSTimeInterval)duration andAnimationType:(AnimationType)type;
@end
