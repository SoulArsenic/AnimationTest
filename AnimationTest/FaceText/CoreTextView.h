//
//  CoreTextView.h
//  TEST_ATTR_002
//
//  Created by cxjwin on 13-7-29.
//  Copyright (c) 2013年 cxjwin. All rights reserved.
//

#import <CoreText/CoreText.h>
#import <UIKit/UIKit.h>
#import "NSString+Weibo.h"

//补充
typedef void(^CoreTextCallBack)(NSString * str,CustomGlyphAttributeType type);

@protocol CoreTextViewDelegate <NSObject>
@optional
- (void)touchedURLWithURLStr:(NSString *)urlStr andType:(CustomGlyphAttributeType) type;
@end

@interface CoreTextView : UIView

@property (weak, nonatomic) id<CoreTextViewDelegate> delegate;

@property (copy, nonatomic) NSMutableAttributedString *attributedString;
@property (nonatomic) CGFloat adjustWidth;
@property (nonatomic) CGSize adjustSize;
//补充
@property (copy, nonatomic) CoreTextCallBack callBack;
@property (copy, nonatomic) NSString * stringTemp;
@property (assign) BOOL shouldStartJudge;
- (void)updateFrameWithAttributedString;
inline Boolean CFRangesIntersect(CFRange range1, CFRange range2);

@end