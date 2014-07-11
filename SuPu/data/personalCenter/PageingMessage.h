//
//  PageingMessage.h
//  SuPu
//
//  Created by 鑫 金 on 12-10-19.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PageingMessage : NSObject

@property (retain, nonatomic) NSString *PageIndex;
@property (retain, nonatomic) NSString *PageSize;
@property (retain, nonatomic) NSString *RecordCount;

@end
