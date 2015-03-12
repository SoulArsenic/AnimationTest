//
//  ScrollControlViewController.h
//  AnimationTest
//
//  Created by lengbinbin on 15/2/11.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    direction_none,
    direction_down,
    direction_right
}direction;
@interface ScrollControlViewController : UIViewController
/**
 *  需要指定滑动的对象
 */
@property (weak, nonatomic) UIScrollView    * targetScrollView;
@property (weak, nonatomic) UIView          * targetBackView;
@end
