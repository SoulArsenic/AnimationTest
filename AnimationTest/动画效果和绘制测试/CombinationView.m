//
//  CombinationView.m
//  AnimationTest
//
//  Created by admin on 15-1-22.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import "CombinationView.h"

@implementation CombinationView
-(instancetype)init{
    self = [super init];
    if (self) {
        [self initcomment];
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initcomment];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initcomment];
    }
    return self;
}
-(void)initcomment{
    self.layer.masksToBounds = YES;
//    self.layer.cornerRadius = 25;
    
//    UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
//    lab.text = @"1";
//    [self addSubview:lab];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
