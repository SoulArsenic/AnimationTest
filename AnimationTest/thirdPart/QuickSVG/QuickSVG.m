//
//  QuickSVG.m
//  QuickSVG
//
//  Created by Matthew Newberry on 9/26/12.
//  Copyright (c) 2012 Matthew Newberry. All rights reserved.
//

#import "QuickSVG.h"
#import "QuickSVGElement.h"
#import "QuickSVGUtils.h"
#import "SMXMLDocument.h"
#import "QuickSVGParser.h"

@interface QuickSVG ()

@end

@implementation QuickSVG

- (id)initWithDelegate:(id <QuickSVGDelegate>) delegate
{
	self = [super init];
	
	if(self) {
        self.parser = [[QuickSVGParser alloc] initWithQuickSVG:self];
        if([delegate conformsToProtocol:@protocol(QuickSVGParserDelegate)]) {
            self.parserDelegate = (id <QuickSVGParserDelegate>)delegate;
        }
        
        self.delegate = delegate;
        self.ignorePattern = @"XXX";
        self.shouldTreatTextAsPaths = YES;
	}
	
	return self;
}

+ (QuickSVG *)svgFromURL:(NSURL *) url

{
	QuickSVG *svg = [[QuickSVG alloc] initWithDelegate:nil];
	[svg parseSVGFileWithURL:url];
	
	return svg;
}

- (BOOL)parseSVGFileWithURL:(NSURL *) url
{
    return [self.parser parseSVGFileWithURL:url];
}

- (BOOL)parseSVGString:(NSString *)string;
{
    return [self.parser parseSVGString:string];
}

- (void)setParserDelegate:(id<QuickSVGParserDelegate>)parserDelegate
{
    _parser.delegate = parserDelegate;
}

- (id<QuickSVGParserDelegate>)parserDelegate
{
    return _parser.delegate;
}

@end
