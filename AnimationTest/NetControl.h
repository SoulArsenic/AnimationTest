//
//  NetControl.h
//  AnimationTest
//
//  Created by lengbinbin on 15/5/26.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^NetSucess)(NSDictionary *result);
typedef void(^NetFail)(NSDictionary *failResult);

@interface NetControl : NSObject
@property (nonatomic, strong) NSMutableDictionary * contrlSet;
+ (instancetype) defaultControl;

- (NSNumber *) requestUrl:(NSString *)url WithParameters:(NSDictionary *) parameters onSucessComplete:(NetSucess) sucess andFail:(NetFail) fail;
- (void) cancelRequestWithRidx:(NSNumber *) requestIndex;

@end
