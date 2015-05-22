//
//  LTabbarControllerMoveAnimation.h
//  AnimationTest
//
//  Created by lengbinbin on 15/5/21.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef enum {
    Dirct_toleft,
    Dirct_toright,
}Dirct;
@interface LTabbarControllerMoveAnimation : NSObject<UIViewControllerAnimatedTransitioning>
@property(nonatomic, assign) Dirct type;
-(instancetype)initWithDrict:(Dirct)driction;
@end
