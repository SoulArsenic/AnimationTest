//
//  FlexibleButtonView.m
//  AnimationTest
//
//  Created by lengbinbin on 15/5/14.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import "FlexibleButtonView.h"

@interface FlexibleButtonView()

@property (nonatomic, strong) UIButton * innerButton;

@end


@implementation FlexibleButtonView

-(instancetype)init{
    self = [super init];
    if (self) {
        [self initAllContent];
    }
    return self;
}


-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initAllContent];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initAllContent];
        
    }
    return self;
}
/**
 *  初始化按钮
 */
- (void) initAllContent{

    if (!self.innerButton) {
        self.innerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        
        
        
    }
    
}
/**
 *  按钮的frame更新
 */
- (void) updateContentFrame{

}
/**
 *  <#Description#>
 *
 */





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
