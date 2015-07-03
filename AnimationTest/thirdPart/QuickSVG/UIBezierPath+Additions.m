/*
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook, 6.x Edition
 BSD License, Use at your own risk
 */

#import "UIBezierPath+Additions.h"

@implementation UIBezierPath (Additions)

void getPointsFromBezier(void *info, const CGPathElement *element) {
    
    NSMutableArray *bezierPoints = (__bridge NSMutableArray *)info;
    CGPathElementType type = element->type;
    CGPoint *points = element->points;
    if (type != kCGPathElementCloseSubpath)
    {
        if ((type == kCGPathElementAddLineToPoint) ||
            (type == kCGPathElementMoveToPoint))
            [bezierPoints addObject:VALUE(0)];
        else if (type == kCGPathElementAddQuadCurveToPoint)
            [bezierPoints addObject:VALUE(1)];
        else if (type == kCGPathElementAddCurveToPoint)
            [bezierPoints addObject:VALUE(2)];
    }
}

- (NSArray *) points {
    NSMutableArray *points = [NSMutableArray array];
    CGPathApply(self.CGPath, (__bridge void *)points, getPointsFromBezier);
    return points;
}

+ (UIBezierPath *) pathWithPoints: (NSArray *) points {
    UIBezierPath *path = [UIBezierPath bezierPath]; if (points.count == 0) return path;
    [path moveToPoint:POINT(0)];
    for (int i = 1; i < points.count; i++)
        [path addLineToPoint:POINT(i)]; return path;
}

// Determine the scale that allows a size to fit into // a destination rectangle
CGFloat AspectScaleFit(CGSize sourceSize, CGRect destRect) {
	CGSize destSize = destRect.size;
	CGFloat scaleW = destSize.width / sourceSize.width;
	CGFloat scaleH = destSize.height / sourceSize.height;
	return MIN(scaleW, scaleH);
}
// Create a rectangle that will fit an item while preserving // its original aspect
CGRect AspectFitRect(CGSize sourceSize, CGRect destRect) {
	CGSize destSize = destRect.size;
	CGFloat destScale = AspectScaleFit(sourceSize, destRect);
	CGFloat newWidth = sourceSize.width * destScale;
	CGFloat newHeight = sourceSize.height * destScale;
	float dWidth = ((destSize.width - newWidth) / 2.0f);
	float dHeight = ((destSize.height - newHeight) / 2.0f);
	CGRect rect = CGRectMake(destRect.origin.x + dWidth, destRect.origin.y + dHeight, newWidth, newHeight);
	return rect;
}
// Add two points
CGPoint PointAddPoint(CGPoint p1, CGPoint p2) {
	return CGPointMake(p1.x + p2.x, p1.y + p2.y);
}
// Subtract a point from a point
CGPoint PointSubtractPoint(CGPoint p1, CGPoint p2) {
	return CGPointMake(p1.x - p2.x, p1.y - p2.y);
}
// Project a point from a native rectangle into a destination // rectangle
NSValue *adjustPoint(CGPoint p, CGRect native, CGRect dest) {
	CGFloat scaleX = dest.size.width / native.size.width;
	CGFloat scaleY = dest.size.height / native.size.height;
    
	CGPoint point = PointSubtractPoint(p, native.origin);
    point.x *= scaleX;
	point.y *= scaleY;
	CGPoint destPoint = PointAddPoint(point, dest.origin);
	return [NSValue valueWithCGPoint:destPoint];
}

static __unused CGRect pointRect(CGPoint point)
{
    return (CGRect){.origin=point};
}

// Fit a path into a rectangle
- (UIBezierPath *) fitInRect: (CGRect) destRect {
	// Calculate an aspect-preserving destination rectangle
    
    NSArray *points = self.points;
	CGRect bounding = [self bounds];
	CGRect fitRect = AspectFitRect(bounding.size, destRect);
	// Project each point from the original to the
	// destination rectangle
	NSMutableArray *adjustedPoints = [NSMutableArray array];
	for (int i = 0; i < points.count; i++) {
        [adjustedPoints addObject:adjustPoint( POINT(i), bounding, fitRect)];
    }
    
    return [UIBezierPath pathWithPoints:adjustedPoints];
}

@end
