//
//  SPFilterTableCell.h
//  SuPu
//
//  Created by xiexu on 12-11-6.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "SPFilterButton.h"
#import <QuartzCore/QuartzCore.h>
/*
 回传给筛选界面当前用户选择的条件
 */
@protocol SPFilterTableCellDelegate
- (void)ChangeConditionWithFilterOptionData:(SPFilterItemData *)filterOptionData isTapBtn:(BOOL)isTapBtn;
@end


@interface SPFilterTableCell : UITableViewCell{
    UILabel *m_label_filterType;  //筛选类型
}
@property(nonatomic,retain)id<SPFilterTableCellDelegate> m_delegate;
@property(nonatomic,retain)NSString *customIdentifier;
@property(nonatomic,retain)IBOutlet UILabel *m_label_filterType;
-(void)setConditionTitle:(NSString *)title withSelectOption:(NSString *)selectedOption;
-(void)layoutWithOptions:(NSArray *)option selectedOption:(NSString *)selectedOption arraykey:(NSMutableDictionary *)arraykey;
-(void)HandleButtonTapped:(SPFilterButton *)button;
-(void)removeAllOptionButtonsFromCell;
-(IBAction)cancleBtnTapped:(id)sender;

@end
