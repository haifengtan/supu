//
//  SPMoreViewController.m
//  SuPu
//
//  Created by xx on 12-9-17.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPMoreViewController.h"
#import "AboutSuPu.h"
#import "SuggestionToSuPu.h"
#import "VersionUpdate.h"
#import "ConfigSuPu.h"

@interface SPMoreViewController ()

@property (retain, nonatomic) NSArray *celltextarr;
@property (retain, nonatomic) NSArray *cellimagenamearr;
@property BOOL isPad;

@end

@implementation SPMoreViewController
@synthesize celltextarr;
@synthesize cellimagenamearr;
@synthesize isPad;

- (void)dealloc
{
    [celltextarr release];
    [cellimagenamearr release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self.isPad = iPad;
    if (self.isPad) {
        self = [super initWithNibName:@"SPMorePadViewController" bundle:nibBundleOrNil];
    }else{
        self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    }
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"更多";
    self.UMStr =@"更多";
    
    NSArray *arr1 = [NSArray arrayWithObjects:@"孕婴宝典",@"最近浏览", nil];
    NSArray *arr2 = [NSArray arrayWithObjects:@"设置",@"检查更新",@"意见反馈", nil];
    NSArray *arr3 = [NSArray arrayWithObjects:@"关于我们", nil];
    celltextarr = [NSArray arrayWithObjects:arr1,arr2,arr3, nil];
    NSArray *arrimage1 = [NSArray arrayWithObjects:@"孕育宝典logo",@"最近浏览logo", nil];
    NSArray *arrimage2 = [NSArray arrayWithObjects:@"设置logo",@"更新logo",@"意见反馈logo", nil];
    NSArray *arrimage3 = [NSArray arrayWithObjects:@"关于我们logo", nil];
    cellimagenamearr = [NSArray arrayWithObjects:arrimage1,arrimage2,arrimage3, nil];
    
    UIImageView *backgroundview = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backgroundview.image = [UIImage imageNamed:@"背景.jpg"];
    UITableView *moretableview = nil;
    if (self.isPad) {
        moretableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 768, self.view.bounds.size.height-144) style:UITableViewStyleGrouped];
    }else{
        moretableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.bounds.size.height) style:UITableViewStyleGrouped];
    }
    moretableview.delegate = self;
    moretableview.dataSource = self;
    moretableview.scrollEnabled = NO;
    moretableview.backgroundView = backgroundview;
    [backgroundview release];
    [self.view addSubview:moretableview];
    [moretableview release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark uitableview代理和数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.celltextarr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ((NSArray *)[self.celltextarr objectAtIndex:section]).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *text = [((NSArray *)[self.celltextarr objectAtIndex:indexPath.section]) objectAtIndex:indexPath.row];
    NSString *imagename = [((NSArray *)[self.cellimagenamearr objectAtIndex:indexPath.section]) objectAtIndex:indexPath.row];
    NSString *cellidentify = [NSString stringWithFormat:@"cell%d%d",indexPath.section,indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentify];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentify] autorelease];
        
        UIImageView *cellpic = nil;
        UIImageView *cellimageview = nil;
        UILabel *celltextlabel = nil;
        if (self.isPad) {
            cellpic = [[UIImageView alloc] initWithFrame:CGRectMake(650, 20, 14, 22)];
            cellimageview = [[UIImageView alloc] initWithFrame:CGRectMake(14, 20, 50, 50)];
            celltextlabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 30, 360, 30)];
            celltextlabel.font = [UIFont boldSystemFontOfSize:28];
        }else{
            cellpic = [[UIImageView alloc] initWithFrame:CGRectMake(280, 18, 7, 11)];
            cellimageview = [[UIImageView alloc] initWithFrame:CGRectMake(7, 10, 25, 25)];
            celltextlabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 15, 60, 15)];
            celltextlabel.font = [UIFont boldSystemFontOfSize:14];
        }
        cellpic.image = [UIImage imageNamed:@"小箭头.png"];
        [cell.contentView addSubview:cellpic];
        [cellpic release];
        
        UIImage *cellimage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imagename ofType:@"png"]];
        cellimageview.image = cellimage;
        [cell.contentView addSubview:cellimageview];
        [cellimageview release];
        
        celltextlabel.backgroundColor = [UIColor clearColor];
        celltextlabel.text = text;
        [cell.contentView addSubview:celltextlabel];
        [celltextlabel release];
    }
    return cell;
}

- (float)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.isPad) {
        return 28;
    }else{
        return 14;
    }
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isPad) {
        return 84;
    }else{
        return 44;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0 && indexPath.row == 0){//孕婴宝典
        [Go2PageUtility go2BabyBibleCategoryViewControllerFrom:self];
    }else
    if(indexPath.section == 0 && indexPath.row == 1){//浏览记录
        [Go2PageUtility go2BrowerViewController:self];
    }else
    if (indexPath.section == 1 && indexPath.row == 0) {//设置
        ConfigSuPu *csp = [[ConfigSuPu alloc] init];
        [self.navigationController pushViewController:csp animated:YES];
        [csp release];
    }else
    if (indexPath.section == 1 && indexPath.row == 1) {//版本更新
        VersionUpdate *vu = [[VersionUpdate alloc] init];
        [self.navigationController pushViewController:vu animated:YES];
        [vu release];
    }else
    if (indexPath.section == 1 && indexPath.row == 2) {//意见反馈
        SuggestionToSuPu *stp = [[SuggestionToSuPu alloc] init];
        [self.navigationController pushViewController:stp animated:YES];
        [stp release];
    }else
    if (indexPath.section == 2 && indexPath.row == 0) {//关于
        AboutSuPu *asp = [[AboutSuPu alloc] init];
        [self.navigationController pushViewController:asp animated:YES];
        [asp release];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];  
}

@end
