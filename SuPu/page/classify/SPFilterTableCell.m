//
//  SPFilterTableCell.m
//  SuPu
//
//  Created by xiexu on 12-11-6.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPFilterTableCell.h"

@interface SPFilterTableCell ()

@end

@implementation SPFilterTableCell
@synthesize m_label_filterType;
#define COLUMN_HEIGHT 6
#define BUTTON_WIDTH 90
#define BUTTON_WIDTH_SHOE 50
#define BUTTON_HEIGHT 40
#define BUTTON_SPACE 12
#define BUTTON_X (320-(3*BUTTON_WIDTH+2*BUTTON_SPACE))/2
#define BUTTON_X_SHOE (320-(5*BUTTON_WIDTH_SHOE+4*BUTTON_SPACE))/2
#define PRICE_BUTTON_WIDTH 48
#define PRICE_BUTTON_HEIGHT 20
#define BUTTON_IMAGE_TAG 999


//BUTTON_X   BUTTON_WIDTH     BUTTON_SPACE    COLUMN_HEIGHT   BUTTON_HEIGHT
#define BUTTON_PAD_X (768-(5*BUTTON_PAD_WIDTH+4*BUTTON_PAD_SPACE))/2
#define BUTTON_PAD_WIDTH 138
#define BUTTON_PAD_SPACE 10
#define COLUMN_PAD_HEIGHT 22
#define BUTTON_PAD_HEIGHT 54

#define BtnStartTag 1000
@synthesize customIdentifier;
@synthesize m_delegate;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
    }
    return self;
}
-(void)dealloc{
    m_delegate=nil;
	[m_label_filterType release];
	[customIdentifier release];
    [super dealloc];
}
-(void)setConditionTitle:(NSString *)title withSelectOption:(NSString *)selectedOption
{
	if (!selectedOption || [selectedOption isEqualToString:@""])
	{
		selectedOption = @"全部";
	}
	self.m_label_filterType.text = [NSString stringWithFormat:@"%@:  %@", title, selectedOption];
    
}
-(void)removeAllOptionButtonsFromCell{
	for(UIView* btn in [self subviews])
	{
		if (btn.tag >= BtnStartTag)
		{
			[btn removeFromSuperview];
		}
	}
}

-(void)layoutWithOptions:(NSArray *)option selectedOption:(NSString *)selectedOption arraykey:(NSMutableDictionary *)arraykey
{
	[self removeAllOptionButtonsFromCell];
	if (option != nil) {
		SPFilterItemData *_data=[option objectAtIndex:0];
        
        if ([_data.mdisplayName isEqualToString:selectedOption]) 
        {
            for (int i=0,j=0; i<[option count]; i++)
            {
                SPFilterItemData *itemData=[option objectAtIndex:i];
                if (option.count == 1) itemData.mselected = YES;//如果整个按钮的arr只一个长度表示只一个按钮，直接让他选中.
                if (selectedOption !=nil && [selectedOption isEqualToString:@"品牌"]) {
                    NSString *catagory = nil;
                    NSArray *catagoryArray=[arraykey valueForKey:@"分类"];//当开始生成品牌的按钮时，先看看分类我们选择了哪个选项
                    for (SPFilterItemData *sid in catagoryArray) {
                        if (sid.mselected == TRUE) {
                            catagory = sid.mid;
                        }
                    }
                    if (catagory!=nil && ![catagory isEqualToString:@""]) {//如果我们选了了分类
                        if ([itemData.mcatagorys rangeOfString:catagory].length<=0) {//如果当前这个里面没有包含分类，就不再继续下面的生成过程
                            continue;
                        }
                    }
                }else if(selectedOption !=nil && [selectedOption isEqualToString:@"分类"]){
                    NSString *brand = nil;
                    NSArray *brandArray = [arraykey valueForKey:@"品牌"];
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
                
                SPFilterButton *button=[SPFilterButton buttonWithType:UIButtonTypeCustom];
            
                UIImageView *tempView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shoppingcart_defaultAddress_selectArrow.png"]];
                tempView.tag=BUTTON_IMAGE_TAG;
                [tempView setHidden:YES];
                [button addSubview:tempView];
                [tempView release];
            
                if ([_data.mname isEqualToString:@"size"])
                {
                    [button setFrame:CGRectMake(BUTTON_X_SHOE+i%j*(BUTTON_WIDTH_SHOE+BUTTON_SPACE),32+COLUMN_HEIGHT+j/5*(BUTTON_HEIGHT+COLUMN_HEIGHT), BUTTON_WIDTH_SHOE, BUTTON_HEIGHT)];
                    UIImageView *imgView=(UIImageView *)[button viewWithTag:BUTTON_IMAGE_TAG];
                    [imgView setFrame:CGRectMake(35,26,15,14)];
                }
                else
                {
                    if (iPad) {
                        [button setFrame:CGRectMake(BUTTON_PAD_X+j%5*(BUTTON_PAD_WIDTH+BUTTON_PAD_SPACE),54+COLUMN_PAD_HEIGHT+j/5*(BUTTON_PAD_HEIGHT+COLUMN_PAD_HEIGHT), BUTTON_PAD_WIDTH, BUTTON_PAD_HEIGHT)];
                    }else{
                        [button setFrame:CGRectMake(BUTTON_X+j%3*(BUTTON_WIDTH+BUTTON_SPACE),32+COLUMN_HEIGHT+j/3*(BUTTON_HEIGHT+COLUMN_HEIGHT), BUTTON_WIDTH, BUTTON_HEIGHT)];
                    }
                    UIImageView *imgView=(UIImageView *)[button viewWithTag:BUTTON_IMAGE_TAG];
                    [imgView setFrame:CGRectMake(75,26,15,14)];
                }
                //设置button圆角
//                button.layer.cornerRadius=3;
//                button.layer.borderWidth=1;
//                button.layer.borderColor=[UIColor colorWithRed:170.0/255 green:170.0/255 blue:170.0/255 alpha:1].CGColor;
//                [button setBackgroundColor:[UIColor colorWithRed:236.0/255 green:236.0/255 blue:236.0/255 alpha:236.0/255]];
                if (iPad) {
                    [button.titleLabel setFont:[UIFont systemFontOfSize:26]];
                }else{
                    [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
                }
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [button setBackgroundImage:[UIImage imageNamed:@"妈妈专区按钮.png"] forState:UIControlStateNormal];
                [button setBackgroundImage:[UIImage imageNamed:@"奶粉专区按钮.png"] forState:UIControlStateSelected];
                [button addTarget:self action:@selector(HandleButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
                
                button.m_filterItemData=itemData;
                [button setTitle:itemData.mcontent forState:UIControlStateNormal];
                
                if (itemData.mselected)
                {
                    UIImageView *imgView=(UIImageView *)[button viewWithTag:BUTTON_IMAGE_TAG];
                    [imgView setHidden:NO];
                    [button setSelected:imgView.hidden];
                    [self setConditionTitle:itemData.mdisplayName withSelectOption:itemData.mcontent];
                    [self.m_delegate ChangeConditionWithFilterOptionData:itemData isTapBtn:NO];
                }
                else
                {
                    UIImageView *imgView=(UIImageView *)[button viewWithTag:BUTTON_IMAGE_TAG];
                    [imgView setHidden:YES];
                    [button setSelected:imgView.hidden];
                }
                
                button.tag = BtnStartTag + j;
                [self addSubview:button];
                j++;
            }
        }
    }
}

- (void)HandleButtonTapped:(SPFilterButton *)button
{
	if (button.m_filterItemData.mselected)
	{
		button.m_filterItemData.mselected=NO;
		//修改图片
		UIImageView *imgView=(UIImageView *)[button viewWithTag:BUTTON_IMAGE_TAG];
		[imgView setHidden:YES];
        [button setSelected:imgView.hidden];
		[self setConditionTitle:button.m_filterItemData.mdisplayName withSelectOption:nil];
        
        SPFilterItemData *data=[[SPFilterItemData alloc] init];
        data.mname=button.m_filterItemData.mname;
        data.mdisplayName=button.m_filterItemData.mdisplayName;
        data.mcontent=@"";
        data.mid=@"";
        data.mselected=NO;
        [self.m_delegate ChangeConditionWithFilterOptionData:data isTapBtn:YES];
        [data release];
	}
	else
	{
		for(SPFilterButton * btn in [self subviews])
		{
			if (btn.tag >= BtnStartTag && btn.m_filterItemData.mselected)
			{
				btn.m_filterItemData.mselected = NO;
				//修改图片
				UIImageView *imgView=(UIImageView *)[btn viewWithTag:BUTTON_IMAGE_TAG];
				[imgView setHidden:YES];
                [btn setSelected:imgView.hidden];
			}
		}
		
		button.m_filterItemData.mselected = YES;
		UIImageView *imgView=(UIImageView *)[button viewWithTag:BUTTON_IMAGE_TAG];
		[imgView setHidden:NO];
        [button setSelected:imgView.hidden];
		[self setConditionTitle:button.m_filterItemData.mdisplayName withSelectOption:button.m_filterItemData.mcontent];
        [self.m_delegate ChangeConditionWithFilterOptionData:button.m_filterItemData isTapBtn:YES];
	}
}

-(IBAction)cancleBtnTapped:(id)sender
{
	for(SPFilterButton * btn in [self subviews])
	{
		if (btn.tag >= BtnStartTag && btn.m_filterItemData.mselected)
		{
			btn.m_filterItemData.mselected = NO;
			//修改图片
			UIImageView *imgView=(UIImageView *)[btn viewWithTag:BUTTON_IMAGE_TAG];
			[imgView setHidden:YES];
            [btn setSelected:imgView.hidden];
		}
	}
	SPFilterButton * btn = (SPFilterButton *)[self viewWithTag:BtnStartTag];
	if (btn)
	{
		[self setConditionTitle:btn.m_filterItemData.mdisplayName withSelectOption:nil];
        
        SPFilterItemData *data=[[SPFilterItemData alloc] init];
        data.mname=btn.m_filterItemData.mname;
        data.mdisplayName=btn.m_filterItemData.mdisplayName;
        data.mcontent=@"";
        data.mid=@"";
        data.mselected=NO;
        [self.m_delegate ChangeConditionWithFilterOptionData:data isTapBtn:YES];
        [data release];
	}
}

- (NSString *) reuseIdentifier {
	return self.customIdentifier;
}


@end
