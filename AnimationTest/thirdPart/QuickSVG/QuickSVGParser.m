//
//  QuickSVGParser.m
//  QuickSVG
//
//  Created by Matthew Newberry on 2/20/13.
//  Copyright (c) 2013 Matthew Newberry. All rights reserved.
//

#import "QuickSVGParser.h"
#import "QuickSVG.h"
#import "SMXMLDocument.h"
#import "QuickSVGElement.h"
#import "QuickSVGUtils.h"

@interface QuickSVGParser ()

@property (nonatomic, strong) SMXMLDocument *document;

- (void)parseElement:(SMXMLElement *)element;
- (void)handleSVGElement:(SMXMLElement *)element;
- (void)handleDrawingElement:(SMXMLElement *)element;
- (void)handleSymbolElement:(SMXMLElement *)element;
- (void)handleGroupElement:(SMXMLElement *)element;
- (void)handleUseElement:(SMXMLElement *)element;

- (BOOL)shouldIgnoreElement:(SMXMLElement *)element;
- (void)cleanElement:(SMXMLElement *)element;
- (NSMutableArray *)flattenedElementsForElement:(SMXMLElement *)element;

- (void)addInstanceOfSymbol:(SMXMLElement *)symbol child:(SMXMLElement *)child;
- (QuickSVGElement *)elementFromXMLNode:(SMXMLElement *)element shouldDraw:(BOOL)draw;

/* Parser Callbacks */
- (void)notifyDidParseElement:(QuickSVGElement *)element;
- (void)notifyWillParse;
- (void)notifyDidParse;
- (void)notifyDidAbort;

/* Utilities */
- (void)applyAttributesFrom:(SMXMLElement *)from toElement:(SMXMLElement *)to;
- (BOOL)shouldAbortParsingElement:(SMXMLElement *)element;
- (CGRect)frameFromAttributes:(NSDictionary *)attributes;

@end

@implementation QuickSVGParser

- (id)initWithQuickSVG:(QuickSVG *)quickSVG
{
	self = [super init];
	
	if(self) {
		self.quickSVG = quickSVG;
		self.symbols = [NSMutableDictionary dictionary];
		self.instances = [NSMutableDictionary dictionary];
		self.groups = [NSMutableDictionary dictionary];
        self.elements = [NSMutableArray array];
		self.isAborted = NO;
	}
	
	return self;
}

- (BOOL)parseSVGString:(NSString *)string
{
    if ([string length] == 0)
        return NO;
    
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [self parseSVGWithData:data];
}

- (BOOL)parseSVGWithData:(NSData *)data
{
    __block BOOL successful = YES;
    
    if(_document) {
        [self abort];
        _document = nil;
    }
    
    [self notifyWillParse];
    
    [_symbols removeAllObjects];
    [_instances removeAllObjects];
    [_groups removeAllObjects];
    [_elements removeAllObjects];
    
    _isAborted = NO;
    
    NSError *error;
    self.document = [[SMXMLDocument alloc] initWithData:data error:&error];
    
    if(error) {
        [self abort];
        successful = NO;
    }
    
    self.isParsing = YES;
    
    SMXMLElement *root = self.document.root;
    [self cleanElement:root];
    
    if([root.name isEqualToString:@"svg"])
        [self handleSVGElement:root];
    
    [root.children enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        SMXMLElement *element = (SMXMLElement *)obj;
        
        if([self shouldAbortParsingElement:element]) {
            *stop = YES;
        }
        
        [self parseElement:element];
    }];
    
    [self notifyDidParse];
    
    return successful;
}

- (BOOL)parseSVGFileWithURL:(NSURL *) url
{
	NSData *data = [NSData dataWithContentsOfURL:url];
    return [self parseSVGWithData:data];
}

#pragma Elements
- (void)parseElement:(SMXMLElement *)element
{
    if([element.name isEqualToString:@"symbol"]) {
        [self handleSymbolElement:element];
    } else if([element.name isEqualToString:@"g"]) {
        [self handleGroupElement:element];
    } else if([element.name isEqualToString:@"use"]) {
        [self handleUseElement:element];
    } else if([element.name isEqualToString:@"text"]) {
        [self handleTextElement:element];
    } else {
        [self handleDrawingElement:element];
    }
}

- (void)handleSVGElement:(SMXMLElement *)element
{
    self.quickSVG.canvasFrame = [self frameFromAttributes:element.attributes];
    _quickSVG.view = [[UIView alloc] initWithFrame:self.quickSVG.canvasFrame];
}

- (void)handleDrawingElement:(SMXMLElement *)element
{
    QuickSVGElement *instance = [self elementFromXMLNode:element shouldDraw:YES];
    [self notifyDidParseElement:instance];
}

- (void)handleSymbolElement:(SMXMLElement *)element
{
    NSString *key = [[element.attributes allKeys] containsObject:@"id"] ? element.attributes[@"id"] : [NSString stringWithFormat:@"Symbol%i", (int)[_symbols count] + 1];
    
    NSMutableArray *flat = [self flattenedElementsForElement:element];
    [element.children removeAllObjects];
    [element.children addObjectsFromArray:flat];
    self.symbols[key] = element;
}

- (void)handleGroupElement:(SMXMLElement *)element
{
    NSString *key = [[element.attributes allKeys] containsObject:@"id"] ? element.attributes[@"id"] : [NSString stringWithFormat:@"Group%i", (int)[_groups count] + 1];
    self.groups[key] = element;
    
    NSArray *elements = [self flattenedElementsForElement:element];
    [elements enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        SMXMLElement *child = (SMXMLElement *)obj;
        if([self shouldAbortParsingElement:child]) {
            *stop = YES;
        }

        [self parseElement:child];
    }];
}

- (void)handleUseElement:(SMXMLElement *)element
{
    if(!element.attributes[@"xlink:href"])
        return;
    
    NSString *symbolRef = [element.attributes[@"xlink:href"] substringFromIndex:1];
    SMXMLElement *symbol = self.symbols[symbolRef];
    
    [self addInstanceOfSymbol:symbol child:element];
}

- (void)handleTextElement:(SMXMLElement *)element
{
    [self handleDrawingElement:element];
}

- (BOOL)shouldIgnoreElement:(SMXMLElement *)element
{
    BOOL ignore = NO;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF BEGINSWITH %@", self.quickSVG.ignorePattern];
    ignore = [predicate evaluateWithObject:element.attributes[@"id"]];
    
    if(!ignore && [element.attributes[@"display"] isEqualToString:@"none"]) {
        ignore = YES;
    }
    
    return ignore;
}

- (void)cleanElement:(SMXMLElement *)element
{
    if([self shouldIgnoreElement:element]) {
        [element.parent.children removeObject:element];
        return;
    }
    
    NSArray *children = [NSArray arrayWithArray:element.children];
    [children enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        SMXMLElement *child = (SMXMLElement *)obj;
        if([self shouldAbortParsingElement:child]) {
            *stop = YES;
        }
        
        [self cleanElement:child];
    }];
}

- (NSMutableArray *)flattenedElementsForElement:(SMXMLElement *)element
{
    __block NSMutableArray *elements = [NSMutableArray array];
    
    [element.children enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        SMXMLElement *child = (SMXMLElement *)obj;
        if([self shouldAbortParsingElement:child]) {
            *stop = YES;
        }
        
        [self applyAttributesFrom:child.parent toElement:child];
        
        if([child.children count] > 0) {
            [elements addObjectsFromArray:[self flattenedElementsForElement:child]];
        } else {
            [elements addObject:child];
        }
    }];
    
    return elements;
}

#pragma Instance Factory
- (QuickSVGElement *)elementFromXMLNode:(SMXMLElement *)element shouldDraw:(BOOL)draw
{
    CGRect frame = [self frameFromAttributes:element.attributes];

	QuickSVGElement *instance = [[QuickSVGElement alloc] initWithFrame:frame];
    
    if(element.attributes[@"transform"]) {
        instance.transform = makeTransformFromSVGTransform(element.attributes[@"transform"]);
    }
    
	[instance.attributes addEntriesFromDictionary:element.attributes];
    instance.attributes[@"elementName"] = element.name;
	instance.quickSVG = self.quickSVG;
    
    if(draw) {
        instance.elements = [element.children count] > 0 ? [self flattenedElementsForElement:element] : @[element];
    }
    
    NSString *key = [[element.attributes allKeys] containsObject:@"id"] ? element.attributes[@"id"] : [NSString stringWithFormat:@"Instance%i", (int)[_symbols count] + 1];
    self.instances[key] = instance;

	return instance;
}

- (void)addInstanceOfSymbol:(SMXMLElement *)symbol child:(SMXMLElement *)child
{    
	QuickSVGElement *instance = [self elementFromXMLNode:symbol shouldDraw:NO];
    instance.frame = [self frameFromAttributes:symbol.attributes];
    
    [self applyAttributesFrom:symbol toElement:child];
    [instance.attributes removeAllObjects];
    [instance.attributes addEntriesFromDictionary:child.attributes];
    instance.elements = symbol.children;
    
    if(child.attributes[@"transform"]) {
        instance.transform = makeTransformFromSVGTransform(child.attributes[@"transform"]);
    }
    
    [self notifyDidParseElement:instance];
}

#pragma Delegate callbacks
- (void)notifyDidParseElement:(QuickSVGElement *)element
{
    [_elements addObject:element];
    [self.quickSVG.view addSubview:element];
    
    if(!self.isAborted && _delegate && [_delegate respondsToSelector:@selector(quickSVG:didParseElement:)]) {
        [self.delegate quickSVG:self.quickSVG didParseElement:element];
    }
}

- (void)notifyWillParse
{
    if(!self.isAborted && _delegate && [_delegate respondsToSelector:@selector(quickSVGWillParse:)]) {
        [self.delegate quickSVGWillParse:self.quickSVG];
    }
}

- (void)notifyDidParse
{
    if(!self.isAborted && _delegate && [_delegate respondsToSelector:@selector(quickSVGDidParse:)]) {
        [self.delegate quickSVGDidParse:self.quickSVG];
    }
}

- (void)notifyDidAbort
{
    if(self.isAborted && _delegate && [_delegate respondsToSelector:@selector(quickSVGDidAbort:)]) {
        [self.delegate quickSVGDidAbort:self.quickSVG];
    }
}


#pragma Utilities

- (BOOL)shouldAbortParsingElement:(SMXMLElement *)element
{
    return self.isAborted || element.document != self.document;
}

- (void)abort
{
	self.isAborted = YES;
    self.isParsing = NO;
    [self.document abort];
    
    [self notifyDidAbort];
}

- (void)applyAttributesFrom:(SMXMLElement *)from toElement:(SMXMLElement *)to
{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:from.attributes];
    [attributes addEntriesFromDictionary:to.attributes];
    [to.attributes removeAllObjects];
    [to.attributes addEntriesFromDictionary:attributes];
}

- (CGRect)frameFromAttributes:(NSDictionary *)attributes
{
    CGRect frame = CGRectZero;
    if(attributes[@"viewBox"]) {
        NSArray *pieces = [attributes[@"viewBox"] componentsSeparatedByString:@" "];
        frame = CGRectMake([pieces[0] floatValue], [pieces[1] floatValue], [pieces[2] floatValue], [pieces[3] floatValue]);
    } else if(attributes[@"x"]) {
        frame = CGRectMake([attributes[@"x"] floatValue], [attributes[@"y"] floatValue], [attributes[@"width"] floatValue], [attributes[@"height"] floatValue]);
    } else if(attributes[@"width"]){
        frame = CGRectMake(0,0, [attributes[@"width"] floatValue], [attributes[@"height"] floatValue]);
    }
    
    if(attributes[@"transform"]) {
        frame = CGRectApplyAffineTransform(frame, makeTransformFromSVGTransform(attributes[@"transform"]));
    }
    
    return frame;
}

@end
