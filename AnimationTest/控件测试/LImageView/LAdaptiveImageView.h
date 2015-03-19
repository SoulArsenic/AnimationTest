//
//  LAdaptiveImageView.h
//  AnimationTest
//
//  Created by lengbinbin on 15/3/18.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    LAdaptiveImageViewPosition_top_left,
        
}LAdaptiveImageViewPosition;

@interface LAdaptiveImageView : UIView

@property (nonatomic, assign) LAdaptiveImageViewPosition position;

- (instancetype) initWithImage:(UIImage *)image;

@end
