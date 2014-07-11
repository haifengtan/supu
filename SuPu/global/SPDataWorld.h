//
//  SPDataWorld.h
//  SuPu
//
//  Created by xx on 12-9-24.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#define KDATAWORLD [SPDataWorld shareData]
#import <Foundation/Foundation.h>
#import "CCSHttpEngine.h"

@interface SPDataWorld : NSObject{
    CCSHttpEngine *m_spHttpEngine;
}

// 单例模式
+ (SPDataWorld*)shareData;
// 速普服务器Http请求引擎
- (CCSHttpEngine *)httpEngineSP;
@end
