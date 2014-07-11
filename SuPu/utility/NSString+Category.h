//
//  NSString+Category.h
//  SuPu
//
//  Created by xingyong on 13-3-15.
//  Copyright (c) 2013年 com.chichuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Category)
/** Returns a `NSString` that is URL friendly.
 @return A URL encoded string.
 */
- (NSString*) URLEncode;
@end
