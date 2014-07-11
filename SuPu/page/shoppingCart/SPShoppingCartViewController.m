//
//  SPShoppingCartViewController.m
//  SuPu
//
//  Created by xx on 12-9-17.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPShoppingCartViewController.h"
#import "SPBalanceAccountViewController.h"
#import "SPShopCartCell.h"
#import "UIImageView+WebCache.h"
#import "CCSStringUtility.h"
#import "SPAppDelegate.h"

@interface SPShoppingCartViewController ()

@property (assign) int shopcartcount;//购物车总共购买物品数量
@property (retain, nonatomic) UILabel *shopcartcountlabel;//显示购物车购买物品数量的label
@property (assign) float discountvalue;//购物车的折扣数
@property (retain, nonatomic) UILabel *sumamountlable;//显示总价格的label
@property (retain, nonatomic) NSMutableDictionary *numbertextvaluedict;
@property BOOL isPad;

@end

@implementation SPShoppingCartViewController
@synthesize tableView=_tableView;
@synthesize tipLabel=_tipLabel;
@synthesize clearShopCartImageView=_clearShopCartImageView;
@synthesize shopcartcount;
@synthesize shopcartcountlabel;
@synthesize sumamountlable;
@synthesize discountvalue;
@synthesize bottomlabel;
@synthesize discountlabel;
@synthesize numbertextvaluedict;
@synthesize isPad;

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.tableView=nil;
    self.tipLabel=nil;
    self.bottomlabel = nil;
    self.shopcartcountlabel=nil;
    self.sumamountlable=nil;
    self.discountlabel=nil;
    //    self.numbertextvaluedict =nil;
    //    deleGoodSN=nil;
    self.clearShopCartImageView=nil;
}

-(void)dealloc{
    [updateAction release];
    [shopCartAction release];
    [shopCartData release];
    [_clearShopCartImageView release];
    [deleGoodSN release];
    [_tipLabel release];
    [_tableView release];
    [bottomlabel release];
    [shopcartcountlabel release];
    [sumamountlable release];
    [discountlabel release];
    [numbertextvaluedict release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self.isPad = iPad;
    if (self.isPad) {
        self = [super initWithNibName:@"SPShoppingCartPadViewController" bundle:nil];
    }else{
        self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    }
    if (self) {
        
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"购物车";
    self.UMStr=@"购物车";
    barstate = NO;
    [self setLeftBarButton:@"编辑" backgroundimagename:@"barButton.png" target:self action:@selector(editTableView)];
    
    [self setRightBarButton:@"去结算" backgroundimagename:@"barButton.png" target:self action:@selector(balanceAccount:)];
    
    updateAction=[[SPUpdateShopCartAction alloc] init];
    updateAction.m_delegate_updateShopCart=self;
    
    //初始化显示总金额和总件数的label
    shopcartcountlabel = [[UILabel alloc] init];
    sumamountlable = [[UILabel alloc] init];
    if (self.isPad) {
        _tableView.rowHeight=150;
        [shopcartcountlabel setFont:[UIFont systemFontOfSize:24]];
        [sumamountlable setFont:[UIFont systemFontOfSize:24]];
    }else{
        _tableView.rowHeight=75;
        [shopcartcountlabel setFont:[UIFont systemFontOfSize:12]];
        [sumamountlable setFont:[UIFont systemFontOfSize:12]];
    }
    shopcartcountlabel.textAlignment = UITextAlignmentLeft;
    shopcartcountlabel.backgroundColor = [UIColor clearColor];
    [self.bottomlabel addSubview:shopcartcountlabel];
    sumamountlable.textColor = [UIColor redColor];
    sumamountlable.textAlignment = UITextAlignmentLeft;
    sumamountlable.backgroundColor = [UIColor clearColor];
    [self.bottomlabel addSubview:sumamountlable];
    
    self.numbertextvaluedict = [NSMutableDictionary dictionary];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     self.navigationItem.rightBarButtonItem.enabled = YES;
    if(self.tableView.editing == YES){
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }

    if ([SPStatusUtility isUserLogin]) {
        
        shopCartAction=[[SPShoppingCartAction alloc] init];
        shopCartAction.m_delegate_shopCart=self;
        [shopCartAction requestShoppingCartData];
        [self showHUD];
    }else{//假如没登陆过
        KAppDelegate.loginModelViewMotherViewName=@"SPShoppingCart";
        
        [Go2PageUtility go2LoginViewNoAnimatedControllerWithSuccessBlock:^{
            [KAppDelegate.m_tabBarCtrl selectTab:2];
            shopCartAction=[[SPShoppingCartAction alloc] init];
            shopCartAction.m_delegate_shopCart=self;
            [shopCartAction requestShoppingCartData];
            [self showHUD];
        }];
    }
}
#pragma mark -
#pragma mark -获取购物车成功的代理方法
-(void)onResponseShoppingCartDataSuccess:(SPShoppingCartData *)l_data_shopCart sumAmout:(NSString *)sum{
    [self hideHUD];
    isDelete=NO;
    if (self.entryArray) [self.entryArray removeAllObjects];
    shopCartData=[l_data_shopCart retain];
    
    [self.entryArray addObjectsFromArray:l_data_shopCart.mCartListArray];
    
    [_tableView reloadData];
    
    if ([self.entryArray count]<=0) {
        self.navigationItem.rightBarButtonItem.customView.hidden = YES;
        self.navigationItem.leftBarButtonItem.customView.hidden = YES;
    }else{
        
        self.navigationItem.rightBarButtonItem.customView.hidden = NO;
        self.navigationItem.leftBarButtonItem.customView.hidden = NO;
    }
    
    //计算总共购买的商品数量
    self.shopcartcount = 0;
    for (SPShoppingCartItemData *spscd in l_data_shopCart.mCartListArray) {
        self.shopcartcount += spscd.mCount.intValue;
    }
    if (self.shopcartcount ==0) {
        bottomlabel.hidden = YES;
        _tableView.hidden=YES;
        _tipLabel.hidden=NO;
        _clearShopCartImageView.hidden=NO;
    }else{
        bottomlabel.hidden = NO;
        _tableView.hidden=NO;
        _tipLabel.hidden=YES;
        _clearShopCartImageView.hidden=YES;
    }
    
    self.discountvalue = l_data_shopCart.mDiscountAmount.floatValue;
    self.discountlabel.text = [NSString stringWithFormat:@"￥%.2f",self.discountvalue];
    
    
    NSString *shopcartstr = [NSString stringWithFormat:@"（%d件）：",self.shopcartcount];
    CGSize shopcartstrsize;
    if (self.isPad) {
        shopcartstrsize = [shopcartstr sizeWithFont:[UIFont systemFontOfSize:24] constrainedToSize:CGSizeMake(HUGE_VAL, 44)];
        self.shopcartcountlabel.frame = CGRectMake(96, 8, shopcartstrsize.width, 44);
        self.sumamountlable.frame = CGRectMake(96+shopcartstrsize.width+10, 8, 160, 44);
    }else{
        shopcartstrsize = [shopcartstr sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(HUGE_VAL, 22)];
        self.shopcartcountlabel.frame = CGRectMake(48, 4, shopcartstrsize.width, 22);
        self.sumamountlable.frame = CGRectMake(48+shopcartstrsize.width+5, 4, 80, 22);
    }
    self.shopcartcountlabel.text = shopcartstr;
    self.sumamountlable.text = [NSString stringWithFormat:@"￥%.2f",l_data_shopCart.mSumAmount.floatValue+l_data_shopCart.mDiscountAmount.floatValue];
}
#pragma mark -
#pragma mark -获取购物车失败的代理方法
-(void)onResponseShoppingCartDataFail{
    [self hideHUD];
    isDelete=NO;
    
    [SPStatusUtility showAlert:DEFAULTTIP_TITLE message:KNETWORKERROR delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    
}
-(void)edit{
    NSLog(@"edit");
}
-(void)submit{
    [self setLeftBarButton:@"编辑" backgroundimagename:@"barButton.png" target:self action:@selector(editTableView)];
    
    barstate = NO;
    [_tableView setEditing:NO animated:YES];
 
    if (self.entryArray.count != 0) {
        [self.numbertextvaluedict removeAllObjects];
        
        [updateAction requestUpdateShopCartData];
       [self showHUD];
        
        [self performSelector:@selector(reloadDataMyTableView) withObject:self afterDelay:2.0];
        
    }
 
}

- (void)editTableView{
    
    
    self.tableView.editing = NO;
    if (barstate == NO){
        
    self.navigationItem.rightBarButtonItem.enabled = NO;
        [self setLeftBarButton:@"完成" backgroundimagename:@"barButton.png" target:self action:@selector(submit)];
        barstate = YES;
        [_tableView setEditing:YES animated:YES];
        
        [self performSelector:@selector(reloadDataMyTableView) withObject:self afterDelay:0.3];
    }else{
  
        barstate = NO;
        [_tableView setEditing:NO animated:YES];
        
        if (self.entryArray.count != 0) {
            [self.numbertextvaluedict removeAllObjects];
            
            [updateAction requestUpdateShopCartData];
            [self showHUD];
            
            [self performSelector:@selector(reloadDataMyTableView) withObject:self afterDelay:2.0];
            
        }
        
    }
    
}

-(void)reloadDataMyTableView
{
    
    [_tableView reloadData];
}


#pragma mark textfield代理

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;

}
  

-(NSDictionary *)onRequestUpdateShopCartAction{
    NSMutableDictionary *requestDic=[NSMutableDictionary dictionary];
    
    if (isDelete) {
        NSString *deleStr=[NSString stringWithFormat:@"%@:0:=",deleGoodSN];
        
        [requestDic setObject:deleStr forKey:@"goods"];
    }else{
        NSMutableDictionary *dic=[NSMutableDictionary dictionary];
        for (int i=0; i<[_entryArray count]; i++) {
            
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:i inSection:0];
            SPShopCartCell  *cell = (SPShopCartCell*)[_tableView cellForRowAtIndexPath:indexPath];
            SPShoppingCartItemData *itemData= [_entryArray objectAtIndex:i];
            
            if ([itemData.mIsGift isEqualToString:@"True"]) {
                
            }else{
                if ([cell.numberTextField.text intValue]>0)
                {
                    NSString *key=OUO_STRING_FORMAT(@"%@/%d",cell.numberTextField.text,i);
                    [dic setValue:itemData.mGoodsSN forKey:key];
                }
                else
                {
                    return nil;
                }
      
            }
            
        }
        NSString *lastStr= [CCSStringUtility  serializeGoodsStr:dic ];
        
        for (int i=0; i<[_entryArray count];i++ ) {
            
            lastStr=  [lastStr stringByReplacingOccurrencesOfString:OUO_STRING_FORMAT(@"/%d",i) withString:@""];
            
        }
        [requestDic setObject:lastStr forKey:@"goods"];
    }
    
    return  requestDic;
    
}
#pragma mark -
#pragma mark -修改购物车成功的代理方法
//修改购物车成功的代理方法
-(void)onResponseUpdateShopCartDataSuccess:(SPShoppingCartData *)l_data_UpdateShopCart sumAmount:(NSString *)sum{
    [self hideHUD];
    __block typeof(self) bself = self;
    [self performBlock:^(id sender) {
        if (barstate==NO) {
            bself.navigationItem.rightBarButtonItem.enabled = YES;
        }

    } afterDelay:1.0];

     
    if (isDelete) {
        [shopCartAction requestShoppingCartData];
        
    }else{
        NSArray *countArray=l_data_UpdateShopCart.mCartListArray;
         //内存释放 10 -----------
        NSMutableString *tips = [NSMutableString  string];
        for (int i=0; i<[countArray count];i++) {
            SPShoppingCartItemData *items=[countArray objectAtIndex:i];
            if ([items.mIsNoStock isEqualToString:@"True"]) {
                [tips appendFormat:@"%@ ， ",items.mGoodsName];
            }
        }
        if (tips.length != 0) {
            [tips appendFormat:@"库存不足"];
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:tips delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
            [alert release];
        }
        [shopCartAction requestShoppingCartData];
        
    }
}

#pragma mark -
#pragma mark -修改购物车失败的代理方法
-(void)onResponseUpdateShopCartDataFail{
    [self hideHUD];
    if (barstate==NO)
    self.navigationItem.rightBarButtonItem.enabled = YES;
    
    isDelete=NO;
}

-(void)balanceAccount:(id)sender{
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
//    __block typeof(self) bself = self;
//    [self performBlock:^(id sender) {
    
        for (SPShoppingCartItemData *item in self.entryArray) {
            if (item.mIsNoStock!= nil && [item.mIsNoStock isEqualToString:@"True"]) {
                NSString *tips=OUO_STRING_FORMAT(@"%@ 库存不足",item.mGoodsName);
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:tips delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alert show];
                [alert release];
                return;
            }
        }
        [Go2PageUtility go2blanceAccountViewController:self shopCartData:shopCartData];

//    } afterDelay:1.0];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.entryArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    SPShopCartCell  *cell = (SPShopCartCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *array = nil;
        if (self.isPad) {
            array=[[NSBundle mainBundle] loadNibNamed:@"SPShopCartPadCell" owner:self  options:nil];
        }else{
            array=[[NSBundle mainBundle] loadNibNamed:@"SPShopCartCell" owner:self  options:nil];
        }
        cell=[array objectAtIndex:0];
        cell.numberTextField.delegate =self;
    }
    
    SPShoppingCartItemData *itemData=[self.entryArray objectAtIndex:indexPath.row];
    cell.numberTextField.tag=indexPath.row+1;
    if (itemData) {
        cell.nameLabel.text =itemData.mGoodsName;
        cell.numberLabel.text=itemData.mCount;
        cell.priceLabel.text=[NSString stringWithFormat:@"￥%@",itemData.mShopPrice];
        if ([itemData.mIsGift isEqualToString:@"True"]) {
            [cell.m_label_gift setHidden:NO];
            [cell.xlabel setHidden:YES];
            [cell.priceLabel setHidden:YES];
            [cell.numberLabel setHidden:YES];
            //            [cell.thumbnails setHidden:YES];//客户要求图片要显示出来，所以将这里注释掉
        }else{
            if (barstate==YES) {
                cell.numberTextField.hidden=NO;
                cell.numberLabel.hidden=YES;
               
                cell.numberTextField.text=itemData.mCount;
               
            }
            [cell.m_label_gift setHidden:YES];
         }
        if (itemData.mIsNoStock!=nil && [itemData.mIsNoStock isEqualToString:@"True"]) {
            cell.nostocklabel.hidden = NO;
        }else{
            cell.nostocklabel.hidden = YES;
        }
        
        NSURL *url= URLImagePath(itemData.mImgFile);
        
        NSString *showpicture =  [SPStatusUtility getObjectForKey:kShowPicture];
        if (showpicture==nil ||(showpicture!=nil && [showpicture isEqualToString:@"ON"])) {
            if (itemData.mImgFile == nil || [itemData.mImgFile isEqualToString:@""]) {
                
                if (iPad) {
                    [cell.thumbnails setImage:[UIImage imageNamed:@"160-160.png"]];
                }else{
                    [cell.thumbnails setImage:[UIImage imageNamed:@"66-66.png"]];
                }
                //                [cell.thumbnails setImage:kDefaultImage];
            }else{
                
                if (iPad) {
                    [cell.thumbnails setImageWithURL:url placeholderImage:[UIImage imageNamed:@"160-160.png"]];
                }else{
                    [cell.thumbnails setImageWithURL:url placeholderImage:[UIImage imageNamed:@"66-66.png"]];
                }
                //                [cell.thumbnails setImageWithURL:url placeholderImage:kDefaultImage];
            }
        }else{
            if (iPad) {
                [cell.thumbnails setImage:[UIImage imageNamed:@"160-160.png"]];
            }else{
                [cell.thumbnails setImage:[UIImage imageNamed:@"66-66.png"]];
            }
             
        }
    }
    return cell;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    SPShoppingCartItemData *itemData=[self.entryArray objectAtIndex:indexPath.row];
    if (itemData.mIsGift != nil && [itemData.mIsGift isEqualToString:@"False"]) {
        [Go2PageUtility go2ProductDetailViewControllerWithGoodsSN:itemData.mGoodsSN from:self];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger row=indexPath.row;
    
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        
        
        SPShoppingCartItemData *itemData=[self.entryArray objectAtIndex:row];
        deleGoodSN=[itemData.mGoodsSN retain];
        
        NSArray *array=[NSArray arrayWithObjects:@"确定",nil];
        
        NSString *tips=@"删除此商品?";
         
        [UIAlertView showAlertViewWithTitle:@"" message:tips cancelButtonTitle:@"取消"  otherButtonTitles:array handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
            if (buttonIndex==1) {
//                
                
                [self.entryArray removeObjectAtIndex:row];
                isDelete=YES;
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                
                [updateAction requestUpdateShopCartData];
                if ([self.entryArray count]==0) {
                    [self setLeftBarButton:@"编辑" backgroundimagename:@"barButton.png" target:self action:@selector(editTableView)];
                }
                if (self.entryArray == nil || self.entryArray.count == 0) {
                    self.navigationItem.leftBarButtonItem.customView.hidden = YES;
                    self.navigationItem.rightBarButtonItem.customView.hidden = YES;
                    barstate = NO;
                    [_tableView setEditing:NO animated:YES];
                }
            }
        }];
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  @"删除";
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPShoppingCartItemData *itemData=[self.entryArray objectAtIndex:indexPath.row];
    if ([itemData.mIsGift isEqualToString:@"False"]) {
        return UITableViewCellEditingStyleDelete;
    }else{
        return UITableViewCellEditingStyleNone;
    }
    
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.tableView.editing == YES) {
        return YES;
    }
    
    return NO;
    
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


@end
