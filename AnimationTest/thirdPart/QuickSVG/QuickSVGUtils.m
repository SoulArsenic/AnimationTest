//
//  QuickSVGUtils.m
//  QuickSVG
//
//  Created by Matthew Newberry on 12/18/12.
//  Copyright (c) 2012 Matthew Newberry. All rights reserved.
//

#import "QuickSVGUtils.h"
#import <CoreText/CoreText.h>

CGAffineTransform makeTransform(CGFloat xScale, CGFloat yScale, CGFloat theta, CGFloat tx, CGFloat ty) {
    CGAffineTransform t = CGAffineTransformIdentity;
    t.a = xScale * cos(theta);
    t.b = yScale * sin(theta);
    t.c = xScale * -sin(theta);
    t.d = yScale * cos(theta);
    t.tx = tx;
    t.ty = ty;
    
    return t;
}

CGAffineTransform makeTransformFromSVGMatrix(NSString *matrix) {
    
    NSMutableString *m = [NSMutableString stringWithString:matrix];
    [m replaceOccurrencesOfString:@"matrix(" withString:@"{" options:0 range:NSMakeRange(0, [m length])];
    [m replaceOccurrencesOfString:@")" withString:@"}" options:0 range:NSMakeRange(0, [m length])];
    [m replaceOccurrencesOfString:@" " withString:@"," options:0 range:NSMakeRange(0, [m length])];
	
	CGAffineTransform t = CGAffineTransformFromString(m);
    
    CGFloat xScale = getXScale(t);
    CGFloat yScale = getYScale(t);
    CGFloat rotation = getRotation(t);
    
    return makeTransform(xScale, yScale, rotation, t.tx, t.ty);
}

CGAffineTransform makeTransformFromSVGScale(NSString *scale)
{
    NSMutableString *m = [NSMutableString stringWithString:scale];
    [m replaceOccurrencesOfString:@"scale(" withString:@"{" options:0 range:NSMakeRange(0, [m length])];
    [m replaceOccurrencesOfString:@")" withString:@"}" options:0 range:NSMakeRange(0, [m length])];

    CGPoint s = CGPointFromString(m);
    CGAffineTransform t = CGAffineTransformMakeScale(s.x, s.y);
    
    return t;
}

CGAffineTransform makeTransformFromSVGTransform(NSString *svgTransform)
{
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    if([svgTransform rangeOfString:@"matrix"].location != NSNotFound) {
        transform = makeTransformFromSVGMatrix(svgTransform);
    } else if([svgTransform rangeOfString:@"scale"].location != NSNotFound) {
        transform = makeTransformFromSVGScale(svgTransform);
    }
    
    return transform;
}

CGFloat getXScale(CGAffineTransform t) {
    return sqrtf(t.a * t.a + t.c * t.c);
}

CGFloat getYScale(CGAffineTransform t) {
    return sqrtf(t.b * t.b + t.d * t.d);
}

CGFloat getRotation(CGAffineTransform t) {
    return atan2f(t.b, t.a);
}

CGFloat aspectScale(CGSize sourceSize, CGSize destSize) {
	CGFloat scaleW = destSize.width / sourceSize.width;
	CGFloat scaleH = destSize.height / sourceSize.height;
	return MIN(scaleW, scaleH);
}

CGAffineTransform CGAffineTransformFromRectToRect(CGRect fromRect, CGRect toRect)
{
    CGAffineTransform trans1 = CGAffineTransformMakeTranslation(-fromRect.origin.x, -fromRect.origin.y);
    CGAffineTransform scale = CGAffineTransformMakeScale(toRect.size.width/fromRect.size.width, toRect.size.height/fromRect.size.height);
    CGAffineTransform trans2 = CGAffineTransformMakeTranslation(toRect.origin.x, toRect.origin.y);
    
    return CGAffineTransformConcat(CGAffineTransformConcat(trans1, scale), trans2);
}

CGAffineTransform CGAffineTransformFromRectToRectKeepAspectRatio(CGRect fromRect, CGRect toRect)
{
    float aspectRatio = fromRect.size.width / fromRect.size.height;
    
    if( aspectRatio > (toRect.size.width / toRect.size.height)) {
        toRect = CGRectInset(toRect, 0, (toRect.size.height - toRect.size.width / aspectRatio) / 2.0f);
    } else {
        toRect = CGRectInset(toRect, (toRect.size.width - toRect.size.height * aspectRatio) / 2.0f, 0);
    }
    
    return CGAffineTransformFromRectToRect(fromRect, toRect);
}

void CGPathForTextWithFont(CGMutablePathRef *path, NSString *text, UIFont *font)
{
	if(text == nil)
		return;
	
	CTFontRef fontRef = CTFontCreateWithName((__bridge CFStringRef)font.fontName, font.pointSize, NULL);
	NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:
						   (__bridge id)fontRef, kCTFontAttributeName,
						   nil];
	NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:text
																	 attributes:attrs];
	CTLineRef line = CTLineCreateWithAttributedString((__bridge CFAttributedStringRef)attrString);
	CFArrayRef runArray = CTLineGetGlyphRuns(line);
	
	// for each RUN
	for (CFIndex runIndex = 0; runIndex < CFArrayGetCount(runArray); runIndex++)
	{
		// Get FONT for this run
		CTRunRef run = (CTRunRef)CFArrayGetValueAtIndex(runArray, runIndex);
		CTFontRef runFont = CFDictionaryGetValue(CTRunGetAttributes(run), kCTFontAttributeName);
		
		// for each GLYPH in run
		for (CFIndex runGlyphIndex = 0; runGlyphIndex < CTRunGetGlyphCount(run); runGlyphIndex++)
		{
			// get Glyph & Glyph-data
			CFRange thisGlyphRange = CFRangeMake(runGlyphIndex, 1);
			CGGlyph glyph;
			CGPoint position;
			CTRunGetGlyphs(run, thisGlyphRange, &glyph);
			CTRunGetPositions(run, thisGlyphRange, &position);
			
			CGPathRef letter = CTFontCreatePathForGlyph(runFont, glyph, NULL);
			CGAffineTransform t = CGAffineTransformMakeTranslation(position.x, position.y);
			CGPathAddPath(*path, &t, letter);
			CGPathRelease(letter);
		}
	}
	CFRelease(fontRef);
	CFRelease(line);
}