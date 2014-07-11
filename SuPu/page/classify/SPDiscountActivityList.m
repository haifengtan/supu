//
//  SPDiscountActivityList.m
//  SuPu
//
//  Created by cc on 12-11-7.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPDiscountActivityList.h"
#import "SPDiscountActivity.h"
#import "UIImageView+WebCache.h"

@interface SPDiscountActivityList ()

@property (retain, nonatomic) UITableView *discountactivityview;
@property BOOL isPad;

@end

@implementation SPDiscountActivityList
@synthesize discountactivityarr;
@synthesize discountactivityview;
@synthesize isPad;

- (void)dealloc
{
    [discountactivityarr release];
    [discountactivityview release];
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
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.isPad = iPad;
    
    self.title = @"可享受优惠活动";
    self.UMStr =@"可享受优惠活动";
    
    [self setLeftBarButton:@"返回" backgroundimagename:@"返回按钮.png" target:self action:nil];
    
    UIImageView *backgroundview = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backgroundview.image = [UIImage imageNamed:@"背景.jpg"];
    [self.view addSubview:backgroundview];
    [backgroundview release];
    
    if (isPad) {
        discountactivityview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 768, self.view.bounds.size.height-139) style:UITableViewStyleGrouped];
    }else{
        discountactivityview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.bounds.size.height-90) style:UITableViewStyleGrouped];
    }
    discountactivityview.dataSource = self;
    discountactivityview.delegate = self;
    [self.view addSubview:discountactivityview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 表格的代理和数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.discountactivityarr.count;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPDiscountActivity *spda = [self.discountactivityarr objectAtIndex:indexPath.row];
    if (isPad) {
        CGSize namesize = [spda.Name sizeWithFont:[UIFont boldSystemFontOfSize:24] constrainedToSize:CGSizeMake(500, HUGE_VAL) lineBreakMode:UILineBreakModeWordWrap];
        return namesize.height+10+190;
    }else{
        CGSize namesize = [spda.Name sizeWithFont:[UIFont boldSystemFontOfSize:16] constrainedToSize:CGSizeMake(250, HUGE_VAL) lineBreakMode:UILineBreakModeWordWrap];
        return namesize.height+10+95;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellidentify = @"discountviewcell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentify];
    SPDiscountActivity *spda = [self.discountactivityarr objectAtIndex:indexPath.row];
    CGSize namesize;
    if (isPad) {
        namesize = [spda.Name sizeWithFont:[UIFont boldSystemFontOfSize:24] constrainedToSize:CGSizeMake(500, HUGE_VAL) lineBreakMode:UILineBreakModeWordWrap];
    }else{
        namesize = [spda.Name sizeWithFont:[UIFont boldSystemFontOfSize:16] constrainedToSize:CGSizeMake(250, HUGE_VAL) lineBreakMode:UILineBreakModeWordWrap];
    }
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentify] autorelease];
        UIImageView *activitypict = nil;
        if (isPad) {
            activitypict = [[UIImageView alloc] initWithFrame:CGRectMake(50, namesize.height+20, 568, 170)];
        }else{
            activitypict = [[UIImageView alloc] initWithFrame:CGRectMake(8, namesize.height+10, 284, 90)];
        }
        [cell.contentView addSubview:activitypict];
        [activitypict release];
        
        UILabel *namelabel = [[UILabel alloc] init];
        namelabel.backgroundColor = [UIColor clearColor];
        if (isPad) {
            [namelabel setFont:[UIFont boldSystemFontOfSize:24]];
        }else{
            [namelabel setFont:[UIFont boldSystemFontOfSize:16]];
        }
        namelabel.numberOfLines = 0;
        namelabel.lineBreakMode = UILineBreakModeWordWrap;
        namelabel.textAlignment = UITextAlignmentCenter;
        [cell.contentView addSubview:namelabel];
        [namelabel release];
    }
    NSURL *activityurl = [NSURL URLWithString:spda.ActivityImage];
//    if (iPad) {
//        [((UIImageView *)[[cell.contentView subviews] objectAtIndex:0]) setImageWithURL:activityurl placeholderImage:[UIImage imageNamed:@"768-240.png"]];
//    }else{
//        [((UIImageView *)[[cell.contentView subviews] objectAtIndex:0]) setImageWithURL:activityurl placeholderImage:[UIImage imageNamed:@"320-123.png"]];
//    }
    if (iPad) {
        [((UIImageView *)[[cell.contentView subviews] objectAtIndex:0]) setImageWithURL:activityurl placeholderImage:[UIImage imageNamed:@"默认活动图片1536-286.jpg"]];
    }else{
        [((UIImageView *)[[cell.contentView subviews] objectAtIndex:0]) setImageWithURL:activityurl placeholderImage:[UIImage imageNamed:@"默认活动图片640-126.jpg"]];
    }

    
    if (isPad) {
        ((UILabel *)[[cell.contentView subviews] objectAtIndex:1]).frame = CGRectMake(84, 10, 500, namesize.height);
    }else{
        ((UILabel *)[[cell.contentView subviews] objectAtIndex:1]).frame = CGRectMake(25, 5, 250, namesize.height);
    }
    ((UILabel *)[[cell.contentView subviews] objectAtIndex:1]).text = spda.Name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//可以让选中的行瞬间不选中，从而实现一闪的效果
    SPDiscountActivity *spda = [self.discountactivityarr objectAtIndex:indexPath.row];
    [Go2PageUtility go2HomeActivityGoodsList:spda.Id from:self];
    
}

@end
