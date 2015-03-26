//
//  MyChartView.m
//  AnimationTest
//
//  Created by lengbinbin on 15/3/24.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import "MyChartView.h"
@interface MyChartView ()
@property (assign) CGRect drawRect;
@end



@implementation MyChartView
@synthesize useAnimated;
@synthesize dataSource;
@synthesize chartInsets;




-(void)refreshData{

    CGRect frame = self.bounds;
    frame.origin.x = chartInsets.left;
    frame.origin.y = chartInsets.top;
    frame.size.width = frame.size.width - chartInsets.right - chartInsets.left;
    frame.size.height = frame.size.height - chartInsets.bottom - chartInsets.top;
    self.drawRect  = frame;
    
    
}

- (void) updateFrames{

    
}


@end
