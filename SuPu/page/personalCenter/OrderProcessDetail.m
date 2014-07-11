//
//  OrderProcessDetail.m
//  SuPu
//
//  Created by cc on 12-11-6.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "OrderProcessDetail.h"

@interface OrderProcessDetail ()

@property (retain, nonatomic) NSMutableString *processstr;

@end

@implementation OrderProcessDetail
@synthesize processarr;
@synthesize processstr;

- (void)dealloc
{
    [processarr release];
    [processstr release];
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
	
    self.title = @"物流详情";
    self.UMStr =@"物流详情";
    
    [self setLeftBarButton:@"返回" backgroundimagename:@"返回按钮.png" target:self action:nil];
    
    UITableView *processtableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-50) style:UITableViewStyleGrouped];
    processtableview.delegate = self;
    processtableview.dataSource = self;
    [self.view addSubview:processtableview];
    [processtableview release];
    
    processstr = [[NSMutableString alloc] init];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy:MM:dd HH:mm:ss"];
    if (processarr.count != 0) {
        for (NSDictionary *processdict in processarr) {
            if (processdict.count == 0) {
                 self.processstr = [NSMutableString stringWithFormat:@"无数据"];
            }else{
                NSDate *time = [NSDate dateWithTimeIntervalSince1970:((NSString *)[processdict objectForKey:@"Time"]).doubleValue];
                [processstr appendFormat:@"%@\n",[formatter stringFromDate:time]];
                [processstr appendFormat:@"%@\n\n\n",[processdict objectForKey:@"Note"]];
            }
        }
    }else{
       self.processstr = [NSMutableString stringWithFormat:@"无数据"];
    }
    [formatter release];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize cgsize = [self.processstr sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(280, HUGE_VAL) lineBreakMode:UILineBreakModeWordWrap];
    return cgsize.height+30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellidentify = @"cellidentify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentify];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentify] autorelease];
        CGSize cgsize = [self.processstr sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(280, HUGE_VAL) lineBreakMode:UILineBreakModeWordWrap];
        UITextView *processlabel = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, 280, cgsize.height+10)];
        processlabel.backgroundColor = [UIColor clearColor];
        [processlabel setFont:[UIFont systemFontOfSize:14]];
        processlabel.scrollEnabled = NO;
        processlabel.editable = NO;
        [cell.contentView addSubview:processlabel];
        [processlabel release];
    }
    ((UITextView *)[[cell.contentView subviews] objectAtIndex:0]).text = self.processstr;
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
