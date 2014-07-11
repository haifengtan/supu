//
//  SPHomeActivityGoodsList.m
//  SuPu
//
//  Created by cc on 12-11-9.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPHomeActivityGoodsList.h"
#import "SPHomeActivityGoosAction.h"
#import "UIImageView+WebCache.h"
#import "ActivityData.h"
#import "GoodsObject.h"
#import "SPProductListTableCell.h"
#import <QuartzCore/QuartzCore.h>

@interface SPHomeActivityGoodsList ()

@property (retain, nonatomic) UITableView *activitytableview;
@property (retain, nonatomic) NSArray *goodsarr;
@property BOOL isPad;

@end

@implementation SPHomeActivityGoodsList
@synthesize activityid;
@synthesize activitytableview;
@synthesize goodsarr;
@synthesize isPad;

- (void)dealloc
{
    [activityid release];
    [activitytableview release];
    [goodsarr release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    self.isPad = iPad;
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"活动详情";
    self.UMStr = @"活动详情";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setLeftBarButton:@"返回" backgroundimagename:@"返回按钮.png" target:self action:nil];
    
    UIImageView *activityimageview = nil;
    if (self.isPad) {
        activityimageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 768, 143)];
    }else{
        activityimageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 63)];
    }
    [self.view addSubview:activityimageview];
    [activityimageview release];
    
    if (self.isPad) {
        activitytableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 143, 768, 1004-143-100-44) style:UITableViewStylePlain];
        activitytableview.rowHeight = 144;
    }else{
        activitytableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 63, 320, self.view.frameHeight - 63 - 49 - 44) style:UITableViewStylePlain];
        activitytableview.rowHeight = 75;
    }
    activitytableview.delegate = self;
    activitytableview.dataSource = self;
    [self.view addSubview:activitytableview];
    
    SPHomeActivityGoosAction *spba = [[SPHomeActivityGoosAction alloc] init];
    [spba requestData:SP_URL_GETACTIVITY methodName:SP_METHOD_GETACTIVITY createParaBlock:^NSDictionary *{
        return [NSDictionary dictionaryWithObjectsAndKeys:self.activityid,@"ActivityId", nil];
    } requestSuccessBlock:^(id resultdict) {
        NSURL *activityimageurl = [NSURL URLWithString:((ActivityData *)[resultdict objectForKey:@"ActivityData"]).ActivityImage];
        if (isPad) {
            [activityimageview setImageWithURL:activityimageurl placeholderImage:[UIImage imageNamed:@"默认活动图片1536-286.jpg"]];
        }else{
             [activityimageview setImageWithURL:activityimageurl placeholderImage:[UIImage imageNamed:@"默认活动图片640-126.jpg"]];
        }
        self.goodsarr = (NSArray *)[resultdict objectForKey:@"GoodsList"];
        [activitytableview reloadData];
    } requestFailureBlock:^(ASIHTTPRequest *request) {
        [SPStatusUtility showAlert:DEFAULTTIP_TITLE message:KNETWORKERROR delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    }];
    [spba release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 表格的数据和代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.goodsarr.count;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isPad) {
        return 144;
    }else{
        return 75;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellidentify = @"cellidentify";
    SPProductListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentify];
    if (cell == nil) {
        NSArray *cellarr = nil;
        if (self.isPad) {
            cellarr=[[NSBundle mainBundle] loadNibNamed:@"SPProductListPadTableCell" owner:nil options:nil];
        }else{
            cellarr=[[NSBundle mainBundle] loadNibNamed:@"SPProductListTableCell" owner:nil options:nil];
        }
        for (UIView *cellview in cellarr) {
            if ([cellview isKindOfClass:[SPProductListTableCell class]]) {
                cell=(SPProductListTableCell *)cellview;
            }
        }
    }
    GoodsObject *go = [self.goodsarr objectAtIndex:indexPath.row];

    NSString *showpicture =  [SPStatusUtility getObjectForKey:kShowPicture];
    if ( showpicture==nil||(showpicture!=nil && [showpicture isEqualToString:@"ON"])) {
        NSURL *imageurl = URLImagePath(go.ImgFile);
        if (iPad) {
            [cell.m_imgView_product setImageWithURL:imageurl placeholderImage:[UIImage imageNamed:@"126-126.png"]];
        }else
            [cell.m_imgView_product setImageWithURL:imageurl placeholderImage:[UIImage imageNamed:@"66-66.png"]];
    }else{
        if (iPad) {
            [cell.m_imgView_product setImage:[UIImage imageNamed:@"126-126.png"]];
        }else
            [cell.m_imgView_product setImage:[UIImage imageNamed:@"66-66.png"]];
    }
    [cell.m_imgView_product.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [cell.m_imgView_product.layer setBorderWidth:1];
    [cell.m_label_productName setText:strOrEmpty(go.GoodsName)];
    [cell.m_label_slogan setText:strOrEmpty(go.GoodsSlogan)];
    [cell.m_label_comment setText:strOrEmpty([NSString stringWithFormat:@"%@人评价",go.CommentCount])];
    if (go.IsNoStock!= nil && [go.IsNoStock isEqualToString:@"True"]) {//无库存
        [cell.m_view_noStock setHidden:NO];
        [cell.m_label_shopPrice setHidden:YES];
        [cell.m_label_noStockPrice setText:[NSString stringWithFormat:@"￥%@",strOrEmpty(go.ShopPrice)]];
    }else{
        [cell.m_view_noStock setHidden:YES];
        [cell.m_label_shopPrice setHidden:NO];
        [cell.m_label_shopPrice setText:[NSString stringWithFormat:@"￥%@",strOrEmpty(go.ShopPrice)]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GoodsObject *go=[self.goodsarr objectAtIndex:indexPath.row];
    [Go2PageUtility go2ProductDetailViewControllerWithGoodsSN:go.GoodsSN from:self];
}

@end
