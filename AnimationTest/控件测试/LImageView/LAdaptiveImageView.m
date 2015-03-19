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
        _image = image;
        [self addSubview:_inner];
        
    }
    return self;
}


-(void)setImage:(UIImage *)image{
    _image = image;
    self.imageRatio = image.size.width/image.size.height;
    [self updateRatio];
}
-(UIImage *)getImage{
    return _image;
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

    if (!_image) {
        return;
    }
    if (!_imageRatio) {
        return;
    }
    
    CGFloat xPox = 0.0;
    CGFloat yPox = 0.0;
    
    CGRect imageFrame = CGRectZero;
    
    CGFloat meRatio = self.frame.size.width/self.frame.size.height;
    
    if (meRatio == 1) {
        
        if (_imageRatio == 1) {
            imageFrame = self.frame;
        }else if (_imageRatio > 1){
        
            if ((_position == LAdaptiveImageViewPosition_fit_top) || (_position == LAdaptiveImageViewPosition_fit_center) || (_position == LAdaptiveImageViewPosition_fit_bottom)) {
                
                imageFrame.size.width = self.frame.size.width;
                imageFrame.size.height = self.frame.size.height / _imageRatio;
                
            }else{
            
                imageFrame.size.width = self.frame.size.width * _imageRatio;
                imageFrame.size.height = self.frame.size.height;

            }
            
        }else{
            if ((_position == LAdaptiveImageViewPosition_fit_top) || (_position == LAdaptiveImageViewPosition_fit_center) || (_position == LAdaptiveImageViewPosition_fit_bottom)) {
                
                imageFrame.size.width = self.frame.size.width * _imageRatio;
                imageFrame.size.height = self.frame.size.height;
                
            }else{
            
                imageFrame.size.width = self.frame.size.width ;
                imageFrame.size.height = self.frame.size.height/ _imageRatio;

            
            }
        }
        
    }else{
        
        _inner.frame = self.bounds;
        switch (_position) {
            case LAdaptiveImageViewPosition_fit_top:
            case LAdaptiveImageViewPosition_fit_center:
            case LAdaptiveImageViewPosition_fit_bottom:{
              
                _inner.contentMode = UIViewContentModeScaleAspectFit;
            }
                break;
            case LAdaptiveImageViewPosition_fill_top:
            case LAdaptiveImageViewPosition_fill_center:
            case LAdaptiveImageViewPosition_fill_bottom:{
                _inner.contentMode = UIViewContentModeScaleAspectFill;
            }
                break;
        }
        
        return;
        
    }
//    else if(meRatio > 1){
//        if (_imageRatio == 1) {
//            imageFrame = self.frame;
//        }else if (_imageRatio > 1){
//            
//            if ((_position == LAdaptiveImageViewPosition_fit_top) || (_position == LAdaptiveImageViewPosition_fit_center) || (_position == LAdaptiveImageViewPosition_fit_bottom)) {
//                
//                imageFrame.size.width = self.frame.size.width;
//                imageFrame.size.height = self.frame.size.height / _imageRatio;
//                
//            }else{
//                
//                imageFrame.size.width = self.frame.size.width * _imageRatio;
//                imageFrame.size.height = self.frame.size.height;
//                
//            }
//            
//        }else{
//            if ((_position == LAdaptiveImageViewPosition_fit_top) || (_position == LAdaptiveImageViewPosition_fit_center) || (_position == LAdaptiveImageViewPosition_fit_bottom)) {
//                
//                imageFrame.size.width = self.frame.size.width * _imageRatio;
//                imageFrame.size.height = self.frame.size.height;
//                
//            }else{
//                
//                imageFrame.size.width = self.frame.size.width ;
//                imageFrame.size.height = self.frame.size.height/ _imageRatio;
//                
//                
//            }
//        }
//        
//    }
//    else{
//        //
//        
//        if (_imageRatio == 1) {
//            imageFrame = self.frame;
//        }else if (_imageRatio > 1){
//            
//            if ((_position == LAdaptiveImageViewPosition_fit_top) || (_position == LAdaptiveImageViewPosition_fit_center) || (_position == LAdaptiveImageViewPosition_fit_bottom)) {
//                
//                imageFrame.size.width = self.frame.size.width;
//                imageFrame.size.height = self.frame.size.height / _imageRatio;
//                
//            }else{
//                
//                imageFrame.size.width = self.frame.size.width * _imageRatio;
//                imageFrame.size.height = self.frame.size.height;
//                
//            }
//            
//        }else{
//            if ((_position == LAdaptiveImageViewPosition_fit_top) || (_position == LAdaptiveImageViewPosition_fit_center) || (_position == LAdaptiveImageViewPosition_fit_bottom)) {
//                
//                imageFrame.size.width = self.frame.size.width * _imageRatio;
//                imageFrame.size.height = self.frame.size.height;
//                
//            }else{
//                
//                imageFrame.size.width = self.frame.size.width ;
//                imageFrame.size.height = self.frame.size.height/ _imageRatio;
//                
//                
//            }
//        }
//        
//    }

//    top center bottom
    switch (_position) {
        case LAdaptiveImageViewPosition_fit_top:
        {
            xPox = 0.0f;
            yPox = 0.0f;
        }
            break;
        case LAdaptiveImageViewPosition_fit_center:{
            xPox = 0;
            yPox = (self.frame.size.height - imageFrame.size.height)/2;
        }break;
        case LAdaptiveImageViewPosition_fit_bottom:{
            xPox = 0;
            yPox = (self.frame.size.height - imageFrame.size.height);
        }break;
        case LAdaptiveImageViewPosition_fill_top:{
            xPox = 0;
            yPox = 0;
        }break;
        case LAdaptiveImageViewPosition_fill_center:{
            xPox = 0;
            yPox = (self.frame.size.height - imageFrame.size.height)/2;
        }break;
        case LAdaptiveImageViewPosition_fill_bottom:{
            xPox = 0;
            yPox = (self.frame.size.height - imageFrame.size.height);
        }break;
    }
    
    imageFrame.origin.x = xPox;
    imageFrame.origin.y = yPox;
    
    _inner.frame = imageFrame;

}



@end
