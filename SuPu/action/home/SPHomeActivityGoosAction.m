//
//  SPHomeActivityGoosAction.m
//  SuPu
//
//  Created by cc on 12-11-9.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPHomeActivityGoosAction.h"
#import "ActivityData.h"
#import "GoodsObject.h"

@implementation SPHomeActivityGoosAction

-(id)requestDataFinish:(ASIHTTPRequest*)request
{
    NSMutableDictionary *resultdict = [[NSMutableDictionary alloc] init];
    ActivityData *ad = [JsonUtil fromSimpleJsonStrToSimpleObject:request.responseString className:[ActivityData class] keyPath:@"Data.Activity" keyPathDeep:nil];
    [resultdict setObject:ad forKey:@"ActivityData"];
    NSArray *goodsarr = [JsonUtil fromSimpleJsonStrToSimpleObject:request.responseString className:[GoodsObject class] keyPath:@"Data.GoodsList" keyPathDeep:nil];
    [resultdict setObject:goodsarr forKey:@"GoodsList"];
    return [resultdict autorelease];
}

@end
