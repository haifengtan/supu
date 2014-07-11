//
//  InterFaceTestBasic.h
//  SuPu
//
//  Created by 鑫 金 on 12-9-26.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TestInterFaceProtocal.h"

@interface InterFaceTestBasic : NSObject

@property (retain, nonatomic) id <InterFaceTestProtocal> homedelegate;

- (void)testInterFace;

@end
