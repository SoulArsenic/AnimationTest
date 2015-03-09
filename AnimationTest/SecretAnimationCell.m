//
//  SecretAnimationCell.m
//  AnimationTest
//
//  Created by lengbinbin on 15/2/4.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import "SecretAnimationCell.h"
#import "AnimationControl.h"

@implementation SecretAnimationCell

-(void)sendActionViewBack{
  
    _inUseactionView = NO;
  
    [UIView animateWithDuration:.2 animations:^{
        self.actionView.center = self.actionStart;
    }];
    [UIView animateWithDuration:.1 animations:^{

        _heart.frame = CGRectMake(_heartStart.x - _heartSize.width, _heartStart.y - _heartSize.height, _heartSize.width ,_heartSize.height );
        
    }];
    _fuzzyView.image = nil;
    _processor = nil;

}
-(void)resetUI{
    
    self.heart.center = self.heartStart;
    self.actionView.center = self.actionStart;
    _fuzzyView.image = nil;
    _processor = nil;
    
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];

    if (self) {
        [self addObserver:self forKeyPath:@"actionView" options:NSKeyValueObservingOptionNew context:nil];
        [self addObserver:self forKeyPath:@"heart" options:NSKeyValueObservingOptionNew context:nil];

    }
    
    return self;
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{

    if ([keyPath isEqualToString:@"panInUseHeart"]) {
        
    }else{
        self.heartStart = self.heart.center;

        self.actionStart  = self.actionView.center;

        if (CGSizeEqualToSize(_heartSize, CGSizeZero))
            self.heartSize = self.heart.frame.size;
        
    }
}

-(UIImage*)captureView:(UIView *)theView{
    
    CGRect rect = theView.frame;
    
    if ([theView isKindOfClass:[UIScrollView class]]) {
        rect.size = ((UIScrollView *)theView).contentSize;
    }
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [theView.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (void) clip{

    if (CGSizeEqualToSize(self.contentView.frame.size, CGSizeZero)) {
        return;
    }
    
    if (_fuzzyView.image) {
        return;
    }

    _fuzzyView.image = [self captureView:self.contentView];

}


-(BOOL)actionCenter{
    return !CGPointEqualToPoint(_actionStart, _actionView.center);
}

-(void)touchGesture:(UIPanGestureRecognizer *)recognizer{
   
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        self.touchStartPoint = [recognizer locationInView:self.bg];
        if (CGPointEqualToPoint(CGPointZero, self.heartStart)) {
            self.heartStart = self.heart.center;
        }
        if (CGPointEqualToPoint(CGPointZero, self.actionStart)) {
            self.actionStart  = self.actionView.center;
        }
        self.actionTempCenter = self.actionView.center;
        
        if (!_processor) {
            if (!_fuzzyView.image){
                [self clip];
            }
            self.processor = [[ALDBlurImageProcessor alloc] initWithImage:_fuzzyView.image];
            _fuzzyView.image  = [_processor syncBlurWithRadius:5 iterations:5 errorCode:0];

        }
        
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged){
        
        CGPoint touchIn  = [recognizer locationInView:self.bg];
        CGPoint center = self.heart.center;
        
        CGFloat temp =  (touchIn.x - self.touchStartPoint.x);
// 方向区分
        BOOL rightDirection = NO;
        if (temp > 0) {
            //heart use
            rightDirection = YES;
        }
        
        //
        if (!_panInUseHeart &&  _inUseactionView){
        
            center = CGPointMake(self.actionTempCenter.x + temp, self.actionStart.y);
            
            [UIView animateWithDuration:.1 animations:^{
                
                self.actionView.center = center;
            }];
            [self fuzzyAction];
            
        }
        else{
            
            if (_panInUseHeart || rightDirection) {
                // 处理的心
                self.panInUseHeart = YES;
                _fuzzyView.alpha = 0;

                center = CGPointMake(self.heartStart.x + temp, center.y);
                
                if (center.x > self.frame.size.width/2) {
                    center = CGPointMake(self.heartStart.x + self.frame.size.width/2+ temp/10, center.y);
                }
                
                
                if (center.x >= self.heart.frame.size.width/2) {
                    CGFloat sc = 1 + (center.x/self.frame.size.width/2)*4;
                    
                    CGFloat width  = _heartSize.width * sc;
                    CGFloat height = _heartSize.height * sc;
                    
                    [UIView animateWithDuration:.1 animations:^{
                        self.heart.frame = CGRectMake(center.x - width/2, center.y - height/2,width ,height);
                    }];

                }
                
                self.heart.center = center;
                
                
            }else{
                
                if (_inUseactionView) {
                    center = CGPointMake(self.contentView.center.x + temp, center.y);
                }else{
                    center = CGPointMake(self.actionStart.x + temp, center.y);
                }
                
                [UIView animateWithDuration:.1 animations:^{
                    
                    self.actionView.center = center;
                }];
                
                _inUseactionView = YES;
            }
        }
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded){
        
        if (!_panInUseHeart && _inUseactionView){

            CGPoint center = CGPointZero;
            CGFloat time = .2f;
            
            CGFloat bounds =self.contentView.frame.size.width;
            
            if (self.actionTempCenter.x == self.contentView.center.x) {
                bounds = self.contentView.frame.size.width * .7;
            }
            
            
            if (self.actionView.center.x > bounds) {
                center = self.actionStart;
                _inUseactionView = NO;
                
            }else{
                
                _inUseactionView = YES;
                center = CGPointMake(self.contentView.frame.size.width / 2,_actionStart.y);
            }
            
            [UIView animateWithDuration:time animations:^{
                self.actionView.center = center;
            } completion:^(BOOL finished) {
                [self fuzzyAction];
            }];

        }
        else
        {
            _fuzzyView.alpha = 0;
            self.panInUseHeart = NO;
            CGFloat heartT= _heart.center.x;
            CGFloat boundsT= self.frame.size.width/5;
            
            if (heartT > boundsT) {
                //滑到中间
                CGPoint center = CGPointMake(self.contentView.frame.size.width/2, _heart.center.y);
                
                [UIView animateWithDuration:.3 animations:^{
                    _heart.frame = CGRectMake(center.x - _heartSize.width, center.y - _heartSize.height, _heartSize.width *2 ,_heartSize.height *2);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:.2 animations:^{
                        CGFloat width = _heartSize.width*.5;
                        CGFloat height =  _heartSize.height *.5;
                        _heart.frame = CGRectMake(self.likeBtn.center.x - width,self.likeBtn.center.y - height,width ,height);
                    } completion:^(BOOL finished) {
                        _heart.frame = CGRectMake(0, 0, _heartSize.width, _heartSize.height);
                        _heart.center = _heartStart;
                    }];
                }];
            }
            else{
                [UIView animateWithDuration:.3 animations:^{
                    _heart.frame = CGRectMake(_heartStart.x - _heartSize.width, _heartStart.y - _heartSize.height, _heartSize.width ,_heartSize.height );
                }];
            }
        }
    }
}


- (void) fuzzyAction {
    
    CGFloat centerX = self.contentView.frame.size.width/2;
    
    CGFloat actionLocation =_actionView.center.x - centerX;
    
    CGFloat startLocation =_actionStart.x - centerX;
    
    CGFloat temp = ((startLocation - MAX(actionLocation, 0)) / startLocation)*1;
    
    if (temp){
        
        _fuzzyView.alpha = temp;
    
    }
    else{
        _fuzzyView.alpha = 0;
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{}


@end
/*
 - (void) likeAction{
 
 CGPoint pasPoint = self.contentView.center;
 
 [UIView animateWithDuration:.5 animations:^{
 self.heart.center = pasPoint;
 //    transform = CGAffineTransformScale(transform, 2,0.5);//前面的2表示横向放大2倍，后边的0.5表示纵向缩小一半
 CGAffineTransform transform=self.heart.transform;
 transform=CGAffineTransformScale(self.heart.transform,3, 3);
 self.heart.transform=transform;
 
 } completion:^(BOOL finished) {
 
 [UIView animateWithDuration:.2 animations:^{
 
 self.heart.center = self.likeBtn.center;
 CGAffineTransform transform=self.heart.transform;
 transform=CGAffineTransformScale(self.heart.transform, .3333, .3333);
 self.heart.transform=transform;
 
 } completion:^(BOOL finished) {
 
 self.heart.center = CGPointMake(-30, self.contentView.frame.size.height/2);
 }];
 }];
 
 
 
 
 }
 */
