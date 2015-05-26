//
//  LAdaptiveImageView.h
//  AnimationTest
//
//  Created by lengbinbin on 15/3/18.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {

    LAdaptiveImageViewPosition_fit_top = 0,//default
    LAdaptiveImageViewPosition_fit_center,
    LAdaptiveImageViewPosition_fit_bottom,
    
    LAdaptiveImageViewPosition_fill_top ,
    LAdaptiveImageViewPosition_fill_center,
    LAdaptiveImageViewPosition_fill_bottom
    
}LAdaptiveImageViewPosition;

@interface LAdaptiveImageView : UIView

@property (nonatomic, assign) LAdaptiveImageViewPosition position;
@property (nonatomic, strong) UIImage * image;
- (instancetype) initWithImage:(UIImage *)image;

@end
