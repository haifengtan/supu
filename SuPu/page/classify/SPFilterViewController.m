//
//  SPFilterViewController.m
//  SuPu
//
//  Created by xiexu on 12-11-6.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPFilterViewController.h"
#import "SPFilterTableCell.h"

#define COLUMN_HEIGHT 6
#define BUTTON_HEIGHT 40
#define BUTTON_SPACE 12

#define COLUMN_PAD_HEIGHT 22
#define BUTTON_PAD_HEIGHT 54
#define BUTTON_PAD_SPACE 18

@interface SPFilterViewController ()

@property BOOL isPad;

@end

@implementation SPFilterViewController
@synthesize m_tableView;
@synthesize m_array_keys;
@synthesize m_delegate_filter;
@synthesize m_dict_filterData;
@synthesize m_dict_userFilterData;
@synthesize isPad;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withFilterDict:(NSMutableDictionary*)filterDict
{
    self.isPad = iPad;
    if (self.isPad) {
        self = [super initWithNibName:@"SPFilterPadViewController" bundle:nibBundleOrNil];
    }else{
        self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    }
    if (self) {
        self.m_dict_filterData=filterDict;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"筛选";
    self.UMStr =@"筛选";
    //初始化key条件数据
    self.m_array_keys=[self.m_dict_filterData allKeys];
    //初始化用户m_dict_userFilterData
    self.m_dict_userFilterData=[NSMutableDictionary dictionaryWithCapacity:0];
    for (int i=0; i<[self.m_array_keys count]; i++) {
        NSString *currKey=[self.m_array_keys objectAtIndex:i];
		NSArray *userFilterDataArray=[self.m_dict_filterData valueForKey:currKey];
		if (userFilterDataArray!=nil&&[userFilterDataArray count]>0) {
            SPFilterItemData *tempData=[[SPFilterItemData alloc] init];
            tempData.mid=@"";
            tempData.mcontent=@"";
            tempData.mname=[[userFilterDataArray objectAtIndex:0] mname];
            [self.m_dict_userFilterData setObject:tempData forKey:currKey];
            [tempData release];
        }
    }
	[self.m_tableView reloadData];
    
    [self setRightBarButton:@"完成" backgroundimagename:@"顶部登录按钮.png" target:self action:@selector(saveFilterData)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc {
    [m_tableView release];
    OUOSafeRelease(m_array_keys);
    OUOSafeRelease(m_dict_filterData);
    OUOSafeRelease(m_dict_userFilterData);
    m_delegate_filter=nil;
    [super dealloc];
}
- (void)viewDidUnload {
    [self setM_tableView:nil];
    [super viewDidUnload];
}

#pragma -
#pragma mark 保存筛选数据相关
//保存并传递筛选数据
-(IBAction)saveFilterData{
    //回调代理方法，传递筛选数值
    if (m_dict_userFilterData!=nil) {
        if ([m_delegate_filter respondsToSelector:@selector(receiveFilterData:)]) {
            [m_delegate_filter receiveFilterData:m_dict_userFilterData];
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}
//取消筛选
-(IBAction)cancleFilter{
    
}

- (void)ChangeConditionWithFilterOptionData:(SPFilterItemData *)filterOptionData isTapBtn:(BOOL)isTapBtn{
	[m_dict_userFilterData setObject:filterOptionData forKey:filterOptionData.mdisplayName];
    if (isTapBtn == YES) {
       
        [self.m_tableView reloadData];
    }
}
#pragma -
#pragma mark TableViewDelegate & TableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    int row=[indexPath row];
    NSString *currKey=[self.m_array_keys objectAtIndex:row];
	NSArray *currArray=[self.m_dict_filterData valueForKey:currKey];
    //利用下面这个循环，计算出实际的按钮数量
    int j=0;
    for (int i=0; i<[currArray count]; i++)
    {
        SPFilterItemData *itemData=[currArray objectAtIndex:i];
        if (currKey !=nil && [currKey isEqualToString:@"品牌"]) {
            NSString *catagory = nil;
            NSArray *catagoryArray=[self.m_dict_filterData valueForKey:@"分类"];
            for (SPFilterItemData *sid in catagoryArray) {//获得分类被选中的
                if (sid.mselected == TRUE) {
                    catagory = sid.mid;//获得选中的品牌
                }
            }
            if (catagory!=nil && ![catagory isEqualToString:@""]) {//如果有选中值
                if ([itemData.mcatagorys rangeOfString:catagory].length<=0) {//排除掉不包含的，循环继续
                    continue;
                }
            }
        }else if(currKey !=nil && [currKey isEqualToString:@"分类"]){
            NSString *brand = nil;
            NSArray *brandArray = [self.m_dict_filterData valueForKey:@"品牌"];
            for (SPFilterItemData *sid in brandArray) {
                if (sid.mselected == TRUE) {
                    brand = sid.mcatagorys;
                }
            }
            if (brand!=nil && ![brand isEqualToString:@""]) {
                if ([brand rangeOfString:itemData.mid].length<=0) {
                    continue;
                }
            }
        }else{
            
        }
        j++;
    }
    
	CGFloat height = 0;
	if (j>0) {
		SPFilterItemData *itemData=[currArray objectAtIndex:0];
		int counts=j;
		
		if([itemData.mname isEqualToString:@"size"])
		{
			int rows = (counts + 4) / 5;
			height = 32 + BUTTON_HEIGHT * rows + COLUMN_HEIGHT * (rows + 1);
			
		}
		else
		{
            if (self.isPad) {
                int rows = (counts + 4) / 5;
                height = 54 + BUTTON_PAD_HEIGHT * rows + COLUMN_PAD_HEIGHT * (rows + 1);
            }else{
                int rows = (counts + 2) / 3;
                height = 32 + BUTTON_HEIGHT * rows + COLUMN_HEIGHT * (rows + 1);
            }
		}
		
	}
    return height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.m_array_keys count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"SPFilterTableCell";
    
    SPFilterTableCell *cell = (SPFilterTableCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
	if (cell == nil) {
        NSArray *views = nil;
        if (self.isPad) {
            views=[[NSBundle mainBundle] loadNibNamed:@"SPFilterTablePadCell" owner:self options:nil];
        }else{
            views=[[NSBundle mainBundle] loadNibNamed:@"SPFilterTableCell" owner:self options:nil];
        }
		cell=[views objectAtIndex:0];
        cell.customIdentifier = CellIdentifier;
        cell.m_delegate=self;
    }
	int row=[indexPath row];
    NSString *currKey=[self.m_array_keys objectAtIndex:row];//eg. 品牌
   
	NSArray *currArray=[self.m_dict_filterData valueForKey:currKey];
	   
	[cell setConditionTitle:currKey withSelectOption:nil];
    [cell layoutWithOptions:currArray selectedOption:currKey arraykey:self.m_dict_filterData];
	CGRect rect = cell.frame;
	rect.size.height = [self tableView:tableView heightForRowAtIndexPath:indexPath];
	cell.frame = rect;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
@end
