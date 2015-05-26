//
//  NetControl.m
//  AnimationTest
//
//  Created by lengbinbin on 15/5/26.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import "NetControl.h"

typedef void(^InnerCallBack)(NSInteger current);

@interface NetItem : NSObject
@property (nonatomic, copy) InnerCallBack call;
@property (nonatomic, copy) NSString * url;
@property (nonatomic, strong) NSDictionary * parameters;
@property (nonatomic, copy) NetSucess sucess;
@property (nonatomic, copy) NetFail fail;
@property (nonatomic, assign) NSInteger index;

+ (NetItem *) itemWithUrl:(NSString * )url andParameters:(NSDictionary *)parameters andSuccess:(NetSucess)sucell andFail:(NetFail)fail andIndex:(NSInteger) index WithInner:(InnerCallBack) call;

@end

@implementation NetItem

+(NetItem *)itemWithUrl:(NSString *)url andParameters:(NSDictionary *)parameters andSuccess:(NetSucess)sucess andFail:(NetFail)fail andIndex:(NSInteger)index WithInner:(InnerCallBack) call{

    NetItem * item = [[NetItem alloc] init];
    item.url = url;
    item.parameters = parameters;
    item.sucess = sucess;
    item.fail = fail;
    item.index = index;
    item.call = call;
    
    [item performSelector:@selector(oncomplete) withObject:nil afterDelay:2];
    
    return item;
}


#pragma mark 单条请求处理


- (void) oncomplete{
    
    self.call(self.index);
    
    if (self.sucess) {
        self.sucess([NSDictionary dictionary]);
    }
}

@end








#pragma -mark

static NetControl * myControl = nil;
static NSInteger currentRequest = 0;
@implementation NetControl


+(instancetype)defaultControl{
    static dispatch_once_t a;
    dispatch_once(&a, ^{
        myControl = [[NetControl alloc] init];
        myControl.contrlSet = [NSMutableDictionary dictionary];
    });
    return myControl;
}



-(NSNumber *)requestUrl:(NSString *)url WithParameters:(NSDictionary *)parameters onSucessComplete:(NetSucess) sucess andFail:(NetFail) fail{
    
    currentRequest ++;
    NetItem* item =  [NetItem itemWithUrl:url andParameters:parameters andSuccess:sucess andFail:fail andIndex:currentRequest WithInner:^(NSInteger current){
        [self cancelRequestWithRidx:[NSNumber numberWithLong:current]];
    }];
    [self.contrlSet setObject:item forKey:[NSNumber numberWithLong:currentRequest]];
    return [NSNumber numberWithLong:currentRequest];
}

- (void)cancelRequestWithRidx:(NSNumber *)requestIndex{
    
    NetItem * item = [self.contrlSet objectForKey:requestIndex];
    
    if (item) {
    
        
        
        [self.contrlSet removeObjectForKey:requestIndex];
    }
    
}

@end
