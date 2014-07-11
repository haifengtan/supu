//
//  SPGuidePageObject.h
//  SuPu
//
//  Created by 持创 on 13-4-2.
//  Copyright (c) 2013年 com.chichuang. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface SPPage:SPBaseData
@property (nonatomic,retain) NSMutableArray *m_pageArray;
@end

@interface SPGuidePageObject : SPBaseData
@property (nonatomic,retain)NSString *m_PicUrl;
@property (nonatomic,retain)NSString *m_BeginTime;
@property (nonatomic,retain)NSString *m_EndTime;
@end
