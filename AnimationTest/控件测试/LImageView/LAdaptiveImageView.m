//
//  LAdaptiveImageView.m
//  AnimationTest
//
//  Created by lengbinbin on 15/3/18.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import "LAdaptiveImageView.h"

@interface UIImageView (load)


@end



@interface LAdaptiveImageView ()
@property (nonatomic, strong) UIImageView * inner;
@property (nonatomic, assign) CGFloat       imageRatio;
@end

@implementation LAdaptiveImageView

-(instancetype)initWithImage:(UIImage *)image{
    
    self = [super init];
    if (self) {
        
        self.inner = [[UIImageView alloc] initWithImage:image];
        _inner.backgroundColor = self.backgroundColor;
        self.imageRatio = image.size.width/image.size.height;
        [self addSubview:_inner];
        
    }
    return self;
}


-(void)setPosition:(LAdaptiveImageViewPosition)position{
    _position = position;
    [self updateRatio];
}
- (LAdaptiveImageViewPosition )getPosition{
    return _position;
}


-(void)setFrame:(CGRect)frame{
    super.frame     = frame;
    _inner.frame    = frame;
    [self updateRatio];
}


-(void)setBackgroundColor:(UIColor *)backgroundColor{
    super.backgroundColor   = backgroundColor;
    _inner.backgroundColor  = backgroundColor;
    [self updateRatio];
}

- (void) updateRatio{
    if (!_imageRatio) {
        return;
    }
    
    CGFloat meRatio = self.frame.size.width/self.frame.size.height;
    
    if (meRatio == 1) {
        
        if (_imageRatio == 1) {
            _inner.frame = self.frame;
        }else if (_imageRatio > 1){
            
        }
        
    }else if(meRatio > 1){
        //width

        
    }else{
        //
        
    }
    

}



@end
