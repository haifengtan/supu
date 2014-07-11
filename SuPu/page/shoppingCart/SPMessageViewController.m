//
//  SPMessageViewController.m
//  SuPu
//
//  Created by 邢 勇 on 12-10-24.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "SPMessageViewController.h"
#import "SPBalanceAccountViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface SPMessageViewController ()

@property BOOL isPad;

@end

@implementation SPMessageViewController
@synthesize textView=_textView;
@synthesize calLabel=_calLabel;
@synthesize remark=_remark;
@synthesize isPad;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self.isPad = iPad;
    if (self.isPad) {
        self = [super initWithNibName:@"SPMessagePadViewController" bundle:nibBundleOrNil];
    }else{
        self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    }
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{   
    [super viewDidLoad];
    
    _textView.delegate=self;
    _textView.layer.cornerRadius = 10;//调节圆角的大小，数值越大，圆角的拐弯越大
    _textView.layer.masksToBounds = YES;
    _textView.layer.borderColor = [[UIColor colorWithRed:0.67 green:0.67 blue:0.67 alpha:1.00] CGColor];
    _textView.layer.borderWidth = 1;
    _textView.text = _remark;
    
    [_textView becomeFirstResponder];
    
    [self setLeftBarButton:@"返回" backgroundimagename:@"返回按钮.png" target:self action:@selector(backtobalance:)];
    
    self.title=@"留 言";
    self.UMStr=@"留 言";
    // Do any additional setup after loading the view from its nib.
}
- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length>200) {
        textView.text = [textView.text substringWithRange:NSMakeRange(0, 200)];
    }
    _calLabel.slabelContent=textView.text;
}

- (void)backtobalance:(id)sender
{
    int count = [self.navigationController viewControllers].count;
    SPBalanceAccountViewController *spbavc = [[self.navigationController viewControllers] objectAtIndex:count-2];
    spbavc.remark = _textView.text;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:7];
    UITableViewCell *cell = [spbavc.tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"留  言：%@",spbavc.remark];
    [self.navigationController popViewControllerAnimated:YES];
}

/*
 
 -(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
 NSString *trimStr=[searchBar.text stringByTrimmingWhitespaces];
 BOOL isVaild= [trimStr isFilled];
 if (isVaild && [self isAvaild:searchBar.text]) {
 [searchBar resignFirstResponder];
 [[self.view viewWithTag:ControlTag] removeFromSuperview];
 [Go2PageUtility go2SpecificProductDetailsViewController:self productKeyword:searchBar.text categoryCode:nil brandCode:nil withTitle:nil];
 searchBar.text=nil;
 }else{
 
 UIAlertView *al=[[UIAlertView alloc] initWithTitle:nil message:@"输入格式错误" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
 [al show];
 [al release];
 }
 
 }
 -(BOOL)isAvaild:(NSString *)str{
 
 NSRange range = [str rangeOfString:@"%"];
 
 if (range.location!=NSNotFound) return NO;
 
 return YES;
 }
 */
-(void)viewDidUnload{
    [super viewDidUnload];
    self.calLabel=nil;
    self.textView=nil;
//    self.remark=nil;
}
-(void)dealloc{
    [_calLabel release];
    [_textView release];
    [_remark release];
    [super dealloc];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
