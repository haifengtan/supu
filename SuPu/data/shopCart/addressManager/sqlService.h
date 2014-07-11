//
//  sqlService.h
//  SQLite3Test
//
//  Created by fengxiao on 11-11-28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

#define kFilename  @"City.db"

@class cityList;
@interface sqlService : NSObject {
	sqlite3 *_database;

}

@property (nonatomic) sqlite3 *_database;

- (BOOL) createTestList:(sqlite3 *)db;
- (BOOL) insertTestList:(cityList *)insertList;
- (NSMutableArray*)getCityListByProvinceCode:(NSString*)scode;
- (NSString *)getCityName:(NSString*)mcode;
@end

@interface cityList : NSObject
{
	int sqlID;
    NSString *areaCode;
    NSString *areaName;
    NSString *parentID;

}

@property (nonatomic) int sqlID;
@property (nonatomic, retain)   NSString *areaCode;
@property (nonatomic, retain)   NSString *areaName;
@property (nonatomic, retain)   NSString *parentID;

@end

