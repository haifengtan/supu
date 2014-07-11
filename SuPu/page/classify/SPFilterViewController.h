//
//  SPFilterViewController.h
//  SuPu
//
//  Created by xiexu on 12-11-6.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseViewController.h"
#import "SPFilterTableCell.h"
/**
 委托用于筛选页面的参数传递
 pram: filterData 筛选数据对象
 */
@protocol SPProductFilterDelegate <NSObject>
-(void)receiveFilterData:(NSMutableDictionary*)userFilterData;

@end

@interface SPFilterViewController : SPBaseViewController<SPFilterTableCellDelegate>

@property (retain, nonatomic) IBOutlet UITableView *m_tableView;
@property(nonatomic,assign)id<SPProductFilterDelegate> m_delegate_filter;
@property(nonatomic,retain)NSMutableDictionary *m_dict_filterData;
@property(nonatomic,retain)NSArray *m_array_keys;
@property(nonatomic,retain)NSMutableDictionary *m_dict_userFilterData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withFilterDict:(NSMutableDictionary*)filterDict;
-(IBAction)saveFilterData;
-(IBAction)cancleFilter;

@end
