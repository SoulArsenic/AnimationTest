//
//  CombiationBackGroundView.m
//  AnimationTest
//
//  Created by lengbinbin on 15/1/22.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import "CombiationBackGroundView.h"
#define debug 1
@implementation CombiationBackGroundView

-(void)setCellColor:(UIColor *)cellColor{
    _cellColor = cellColor;
    self.cellView.backgroundColor = cellColor;
    //联动
}
-(void)setCellSize:(CGFloat)cellSize{
    self.cellView.frame = CGRectMake(0, 0, cellSize, cellSize);
    self.cellView.layer.cornerRadius = cellSize/2;
    /**
     联动
     */
    if (self.frame.size.height<cellSize) {
        CGPoint centerTemp = self.center;
        CGRect rect = self.frame;
        rect.size.height = cellSize;
        self.frame = rect;
        self.center  = centerTemp;
    }
    self.cellView.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);

}
-(void)setSelfSize:(CGFloat)selfSize{

    CGPoint centerTemp = self.center;
    CGRect rect = self.frame;
    rect.size.width = selfSize;
    self.frame = rect;
    self.center  = centerTemp;
    self.cellView.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);

}

-(instancetype)init{
    self = [super init];
    if (self) {
        [self initComment];
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initComment];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initComment];
    }
    return self;
}
-(void)initComment{
    self.frame = CGRectMake(0, 0, 100, 20);
    self.backgroundColor = [UIColor clearColor];
//    self.layer.anchorPoint = CGPointMake(0.5, .5);
    if (!self.cellView) {
        self.cellView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        self.cellView.alpha = .4;
//        self.cellView.layer.anchorPoint = CGPointMake(0.5, .5);
        self.cellView.layer.cornerRadius = 10;
        self.cellView.layer.masksToBounds = YES;
        self.cellView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        self.cellView.backgroundColor  = [UIColor colorWithRed:arc4random()%10*.1 green:arc4random()%10*.1 blue:arc4random()%10*.1 alpha:.5];
        [self addSubview:self.cellView];
    
    }
    
}
-(void)startAnimation{

    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(update) userInfo:nil repeats:YES];
}

-(void)update{
    
        if (!self.state) {
            [UIView animateWithDuration:1 animations:^{
                self.cellView.center = CGPointMake(self.cellView.bounds.size.width/2, self.bounds.size.height/2);
                self.cellView.transform = CGAffineTransformScale(self.cellView.transform, -1, 1);
                self.cellView.alpha = 1;
                
            }];
        }else{
            [UIView animateWithDuration:1 animations:^{
                self.cellView.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
                self.cellView.alpha = .4;
            }];
        }

    self.state = !self.state;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
