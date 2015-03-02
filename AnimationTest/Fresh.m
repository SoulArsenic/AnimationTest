//
//  Fresh.m
//  AnimationTest
//
//  Created by lengbinbin on 15/3/2.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import "Fresh.h"
#import "AnimationControl.h"

@implementation Fresh


-(void)start{

    [AnimationControl animationCombiationSuperView:self withMaxSize: 80 andCellSize:10 andCellCount:6];

}
- (void) end{
    for (UIView * temp in self.subviews) {
        [temp removeFromSuperview];
    }
}
@end
