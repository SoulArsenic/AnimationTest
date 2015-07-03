//
//  QuickSVGStyle.m
//  QuickSVG
//
//  Created by Matthew Newberry on 12/7/12.
//  Copyright (c) 2012 Matthew Newberry. All rights reserved.
//

#import "QuickSVGElement+Style.h"
#import "UIColor+Additions.h"

@implementation QuickSVGElement (Style)

+ (NSDictionary *) supportedStyleAttributes
{
    NSDictionary *attributes = @{
                                 @"stroke"               : @[],
                                 @"stroke-width"         : @[],
                                 @"stroke-linecap"       : @[@"butt", @"round", @"square"],
                                 @"stroke-dasharray"     : @[],
                                 @"stroke-linejoin"      : @[@"bevel", @"round", @"miter"],
                                 @"stroke-miterlimit"    : @[],
                                 @"stroke-opacity"       : @[],
                                 @"fill"                 : @[],
                                 @"fill-opacity"         : @[],
                                 @"enable-background"    : @[],
                                 @"opacity"              : @[]
                                 };
    
    return attributes;
}

+ (BOOL) supportsAttribute:(NSString *) attribute
{
    return [[[self supportedStyleAttributes] allKeys] containsObject:attribute];
}

#pragma KVO
- (void) dealloc
{
    if([self.attributes observationInfo]) {
        for(NSString *key in [[QuickSVGElement supportedStyleAttributes] allKeys]) {
            [self.attributes removeObserver:self forKeyPath:key];
        }
    }
}

- (void) addAttributeObservers
{
    for(NSString *key in [[QuickSVGElement supportedStyleAttributes] allKeys]) {
        [self.attributes addObserver:self forKeyPath:key options:NSKeyValueObservingOptionNew context:NULL];
    }
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if(![self.attributes[keyPath] isEqual:change[keyPath]]) {
        
        for(CAShapeLayer *layer in self.layer.sublayers) {
            [self applyStyleAttributes:self.attributes toShapeLayer:layer];
        }
    }
}

- (void) applyStyleAttributes:(NSDictionary *) attributes toShapeLayer:(CAShapeLayer *) shapeLayer
{
    if(self.attributes.observationInfo == nil)
        [self addAttributeObservers];
    
    // Defaults
	__block BOOL stroke = NO;
	__block BOOL fill = YES;
	__block UIColor *fillColor = [UIColor blackColor];
	__block UIColor *strokeColor = [UIColor blackColor];
	__block CGFloat fillAlpha = 1.0;
	__block CGFloat strokeAlpha = 1.0;
	__block CGFloat lineWidth = 1.0;
    __block CGFloat opacity = 1.0;
	shapeLayer.lineCap = kCALineCapSquare;
	shapeLayer.lineJoin = kCALineJoinMiter;
    
    // Check for inline style element
    NSMutableDictionary *styles = [NSMutableDictionary dictionaryWithDictionary:attributes];
    
    if(attributes[@"style"]) {
        NSArray *inlineStyles = [attributes[@"style"] componentsSeparatedByString:@";"];
        [inlineStyles enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
            NSArray *pieces = [obj componentsSeparatedByString:@":"];
            if([pieces count] == 2) {
                styles[pieces[0]] = pieces[1];
            }
        }];
        [styles removeObjectForKey:@"style"];
    }
    
	[styles enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
		
		if([key isEqualToString:@"stroke-width"]) {
			lineWidth = [obj floatValue];
		}
		else if([key isEqualToString:@"stroke-linecap"]) {
			if([obj isEqualToString:@"butt"]) {
				shapeLayer.lineCap = kCALineCapButt;
			} else if([obj isEqualToString:@"round"]) {
				shapeLayer.lineCap = kCALineCapRound;
			} else if([obj isEqualToString:@"square"]) {
				shapeLayer.lineCap = kCALineCapSquare;
			}
		}
		else if([key isEqualToString:@"stroke-dasharray"]) {
			NSArray *pieces = [styles[@"stroke-dasharray"] componentsSeparatedByString:@","];
			
			float a = [pieces[0] floatValue];
			float b = [pieces count] > 1 ? [pieces[1] floatValue] : a;
            
			shapeLayer.lineDashPhase = 0.3;
			shapeLayer.lineDashPattern = @[@(a), @(b)];
		}
        else if([key isEqualToString:@"stroke-miterlimit"])
        {
            shapeLayer.miterLimit = [obj floatValue];
        }
		else if([key isEqualToString:@"stroke-linejoin"]) {
			if([obj isEqualToString:@"bevel"]) {
				shapeLayer.lineJoin = kCALineJoinBevel;
			} else if([obj isEqualToString:@"round"]) {
				shapeLayer.lineJoin = kCALineJoinRound;
			} else if([obj isEqualToString:@"miter"]) {
				shapeLayer.lineJoin = kCALineJoinMiter;
			}
		}
		else if([key isEqualToString:@"stroke"]) {
			if([key isEqualToString:@"stroke-opacity"]) {
				strokeAlpha = [obj floatValue];
			}
			
            if([obj length] > 0) {
                NSString *hexString = [obj substringFromIndex:1];
                strokeColor = [UIColor colorWithHexString:hexString withAlpha:1];
                
                stroke = YES;
            }
		}
		else if([key isEqualToString:@"fill"]) {
			if([[styles allKeys] containsObject:@"fill-opacity"]) {
				fillAlpha = [styles[@"fill-opacity"] floatValue];
			}
			
			if([styles[@"fill"] isEqualToString:@"none"]) {
				fill = NO;
			} else if([obj length] > 0){
				NSString *hexString = [obj substringFromIndex:1];
				fillColor = [UIColor colorWithHexString:hexString withAlpha:fillAlpha];
				
				fill = YES;
			}
		}
        else if([key isEqualToString:@"opacity"]) {
			if([[styles allKeys] containsObject:@"opacity"]) {
				opacity = [styles[@"opacity"] floatValue];
			}
		}
	}];
	
    NSString *enableBackground = [styles[@"enable-background"] stringByReplacingOccurrencesOfString:@" " withString:@""];
	if(enableBackground && ![enableBackground isEqualToString:@"new"] && !fill) {
		if([[styles allKeys] containsObject:@"opacity"]) {
			fillAlpha = [styles[@"opacity"] floatValue];
		}
        
		[UIColor colorWithWhite:0 alpha:fillAlpha];
		fill = YES;
	}
	
    shapeLayer.opacity = opacity;
	shapeLayer.fillColor = fill ? fillColor.CGColor : nil;
	
	if(stroke) {
		shapeLayer.strokeColor = strokeColor.CGColor;
		shapeLayer.lineWidth = lineWidth;
	}
}

@end
