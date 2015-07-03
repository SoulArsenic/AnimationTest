//
//  QuickSVGElement.m
//  QuickSVG
//
//  Created by Matthew Newberry on 9/28/12.
//  Copyright (c) 2012 Matthew Newberry. All rights reserved.
//

#import "QuickSVGElement.h"
#import "QuickSVG.h"
#import "QuickSVGParser.h"
#import "QuickSVGElement+Style.h"
#import "UIColor+Additions.h"
#import "QuickSVGUtils.h"
#import "SMXMLDocument.h"
#import "UIBezierPath+Additions.h"

#define kTransformKey @"matrix"
#define kAcceptableBasicShapeTypes @[@"rect", @"circle", @"ellipse"]
#define kAcceptablePathTypes @[@"path", @"polygon", @"line", @"polyline"]

NSInteger const maxPathComplexity	= 1000;
NSInteger const maxParameters		= 64;
NSInteger const maxTokenLength		= 64;
NSString* const separatorCharString = @"-,CcMmLlHhVvZzqQaAsS";
NSString* const commandCharString	= @"CcMmLlHhVvZzqQaAsS";
unichar const invalidCommand		= '*';

@interface Token : NSObject {
@private
	unichar			command;
	NSMutableArray  *values;
}

- (id)initWithCommand:(unichar)commandChar;
- (void)addValue:(CGFloat)value;
- (CGFloat)parameter:(NSInteger)index;
- (NSInteger)valence;

@property(nonatomic, assign) unichar command;

@end

@implementation Token

- (id)initWithCommand:(unichar)commandChar {
	self = [self init];
    if (self) {
		command = commandChar;
		values = [[NSMutableArray alloc] initWithCapacity:maxParameters];
	}
	return self;
}

- (void)addValue:(CGFloat)value {
	[values addObject:[NSNumber numberWithDouble:value]];
}

- (CGFloat)parameter:(NSInteger)index {
	return [[values objectAtIndex:index] doubleValue];
}

- (NSInteger)valence
{
	return [values count];
}


@synthesize command;

@end


@interface QuickSVGElement ()

@property (nonatomic, assign) CGFloat pathScale;
@property (nonatomic, strong) NSCharacterSet *separatorSet;
@property (nonatomic, strong) NSCharacterSet *commandSet;
@property (nonatomic, assign) CGPoint lastPoint;
@property (nonatomic, assign) CGPoint lastControlPoint;
@property (nonatomic, assign) BOOL validLastControlPoint;
@property (nonatomic, strong) NSMutableArray *tokens;
@property (nonatomic, strong) UIBezierPath *bezierPathBeingDrawn;
@property (nonatomic, assign) CGFloat scale;

- (QuickSVGElementType) elementTypeForKey:(NSString *)key;
- (CALayer *) addText:(NSString *)text withAttributes:(NSDictionary *) attributes;
- (UIBezierPath *) addPath:(NSString *) pathType withAttributes:(NSDictionary *) attributes;
- (UIBezierPath *) addBasicShape:(NSString *) shapeType withAttributes:(NSDictionary *) attributes;
- (UIBezierPath *) drawRectWithAttributes:(NSDictionary *) attributes;
- (UIBezierPath *) drawCircleWithAttributes:(NSDictionary *) attributes;
- (UIBezierPath *) drawPathWithAttributes:(NSDictionary *) attributes;
- (UIBezierPath *) drawLineWithAttributes:(NSDictionary *) attributes;
- (UIBezierPath *) drawPolylineWithAttributes:(NSDictionary *) attributes;
- (UIBezierPath *) drawPolygonWithAttributes:(NSDictionary *) attributes;
- (NSMutableArray *)parsePath:(NSString *)attr;
- (CGAffineTransform) svgTransform;
- (void)reset;
- (void)appendSVGMCommand:(Token *)token;
- (void)appendSVGLCommand:(Token *)token;
- (void)appendSVGCCommand:(Token *)token;
- (void)appendSVGSCommand:(Token *)token;
- (NSArray *) arrayFromPointsAttribute:(NSString *) points;

@end

@implementation QuickSVGElement

- (id) initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	
	if(self) {		
		[self setup];
	}
	
	return self;
}

- (void) setup
{
    self.pathScale = 0;
    self.separatorSet = [NSCharacterSet characterSetWithCharactersInString:separatorCharString];
    self.commandSet = [NSCharacterSet characterSetWithCharactersInString:commandCharString];
    self.attributes = [NSMutableDictionary dictionary];
    self.shapeLayers = [NSMutableArray array];
    self.opaque = YES;
    
    [self reset];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	BOOL shouldSelect = YES;
	
	if(_quickSVG.parser.delegate == nil)
		return;
	
	if([_quickSVG.delegate respondsToSelector:@selector(quickSVG:shouldSelectInstance:)]) {
		shouldSelect = [_quickSVG.delegate quickSVG:_quickSVG shouldSelectInstance:self];
	}
	
	if(shouldSelect && [_quickSVG.delegate respondsToSelector:@selector(quickSVG:didSelectInstance:)]) {
		[_quickSVG.delegate quickSVG:_quickSVG didSelectInstance:self];
	}
	else {
		[super touchesBegan:touches withEvent:event];
	}
}

- (void) setFrame:(CGRect)frame
{
    self.scale = aspectScale(self.frame.size, frame.size);
    
    if(!isnan(_scale) && _scale != INFINITY && _scale != 1 && !CGRectEqualToRect(frame, CGRectZero) && !CGRectEqualToRect(self.frame, CGRectZero)) {
                
        CGAffineTransform scale = CGAffineTransformMakeScale(_scale, _scale);
        [_shapePath applyTransform:scale];
        
        self.transform = CGAffineTransformScale(self.transform, _scale, _scale);
    }
    
    [super setFrame:frame];
}

- (CGSize)sizeThatFits:(CGSize)size
{
    return CGPathGetBoundingBox(_shapePath.CGPath).size;
}

- (void) setAttributes:(NSMutableDictionary *)attributes
{
    _attributes = attributes;
    [self setElements:_elements];
}

- (CGAffineTransform) svgTransform
{
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    if(self.attributes[@"transform"]) {
        transform = makeTransformFromSVGMatrix(self.attributes[@"transform"]);
    }
    
    return transform;
}

- (void) setElements:(NSArray *)elements
{	
	if([elements count] == 0)
		return;
    
    _elements = elements;
				    
    CGAffineTransform pathTransform = CGAffineTransformIdentity;
    
    CGFloat transX = self.frame.origin.x;
    CGFloat transY = self.frame.origin.y;
    
    pathTransform = CGAffineTransformTranslate(pathTransform, -transX, -transY);
    
    // Custom transform previously applied, need to flip the y axis to correspond for CG drawing
    if(self.attributes[@"transform"]) {
        pathTransform = CGAffineTransformScale(pathTransform, 1, -1);
    }
    
	[self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
	self.shapePath = [UIBezierPath bezierPath];
    
	for(SMXMLElement *element in self.elements) {
        
        if(self.quickSVG.parser.isAborted){
            break;
        }
        
		if(![element isKindOfClass:[SMXMLElement class]])
			continue;
		
		UIBezierPath *path = [UIBezierPath bezierPath];
        
        NSString *shapeKey = element.name;
        NSDictionary *attributes = element.attributes;
                
		QuickSVGElementType type = [self elementTypeForKey:shapeKey];

		CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.contentsScale = [UIScreen mainScreen].scale;
        
        CGAffineTransform elementTransform = CGAffineTransformIdentity;
        if(attributes[@"transform"]) {
            elementTransform = makeTransformFromSVGMatrix(attributes[@"transform"]);
        }
		
		switch (type) {
			case QuickSVGElementTypeBasicShape:
				path = [self addBasicShape:shapeKey withAttributes:attributes];
				break;
			case QuickSVGElementTypePath:
				path = [self addPath:shapeKey withAttributes:attributes];
				break;
			case QuickSVGElementTypeText:
            {
                CALayer *textLayer = [self addText:element.value withAttributes:attributes];
                if(self.quickSVG.shouldTreatTextAsPaths) {
                    CAShapeLayer *l = (CAShapeLayer *)textLayer;
                    path = [UIBezierPath bezierPathWithCGPath:l.path];
                } else {
                    [self.layer addSublayer:textLayer];
                }
			}
				break;
			case QuickSVGElementTypeUnknown:
			default:
//                NSLog(@"<< Invalid Element >> %@", shapeKey);
                continue;
				break;
		}
		
		if(path) {
            [path applyTransform:pathTransform];
            [path applyTransform:elementTransform];
			NSMutableDictionary *styles = [NSMutableDictionary dictionaryWithDictionary:attributes];
			[styles addEntriesFromDictionary:_attributes];
            
			shapeLayer.path = path.CGPath;
			[self applyStyleAttributes:styles toShapeLayer:shapeLayer];
        
			[self.layer addSublayer:shapeLayer];
			[_shapePath appendPath:path];
            [_shapeLayers addObject:shapeLayer];
		}
	}
}

- (void) setShapeLayers:(NSMutableArray *)shapeLayers
{
    _shapeLayers = shapeLayers;
    
    for(CAShapeLayer *layer in shapeLayers) {
        [self.layer addSublayer:layer];
    }
}

- (QuickSVGElementType) elementTypeForKey:(NSString *)key
{
	if([kAcceptableBasicShapeTypes containsObject:key]) {
		return QuickSVGElementTypeBasicShape;
	}
	else if([kAcceptablePathTypes containsObject:key]) {
		return QuickSVGElementTypePath;
	}
	else if([key isEqualToString:@"text"] || [key isEqualToString:@"tspan"]) {
		return QuickSVGElementTypeText;
	}
	else {
		return QuickSVGElementTypeUnknown;
	}
}

- (CALayer *) addText:(NSString *)text withAttributes:(NSDictionary *) attributes
{    
    CALayer *layer;
        
    CGFloat fontSize        = [attributes[@"font-size"] floatValue];
    NSString *fontFamily    = [attributes[@"font-family"] stringByReplacingOccurrencesOfString:@"'" withString:@""];
    UIFont *font            = [UIFont fontWithName:fontFamily size:fontSize];
    
    if(font == nil) {
        font = [UIFont systemFontOfSize:[attributes[@"font-size"] floatValue]];
    }
    
    CGColorRef fontColor = [UIColor blackColor].CGColor;
    if([[attributes allKeys] containsObject:@"fill"]) {
        fontColor = [UIColor colorWithHexString:[attributes[@"fill"] substringFromIndex:1] withAlpha:1].CGColor;
    }
    
    CGSize textSize         = [text sizeWithAttributes:@{NSFontAttributeName : font}];
    
    if(self.quickSVG.shouldTreatTextAsPaths) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.anchorPoint = CGPointMake(0,0);
        shapeLayer.fillColor = fontColor;
        
        CGMutablePathRef textPath = CGPathCreateMutable();
        CGPathForTextWithFont(&textPath, text, font);
        shapeLayer.path = textPath;
        
        if(attributes[@"x"] && attributes[@"y"]) {
            // Y is negative here to compensate for the inverse matrix of CALayer
            CGAffineTransform transform = CGAffineTransformMakeTranslation([attributes[@"x"] floatValue], -[attributes[@"y"] floatValue]);
            CGPathRef path = CGPathCreateCopyByTransformingPath(textPath, &transform);
            shapeLayer.path = path;
            CGPathRelease(path);
        }
        
        CGPathRelease(textPath);
        
        layer = shapeLayer;
    } else {
        CATextLayer *textLayer = [CATextLayer layer];
        textLayer.anchorPoint = CGPointMake(0,0);
        textLayer.string = text;
        textLayer.fontSize = fontSize;
        textLayer.rasterizationScale = textLayer.contentsScale;
        textLayer.foregroundColor = fontColor;
        textLayer.bounds = CGRectMake(0, 0, textSize.width, textSize.height);
        textLayer.contentsScale = [UIScreen mainScreen].scale;
        
        CGFontRef fontRef = CGFontCreateWithFontName((__bridge CFStringRef)[font fontName]);
        [textLayer setFont:fontRef];
        CFRelease(fontRef);
        
        layer = textLayer;
    }
    
    return layer;
}

- (UIBezierPath *) addPath:(NSString *) pathType withAttributes:(NSDictionary *) attributes
{
	if([pathType isEqualToString:@"path"]) {
		return [self drawPathWithAttributes:attributes];
	}
	else if([pathType isEqualToString:@"line"]) {
		return [self drawLineWithAttributes:attributes];
	}
	else if([pathType isEqualToString:@"polyline"]) {
		return [self drawPolylineWithAttributes:attributes];
	}
	else if([pathType isEqualToString:@"polygon"]) {
		return [self drawPolygonWithAttributes:attributes];
	}
	
	return nil;
}

- (UIBezierPath *) addBasicShape:(NSString *) shapeType withAttributes:(NSDictionary *) attributes
{
	if([shapeType isEqualToString:@"rect"]) {
		return [self drawRectWithAttributes:attributes];
	}
	else if([shapeType isEqualToString:@"circle"]) {
		return [self drawCircleWithAttributes:attributes];
	}
	else if([shapeType isEqualToString:@"ellipse"]) {
		return [self drawCircleWithAttributes:attributes];
	}
	else {
//		if (DEBUG) {
			NSLog(@"**** Invalid basic shape: %@", shapeType);
//		}
	}
	
	return nil;
}

#pragma mark -
#pragma mark Shape Drawing

- (UIBezierPath *) drawRectWithAttributes:(NSDictionary *) attributes
{
	CGRect frame = CGRectMake([attributes[@"x"] floatValue], [attributes[@"y"] floatValue], [attributes[@"width"] floatValue], [attributes[@"height"] floatValue]);
	
	UIBezierPath *rect = [UIBezierPath bezierPathWithRect:frame];
	
	return rect;
}

- (UIBezierPath *) drawCircleWithAttributes:(NSDictionary *) attributes
{
    CGFloat cx = 0, cy = 0, rx = 0, ry = 0;
    
	if([attributes[@"cx"] length] > 0)
        cx = [attributes[@"cx"] floatValue];
    
    if([attributes[@"cy"] length] > 0)
        cy = [attributes[@"cy"] floatValue];
    
    if([attributes[@"rx"] length] > 0)
        rx = [attributes[@"rx"] floatValue];
    
    if([attributes[@"ry"] length] > 0)
        ry = [attributes[@"ry"] floatValue];
	
	if([attributes[@"r"] length] > 0)
        rx = ry = [attributes[@"r"] floatValue];
    
    UIBezierPath *ellipse = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(cx - rx, cy - ry, rx * 2, ry * 2)];
	
	return ellipse;
}

- (UIBezierPath *) drawPathWithAttributes:(NSDictionary *) attributes
{
	self.bezierPathBeingDrawn = [UIBezierPath bezierPath];
	
	NSString *pathData = [attributes[@"d"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    pathData = [pathData stringByReplacingOccurrencesOfString:@" " withString:@","];
	
	[self parsePath:pathData];
	
	[self reset];
	
	NSArray *tokens = [NSArray arrayWithArray:_tokens];
	
	for (Token *thisToken in tokens) {
		unichar command = [thisToken command];
		switch (command) {
			case 'M':
			case 'm':
				[self appendSVGMCommand:thisToken];
				break;
			case 'L':
			case 'l':
			case 'H':
			case 'h':
			case 'V':
			case 'v':
				[self appendSVGLCommand:thisToken];
				break;
			case 'C':
			case 'c':
				[self appendSVGCCommand:thisToken];
				break;
			case 'S':
			case 's':
				[self appendSVGSCommand:thisToken];
				break;
			case 'Z':
			case 'z':
				[_bezierPathBeingDrawn closePath];
				break;
			default:
				NSLog(@"*** Error: Cannot process command : '%c'", command);
				break;
		}
	}
	
	return _bezierPathBeingDrawn;
}

- (UIBezierPath *) drawLineWithAttributes:(NSDictionary *) attributes
{
	UIBezierPath *line = [UIBezierPath bezierPath];
	CGPoint startingPoint = CGPointMake([attributes[@"x1"] floatValue], [attributes[@"y1"] floatValue]);
	CGPoint endingPoint = CGPointMake([attributes[@"x2"] floatValue], [attributes[@"y2"] floatValue]);
	
	[line moveToPoint:startingPoint];
	[line addLineToPoint:endingPoint];
	
	return line;
}

- (UIBezierPath *) drawPolylineWithAttributes:(NSDictionary *) attributes
{
	return [self drawPolyElementWithAttributes:attributes isPolygon:NO];
}

- (UIBezierPath *) drawPolygonWithAttributes:(NSDictionary *) attributes
{
	return [self drawPolyElementWithAttributes:attributes isPolygon:YES];
}

- (UIBezierPath *) drawPolyElementWithAttributes:(NSDictionary *) attributes isPolygon:(BOOL) isPolygon
{	
	NSArray *points = [self arrayFromPointsAttribute:attributes[@"points"]];
	UIBezierPath *polygon = [UIBezierPath bezierPath];
	
	CGPoint firstPoint = CGPointFromString(points[0]);
	[polygon moveToPoint:firstPoint];
	
	for(int x = 0; x < [points count]; x++) {		
		if(x + 1 < [points count]) {
			CGPoint endPoint = CGPointFromString(points[x + 1]);
			[polygon addLineToPoint:endPoint];
		}
	}
	
	if(isPolygon) {
		[polygon addLineToPoint:firstPoint];
		[polygon closePath];
	}
	
	return polygon;
}

#pragma mark -
#pragma mark Path Drawing

- (NSMutableArray *)parsePath:(NSString *)attr
{
	NSMutableArray *stringTokens = [NSMutableArray arrayWithCapacity: maxPathComplexity];
	
	NSInteger index = 0;
	while (index < [attr length]) {
		
		NSMutableString *stringToken = [[NSMutableString alloc] initWithCapacity:maxTokenLength];
		[stringToken setString:@""];
		
		unichar	charAtIndex = [attr characterAtIndex:index];
		
		if (charAtIndex != ',') {
			[stringToken appendString:[NSString stringWithFormat:@"%c", charAtIndex]];
		}
		
		if (![_commandSet characterIsMember:charAtIndex] && charAtIndex != ',') {
			
			while ( (++index < [attr length]) && ![_separatorSet characterIsMember:(charAtIndex = [attr characterAtIndex:index])] ) {
				
				[stringToken appendString:[NSString stringWithFormat:@"%c", charAtIndex]];
			}
		} else {
			index++;
		}
		
		if ([stringToken length]) {
			[stringTokens addObject:stringToken];
		}
	}
	
	if ([stringTokens count] == 0) {
		
		NSLog(@"*** Error: Path string is empty of tokens");
		return nil;
	}
	
	// turn the stringTokens array into Tokens, checking validity of tokens as we go
	_tokens = [[NSMutableArray alloc] initWithCapacity:maxPathComplexity];
	index = 0;
	NSString *stringToken = [stringTokens objectAtIndex:index];
	unichar command = [stringToken characterAtIndex:0];
	while (index < [stringTokens count]) {
		if (![_commandSet characterIsMember:command]) {
			NSLog(@"*** Error: Path string parse error: found float where expecting command at token %ldd in path %s.",
				  (long)(long)index, [attr cStringUsingEncoding:NSUTF8StringEncoding]);
			return nil;
		}
		Token *token = [[Token alloc] initWithCommand:command];
		
		// There can be any number of floats after a command. Suck them in until the next command.
		while ((++index < [stringTokens count]) && ![_commandSet characterIsMember:
													 (command = [(stringToken = [stringTokens objectAtIndex:index]) characterAtIndex:0])]) {
			
			NSScanner *floatScanner = [NSScanner scannerWithString:stringToken];
			float value;
			if (![floatScanner scanFloat:&value]) {
				NSLog(@"*** Error: Path string parse error: expected float or command at token %ld (but found %s) in path %s.",
					  (long)index, [stringToken cStringUsingEncoding:NSUTF8StringEncoding], [attr cStringUsingEncoding:NSUTF8StringEncoding]);
				return nil;
			}
			// Maintain scale.
			_pathScale = (fabsf(value) > _pathScale) ? fabsf(value) : _pathScale;
			[token addValue:value];
		}
		
		// now we've reached a command or the end of the stringTokens array
		[_tokens addObject:token];
	}
	//[stringTokens release];
	return _tokens;
}

- (void)reset
{
	_lastPoint = CGPointMake(0, 0);
	_validLastControlPoint = NO;
}

- (void)appendSVGMCommand:(Token *)token
{
	_validLastControlPoint = NO;
	NSInteger index = 0;
	BOOL first = YES;
	while (index < [token valence]) {
		CGFloat x = [token parameter:index] + ([token command] == 'm' ? _lastPoint.x : 0);
		if (++index == [token valence]) {
			NSLog(@"*** Error: Invalid parameter count in M style token");
			return;
		}
		CGFloat y = [token parameter:index] + ([token command] == 'm' ? _lastPoint.y : 0);
		_lastPoint = CGPointMake(x, y);
		if (first) {
			[_bezierPathBeingDrawn moveToPoint:_lastPoint];
			first = NO;
		} else {
			[_bezierPathBeingDrawn addLineToPoint:_lastPoint];
		}
		index++;
	}
}

- (void)appendSVGLCommand:(Token *)token
{
	_validLastControlPoint = NO;
	NSInteger index = 0;
	while (index < [token valence]) {
		CGFloat x = 0;
		CGFloat y = 0;
		switch ( [token command] ) {
			case 'l':
				x = _lastPoint.x;
				y = _lastPoint.y;
			case 'L':
				x += [token parameter:index];
				if (++index == [token valence]) {
					NSLog(@"*** Error: Invalid parameter count in L style token");
					return;
				}
				y += [token parameter:index];
				break;
			case 'h' :
				x = _lastPoint.x;
			case 'H' :
				x += [token parameter:index];
				y = _lastPoint.y;
				break;
			case 'v' :
				y = _lastPoint.y;
			case 'V' :
				y += [token parameter:index];
				x = _lastPoint.x;
				break;
			default:
				NSLog(@"*** Error: Unrecognised L style command.");
				return;
		}
		_lastPoint = CGPointMake(x, y);
		
		[_bezierPathBeingDrawn addLineToPoint:_lastPoint];
		index++;
	}
}

- (void)appendSVGCCommand:(Token *)token
{
	NSInteger index = 0;
	while ((index + 5) < [token valence]) {  // we must have 6 floats here (x1, y1, x2, y2, x, y).
		CGFloat x1 = [token parameter:index++] + ([token command] == 'c' ? _lastPoint.x : 0);
		CGFloat y1 = [token parameter:index++] + ([token command] == 'c' ? _lastPoint.y : 0);
		CGFloat x2 = [token parameter:index++] + ([token command] == 'c' ? _lastPoint.x : 0);
		CGFloat y2 = [token parameter:index++] + ([token command] == 'c' ? _lastPoint.y : 0);
		CGFloat x  = [token parameter:index++] + ([token command] == 'c' ? _lastPoint.x : 0);
		CGFloat y  = [token parameter:index++] + ([token command] == 'c' ? _lastPoint.y : 0);
		_lastPoint = CGPointMake(x, y);
		
		[_bezierPathBeingDrawn addCurveToPoint:_lastPoint
								 controlPoint1:CGPointMake(x1,y1)
								 controlPoint2:CGPointMake(x2, y2)];
		
		_lastControlPoint = CGPointMake(x2, y2);
		_validLastControlPoint = YES;
	}
	
	if (index == 0) {
		NSLog(@"*** Error: Insufficient parameters for C command");
	}
}

- (void)appendSVGSCommand:(Token *)token
{
	if (!_validLastControlPoint) {
		NSLog(@"*** Error: Invalid last control point in S command");
	}
	
	NSInteger index = 0;
	while ((index + 3) < [token valence]) {  // we must have 4 floats here (x2, y2, x, y).
		CGFloat x1 = _lastPoint.x + (_lastPoint.x - _lastControlPoint.x); // + ([token command] == 's' ? lastPoint.x : 0);
		CGFloat y1 = _lastPoint.y + (_lastPoint.y - _lastControlPoint.y); // + ([token command] == 's' ? lastPoint.y : 0);
		CGFloat x2 = [token parameter:index++] + ([token command] == 's' ? _lastPoint.x : 0);
		CGFloat y2 = [token parameter:index++] + ([token command] == 's' ? _lastPoint.y : 0);
		CGFloat x  = [token parameter:index++] + ([token command] == 's' ? _lastPoint.x : 0);
		CGFloat y  = [token parameter:index++] + ([token command] == 's' ? _lastPoint.y : 0);
		_lastPoint = CGPointMake(x, y);
		
		[_bezierPathBeingDrawn addCurveToPoint:_lastPoint
								 controlPoint1:CGPointMake(x1,y1)
								 controlPoint2:CGPointMake(x2, y2)];
		
		_lastControlPoint = CGPointMake(x2, y2);
		_validLastControlPoint = YES;
	}
	
	if (index == 0) {
		NSLog(@"*** Error: Insufficient parameters for S command");
	}
}

- (NSArray *) arrayFromPointsAttribute:(NSString *) points
{
    NSCharacterSet *whitespaces = [NSCharacterSet whitespaceCharacterSet];
	NSPredicate *noEmptyStrings = [NSPredicate predicateWithFormat:@"SELF != ''"];
	
	NSArray *parts = [points componentsSeparatedByCharactersInSet:whitespaces];
	NSArray *filteredArray = [parts filteredArrayUsingPredicate:noEmptyStrings];
	NSString *parsed = [filteredArray componentsJoinedByString:@","];
	
	NSArray *commaPieces = [parsed componentsSeparatedByString:@","];
	
	NSMutableArray *pointsArray = [NSMutableArray arrayWithCapacity:[commaPieces count] / 2];
	
	for(int x = 0; x < [commaPieces count]; x++) {
		if(x % 2 == 0) {
			CGPoint point = CGPointMake([commaPieces[x] floatValue], [commaPieces[x + 1] floatValue]);
			[pointsArray addObject:NSStringFromCGPoint(point)];
		}
	}	
	return pointsArray;
}

- (void) encodeWithCoder:(NSCoder *)aCoder
{    
	[aCoder encodeObject:_shapeLayers forKey:@"shapeLayers"];
    [aCoder encodeObject:_shapePath forKey:@"shapePath"];
	[aCoder encodeObject:self.attributes forKey:@"attributes"];
}

- (id) initWithCoder:(NSCoder *)aDecoder
{    
	self = [super initWithCoder:aDecoder];
	
	if(self) {
        [self setup];
        
        self.attributes = [aDecoder decodeObjectForKey:@"attributes"];
        self.shapeLayers = [aDecoder decodeObjectForKey:@"shapeLayers"];
        self.shapePath = [aDecoder decodeObjectForKey:@"shapePath"];
        
        for(CAShapeLayer *layer in _shapeLayers) {
            [self applyStyleAttributes:_attributes toShapeLayer:layer];
        }
	}
	
	return self;
}

@end
