//
//  NSString+Weibo.m
//  CoreTextDemo
//
//  Created by cxjwin on 13-10-31.
//  Copyright (c) 2013年 cxjwin. All rights reserved.
//

#import "NSString+Weibo.h"
#import <UIKit/UIKit.h>

NSString *const kCustomGlyphAttributeType = @"CustomGlyphAttributeType";
NSString *const kCustomGlyphAttributeRange = @"CustomGlyphAttributeRange";
NSString *const kCustomGlyphAttributeImageName = @"CustomGlyphAttributeImageName";
NSString *const kCustomGlyphAttributeInfo = @"CustomGlyphAttributeInfo";

/* Callbacks */
static void deallocCallback(void *refCon){
    free(refCon), refCon = NULL;
}

static CGFloat ascentCallback(void *refCon){
    CustomGlyphMetricsRef metrics = (CustomGlyphMetricsRef)refCon;
    return metrics->ascent;
}

static CGFloat descentCallback(void *refCon){
    CustomGlyphMetricsRef metrics = (CustomGlyphMetricsRef)refCon;
    return metrics->descent;
}

static CGFloat widthCallback(void *refCon){
    CustomGlyphMetricsRef metrics = (CustomGlyphMetricsRef)refCon;
    return metrics->width;
}

@implementation NSString (Weibo)

static NSDictionary *emojiDictionary = nil;
NSDictionary *SinaEmojiDictionary()
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *emojiFilePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"imageface.plist"];
        emojiDictionary = [[NSDictionary alloc] initWithContentsOfFile:emojiFilePath];
    });
    return emojiDictionary;
}

static NSDictionary *wxemojiDictionary = nil;
NSDictionary *WeiXinEmojiDictionary()
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *emojiFilePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"weixinFace.plist"];
        wxemojiDictionary = [[NSDictionary alloc] initWithContentsOfFile:emojiFilePath];
    });
    return wxemojiDictionary;
}

//这里是匹配微信
- (NSMutableAttributedString *)transformWXText
{
  //  NSString *regex_emoji = @"\\[/:.+.*.+\\]";
    NSString *regex_emoji = @"/::\\)|/::~|/::B|/::\\||/:8-\\)|/::<|/::$|/::X|/::Z|/::'\\(|/::-\\||/::@|/::P|/::D|/::O|/::\\(|/::\\+|/:--b|/::Q|/::T|/:,@P|/:,@-D|/::d|/:,@o|/::g|/:\\|-\\)|/::!|/::L|/::>|/::,@|/:,@f|/::-S|/:\\?|/:,@x|/:,@@|/::8|/:,@!|/:!!!|/:xx|/:bye|/:wipe|/:dig|/:handclap|/:&-\\(|/:B-\\)|/:<@|/:@>|/::-O|/:>-\\||/:P-\\(|/::'\\||/:X-\\)|/::\\*|/:@x|/:8\\*|/:pd|/:<W>|/:beer|/:basketb|/:oo|/:coffee|/:eat|/:pig|/:rose|/:fade|/:showlove|/:heart|/:break|/:cake|/:li|/:bome|/:kn|/:footb|/:ladybug|/:shit|/:moon|/:sun|/:gift|/:hug|/:strong|/:weak|/:share|/:v|/:@\\)|/:jj|/:@@|/:bad|/:lvu|/:no|/:ok|/:love|/:<L>|/:jump|/:shake|/:<O>|/:circle|/:kotow|/:turn|/:skip|/:oY|/:#-0|/:hiphot|/:kiss|/:<&|/:&>";
    NSRegularExpression *exp_emoji =
    [[NSRegularExpression alloc] initWithPattern:regex_emoji
                                          options:NSRegularExpressionCaseInsensitive | NSRegularExpressionDotMatchesLineSeparators
                                            error:nil] ;
    NSArray *emojis = [exp_emoji matchesInString:self 
                                         options:NSRegularExpressionCaseInsensitive | NSRegularExpressionDotMatchesLineSeparators
                                           range:NSMakeRange(0, [self  length])];
    
    NSMutableAttributedString *newStr = [[NSMutableAttributedString alloc] init];
    NSUInteger location = 0;
    for (NSTextCheckingResult *result in emojis) {
        NSRange range = result.range;
        NSString *subStr = [self  substringWithRange:NSMakeRange(location, range.location - location)];
        NSMutableAttributedString *attSubStr = [[NSMutableAttributedString alloc] initWithString:subStr] ;
        [newStr appendAttributedString:attSubStr];
        
        location = range.location + range.length;
        NSString *emojiKey = [self  substringWithRange:range];
        NSString *imageName = [WeiXinEmojiDictionary() objectForKey:emojiKey];
        if (imageName) {
            // 这里不用空格，空格有个问题就是连续空格的时候只显示在一行
            NSMutableAttributedString *replaceStr = [[NSMutableAttributedString alloc] initWithString:@"-"] ;
            NSRange __range = NSMakeRange([newStr length], 1);
            [newStr appendAttributedString:replaceStr];
            
            // 定义回调函数
            CTRunDelegateCallbacks callbacks;
            callbacks.version = kCTRunDelegateVersion1;
            callbacks.getAscent = ascentCallback;
            callbacks.getDescent = descentCallback;
            callbacks.getWidth = widthCallback;
            callbacks.dealloc = deallocCallback;
            
            // 这里设置下需要绘制的图片的大小，这里我自定义了一个结构体以便于存储数据
            CustomGlyphMetricsRef metrics = malloc(sizeof(CustomGlyphMetrics));
            metrics->ascent = 11;
            metrics->descent = 4;
            metrics->width = 14;
            CTRunDelegateRef delegate = CTRunDelegateCreate(&callbacks, metrics);
            [newStr addAttribute:(NSString *)kCTRunDelegateAttributeName
                           value:(__bridge id)delegate
                           range:__range];
            CFRelease(delegate);
            
            // 设置自定义属性，绘制的时候需要用到
            [newStr addAttribute:kCustomGlyphAttributeType
                           value:[NSNumber numberWithInt:CustomGlyphAttributeImage]
                           range:__range];
            [newStr addAttribute:kCustomGlyphAttributeImageName
                           value:imageName
                           range:__range];
        } else {
            NSString *rSubStr = [self  substringWithRange:range];
            NSMutableAttributedString *originalStr = [[NSMutableAttributedString alloc] initWithString:rSubStr];
            [newStr appendAttributedString:originalStr];
        }
    }
    
    if (location < [self  length]) {
        NSRange range = NSMakeRange(location, [self  length] - location);
        NSString *subStr = [self  substringWithRange:range];
        NSMutableAttributedString *attSubStr = [[NSMutableAttributedString alloc] initWithString:subStr] ;
        [newStr appendAttributedString:attSubStr];
    }
    return newStr;
}

//这里是匹配微博
- (NSMutableAttributedString *)transformText
{
    
    
    //covertedToHalf
    // 匹配emoji
    NSString *regex_emoji = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
    NSRegularExpression *exp_emoji = 
    [[NSRegularExpression alloc] initWithPattern:regex_emoji
                                         options:NSRegularExpressionCaseInsensitive | NSRegularExpressionDotMatchesLineSeparators
                                           error:nil] ;
    NSArray *emojis = [exp_emoji matchesInString:self  
                                         options:NSRegularExpressionCaseInsensitive | NSRegularExpressionDotMatchesLineSeparators
                                           range:NSMakeRange(0, [self  length])];
    
    NSMutableAttributedString *newStr = [[NSMutableAttributedString alloc] init] ;
    NSUInteger location = 0;
    NSArray * temp = [SinaEmojiDictionary() objectForKey:@"emoticon_group_emoticons"];
    
    for (NSTextCheckingResult *result in emojis) {
        NSRange range = result.range;
        NSString *subStr = [self  substringWithRange:NSMakeRange(location, range.location - location)];
        NSMutableAttributedString *attSubStr = [[NSMutableAttributedString alloc] initWithString:subStr] ;
        [newStr appendAttributedString:attSubStr];
        
        location = range.location + range.length;
        
        NSString *emojiKey = [self  substringWithRange:range];
        
        NSString *imageName = nil;
        for (NSDictionary * tempD in temp) {
            if([[tempD objectForKey:@"chs"] isEqualToString:emojiKey]){
                imageName = [tempD objectForKey:@"png"];
                break;
            }
        }
    //    NSLog(@"emojiKey:%@ and imageName:%@",emojiKey,imageName);
        if (imageName) {
            // 这里不用空格，空格有个问题就是连续空格的时候只显示在一行
            NSMutableAttributedString *replaceStr = [[NSMutableAttributedString alloc] initWithString:@"-"];
            NSRange __range = NSMakeRange([newStr length], 1);
            [newStr appendAttributedString:replaceStr];
            
            // 定义回调函数
            CTRunDelegateCallbacks callbacks;
            callbacks.version = kCTRunDelegateVersion1;
            callbacks.getAscent = ascentCallback;
            callbacks.getDescent = descentCallback;
            callbacks.getWidth = widthCallback;
            callbacks.dealloc = deallocCallback;
            
            // 这里设置下需要绘制的图片的大小，这里我自定义了一个结构体以便于存储数据
            CustomGlyphMetricsRef metrics = malloc(sizeof(CustomGlyphMetrics));
            metrics->ascent = 11;
            metrics->descent = 4;
            metrics->width = 14;
            CTRunDelegateRef delegate = CTRunDelegateCreate(&callbacks, metrics);
            [newStr addAttribute:(NSString *)kCTRunDelegateAttributeName 
                           value:(__bridge id)delegate 
                           range:__range];
            CFRelease(delegate);
            
            // 设置自定义属性，绘制的时候需要用到
            [newStr addAttribute:kCustomGlyphAttributeType 
                           value:[NSNumber numberWithInt:CustomGlyphAttributeImage] 
                           range:__range];
            [newStr addAttribute:kCustomGlyphAttributeImageName 
                           value:imageName
                           range:__range];
        } else {
            NSString *rSubStr = [self  substringWithRange:range];
            NSMutableAttributedString *originalStr = [[NSMutableAttributedString alloc] initWithString:rSubStr];
            [newStr appendAttributedString:originalStr];
        }
    }
    
    if (location < [self  length]) {
        NSRange range = NSMakeRange(location, [self  length] - location);
        NSString *subStr = [self  substringWithRange:range];
        NSMutableAttributedString *attSubStr = [[NSMutableAttributedString alloc] initWithString:subStr] ;
        [newStr appendAttributedString:attSubStr];
    }
    
    // 话题匹配
    NSString *__newStr = [newStr string];
    NSString *regex_Topic = @"#([^\\#|.]+)#";
    NSRegularExpression *exp_Topic =
    [[NSRegularExpression alloc] initWithPattern:regex_Topic
                                         options:NSRegularExpressionCaseInsensitive | NSRegularExpressionDotMatchesLineSeparators
                                           error:nil];
    NSArray *topics = [exp_Topic matchesInString:__newStr
                                       options:NSRegularExpressionCaseInsensitive | NSRegularExpressionDotMatchesLineSeparators 
                                         range:NSMakeRange(0, [__newStr length])];
    
    for (NSTextCheckingResult *result in topics) {
        NSRange _range = [result range];
        
        // 设置自定义属性，绘制的时候需要用到
        [newStr addAttribute:kCustomGlyphAttributeType
                       value:[NSNumber numberWithInt:CustomGlyphAttributeTopic]
                       range:_range];
        [newStr addAttribute:kCustomGlyphAttributeRange 
                       value:[NSValue valueWithRange:_range] 
                       range:_range];
        [newStr addAttribute:NSForegroundColorAttributeName
                       value:[UIColor blueColor]
                       range:_range];
    }
    
    

    // 匹配短链接
    NSString *___newStr = [newStr string];
    NSString *regex_http = @"http://t.cn/[a-zA-Z0-9]+";// 短链接的算法是固定的，格式比较一致，所以比较好匹配
    NSRegularExpression *exp_http =
    [[NSRegularExpression alloc] initWithPattern:regex_http
                                         options:NSRegularExpressionCaseInsensitive | NSRegularExpressionDotMatchesLineSeparators
                                           error:nil];
    NSArray *https = [exp_http matchesInString:___newStr
                                       options:NSRegularExpressionCaseInsensitive | NSRegularExpressionDotMatchesLineSeparators
                                         range:NSMakeRange(0, [__newStr length])];
    
    for (NSTextCheckingResult *result in https) {
        NSRange _range = [result range];
        
       
        [newStr addAttribute:kCustomGlyphAttributeType
                       value:[NSNumber numberWithInt:CustomGlyphAttributeURL]
                       range:_range];
        [newStr addAttribute:kCustomGlyphAttributeRange
                       value:[NSValue valueWithRange:_range]
                       range:_range];
        [newStr addAttribute:NSForegroundColorAttributeName
                       value:[UIColor blueColor]
                       range:_range];
    }

    //匹配@**
    NSString *____newStr = [newStr string];
    NSString *regex_At = @"@[a-zA-Z0-9|a-zA-Z0-9\\u4e00-\\u9fa5]+";// 短链接的算法是固定的，格式比较一致，所以比较好匹配
    NSRegularExpression *exp_At =
    [[NSRegularExpression alloc] initWithPattern:regex_At
                                         options:NSRegularExpressionCaseInsensitive | NSRegularExpressionDotMatchesLineSeparators
                                           error:nil];
    NSArray *Ats = [exp_At matchesInString:____newStr
                                       options:NSRegularExpressionCaseInsensitive | NSRegularExpressionDotMatchesLineSeparators
                                         range:NSMakeRange(0, [__newStr length])];
    
    for (NSTextCheckingResult *result in Ats) {
        NSRange _range = [result range];
        
        
        [newStr addAttribute:kCustomGlyphAttributeType
                       value:[NSNumber numberWithInt:CustomGlyphAttributeAt]
                       range:_range];
        [newStr addAttribute:kCustomGlyphAttributeRange
                       value:[NSValue valueWithRange:_range]
                       range:_range];
        [newStr addAttribute:NSForegroundColorAttributeName
                       value:[UIColor blueColor]
                       range:_range];
    }

    
    
    return newStr;
}

@end
