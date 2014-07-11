//
//  SPClassifyViewController.h
//  SuPu
//
//  Created by xx on 12-9-17.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPBaseViewController.h"
#import "SPCategoryListAction.h"
#import "SPBrandListAction.h"

@interface SPClassifyViewController : SPBaseViewController<UITableViewDataSource,UITableViewDelegate,SPBrandListActionDelegate,SPCategoryListActionDelegate>{
    int currentPage;
    BOOL m_bool_isBrand;
}
@property (retain, nonatomic) IBOutlet UIScrollView *m_scrollView;
@property(nonatomic,retain)NSArray *m_arr_classified;
@property(nonatomic,retain)NSArray *m_arr_brands;
@property(nonatomic,retain)SPBrandListAction *m_action_brand;
@property(nonatomic,retain)SPCategoryListAction *m_action_class;
@property (retain, nonatomic) IBOutlet UIButton *m_button_category;
@property (retain, nonatomic) IBOutlet UIButton *m_button_brand;

-(void)initClassifiedScrollView;
@end
