//
//  HomeInterFace.h
//  SuPu
//
//  Created by 鑫 金 on 12-9-25.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TestInterFaceProtocal.h"
#import "InterFaceTestUtils.h"

@interface HomeInterFace : NSObject <InterFaceTestProtocal>

@property (retain, nonatomic) TestUrlPara *urltest;
@property (retain, nonatomic) NSMutableDictionary *valuedict;

@end
