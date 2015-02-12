//
//  SecretAnimationCell.m
//  AnimationTest
//
//  Created by lengbinbin on 15/2/4.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import "SecretAnimationCell.h"

@implementation SecretAnimationCell


-(id)init{

    self =[super init];
    
    if (self) {

    }
    
    return self;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {

    }
    
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch * touch = [touches anyObject];
    CGPoint touchIn  = [touch locationInView:self.bg];
    self.touchStartPoint = touchIn;
    
    self.heartStart = self.heart.center;
    self.actionStart  = self.actionView.center;
    self.change(NO);
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch * touch = [touches anyObject];
    CGPoint touchIn  = [touch locationInView:self.bg];
    CGPoint center = self.heart.center;
    
    CGFloat temp =  (touchIn.x - self.touchStartPoint.x);
    
    
    center = CGPointMake(center.x + temp/10, center.y);
    if (center.x > self.frame.size.width/2) {
        center.x =self.frame.size.width/2;
    }
    
    
    self.heart.center = center;

}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    self.change(YES);
    self.heart.center = self.heartStart;
    self.actionView.center  = self.actionStart;

}
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    self.change(YES);
    self.heart.center = self.heartStart;
    self.actionView.center  = self.actionStart;

}

@end
