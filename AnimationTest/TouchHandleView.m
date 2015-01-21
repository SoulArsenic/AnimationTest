//
//  TouchHandleView.m
//  PodForAnimationTest
//
//  Created by admin on 15-1-21.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import "TouchHandleView.h"

@implementation TouchHandleView

-(instancetype)init{
    self = [super init];

    if (self) {
        [self initCommon];
    }
    
    return  self;
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];

    if (self) {
        [self initCommon];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];

    if (self) {
        [self initCommon];
    }
    
    return self;
}
-(void)initCommon{
    
    UISwipeGestureRecognizer * vDirectionleft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(recognizer:)];
    vDirectionleft.direction = UISwipeGestureRecognizerDirectionLeft;
    
    UISwipeGestureRecognizer * vDirectionright = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(recognizer:)];
    vDirectionright.direction = UISwipeGestureRecognizerDirectionRight;
    
    UISwipeGestureRecognizer * vDirectionup = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(recognizer:)];
    vDirectionup.direction = UISwipeGestureRecognizerDirectionUp;
    
    UISwipeGestureRecognizer * vDirectiondown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(recognizer:)];
    vDirectiondown.direction = UISwipeGestureRecognizerDirectionDown;

    [self addGestureRecognizer:vDirectionleft];
    [self addGestureRecognizer:vDirectionright];
    [self addGestureRecognizer:vDirectiondown];
    [self addGestureRecognizer:vDirectionup];
    
    self.layer.cornerRadius = 10;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.33;
    self.layer.shadowOffset = CGSizeMake(0, 1.5);
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    self.userInteractionEnabled = YES;
    self.backgroundColor = [UIColor colorWithRed:arc4random()%10 *.1 green:arc4random()%10 *.1 blue:arc4random()%10 *.1 alpha:1];
}

- (void) recognizer:(UISwipeGestureRecognizer *) gesture{
    
    UIView * temp =nil;
    

        temp = self;
    
    
    [UIView animateWithDuration:.5 animations:^{
        
        if (temp ){
            CGPoint center = temp.center;
            
            switch (gesture.direction) {
                case UISwipeGestureRecognizerDirectionUp:
                    center.y = center.y - [UIScreen mainScreen].bounds.size.height;
                    break;
                case UISwipeGestureRecognizerDirectionDown:
                    center.y = center.y + [UIScreen mainScreen].bounds.size.height;
                    break;
                case UISwipeGestureRecognizerDirectionLeft:
                    center.x = center.x - [UIScreen mainScreen].bounds.size.height;
                    break;
                case UISwipeGestureRecognizerDirectionRight:
                    center.x = center.x + [UIScreen mainScreen].bounds.size.height;
                    break;
                default:
                    break;
            }
            
            
            temp.center = center;
            
        }
        
    } completion:^(BOOL finished) {
        
        if (temp ){
            [temp removeFromSuperview];
        }
    }];

    if (self.handleAction) {
        self.handleAction(gesture.direction,self);
    }
    
}

+ (void) moveTheLess:(NSArray *)tsubViews{

    NSInteger i = 0;
    NSInteger number = 0;
    if (tsubViews.count < defaultshowNumber) {
        number = tsubViews.count;
    }else{
        number =defaultshowNumber;
    }
    
    for (i = 0 ; i< number; i++) {
        UIView * temp =tsubViews[i];
        if ([temp isKindOfClass:[UIButton class]]) {
            continue;
        }
        CGPoint center = temp.center;
        CGRect frame = temp.frame;
        center.y += sepceMark;
        frame.size.width = frame.size.width + sepceMark;
        temp.frame = frame;
        temp.center = center;
        //        temp.alpha = 1 - number*.1 + i*.1;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - 静态方法
+(void)addSub:(NSArray *)tsubViews to:(UIView *)superView{
    superView.userInteractionEnabled = YES;
    NSInteger i = 0;
    NSInteger number = 0;
    if (tsubViews.count < defaultshowNumber) {
        number = tsubViews.count;
    }else{
        number =defaultshowNumber;
    }

    for (i = 0 ; i< number; i++) {
        UIView * temp =tsubViews[i];
        CGPoint center = temp.center;
        CGRect frame = temp.frame;
        center.y += sepceMark*i;
        frame.size.width = frame.size.width + sepceMark*i;
        temp.frame = frame;
        temp.center = center;
//        temp.alpha = 1 - number*.1 + i*.1;
        [superView addSubview:temp];
    }
}
@end
