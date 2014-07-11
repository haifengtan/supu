//
//  SPBaseViewController.h
//  SuPu
//
//  Created by xx on 12-9-17.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MobClick.h"
@interface SPBaseViewController : UIViewController{
    NSMutableArray *_entryArray;
}
/**
 *	@brief	友盟统计
 *
 *	根据字符串标示
 */
@property (retain, nonatomic) NSString *UMStr;

@property(nonatomic,retain)NSMutableArray *entryArray;
@property(nonatomic,retain)NSString *m_str_noresultText;
@property(nonatomic,retain)UIView *emptyView;

@property(nonatomic,retain)NSString *emptyMessage;

- (void)setLeftBarButton:(NSString *)title backgroundimagename:(NSString *)backgroundimagename target:(id)target action:(SEL)action;

- (void)setRightBarButton:(NSString *)title backgroundimagename:(NSString *)backgroundimagename target:(id)target action:(SEL)action;

- (void)setLeftBarButtonWithTitle:(NSString *)title handler:(void(^)(id sender))handler;
- (void)setRightBarButtonWithTitle:(NSString *)title handler:(void(^)(id sender))handler;

- (NSString *)getMemberId:(NSString *)key;

@end
