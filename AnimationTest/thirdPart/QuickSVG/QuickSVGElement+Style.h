//
//  QuickSVGStyle.h
//  QuickSVG
//
//  Created by Matthew Newberry on 12/7/12.
//  Copyright (c) 2012 Matthew Newberry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuickSVGElement.h"

@interface QuickSVGElement (Style)

+ (NSDictionary *) supportedStyleAttributes;
+ (BOOL) supportsAttribute:(NSString *) attribute;
- (void) applyStyleAttributes:(NSDictionary *) attributes toShapeLayer:(CAShapeLayer *) shapeLayer;

@end
