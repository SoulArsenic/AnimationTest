//
//  SunnyFresh.m
//  AnimationTest
//
//  Created by lengbinbin on 15/3/6.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import "SunnyFresh.h"

@implementation SunnyFresh
-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    
    if (self) {
        self.sunnyBg = [[UIImageView alloc] initWithFrame:frame];
        _sunnyBg.image = [UIImage imageNamed:@"sky"];
        _sunnyBg.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_sunnyBg];

        
    }
    
    return self;
}
@end
