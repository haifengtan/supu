//
//  STWeiboComposeViewController.m
//  SportsTogether
//
//  Created by 杨福军 on 12-8-15.
//
//

#import "SPWeiboComposeViewController.h"
#import "OUOValidator.h"
#import "SPAppDelegate.h"
#import "SHSShareViewController.h"

@interface SPWeiboComposeViewController ()

@end

@implementation SPWeiboComposeViewController
@synthesize tableView = tableView_;
@synthesize shareText = shareText_;

///////////////////////////////////////////////////////
#pragma mark -

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    OUOSafeRelease(tableView_);
    OUOSafeRelease(shareText_)
    [super dealloc];
}

///////////////////////////////////////////////////////
#pragma mark -

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:nil];
    
    self.title = @"微博分享";
    self.UMStr = @"微博分享";
    __block typeof(self) bself = self;
    
    [self setRightBarButtonWithTitle:@"分享" handler:^(id sender) {
        [((UITextView *)bself.tableView.tableFooterView) resignFirstResponder];

        SHSShareViewController *shareController=[[SHSShareViewController alloc] initWithRootViewController:KAppDelegate.m_tabBarCtrl];
        shareController.shareType=ShareTypeText;
        shareController.sharedtitle=@"速普商城";
        shareController.sharedText= ((UITextView *)bself.tableView.tableFooterView).text;
//        shareController.sharedURL = @"http://www.supuy.com";
        [shareController showShareView];
    }];
    self.navigationItem.rightBarButtonItem.enabled = YES;
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 222.0)];
    textView.font = OUO_FONT(15.);
    textView.backgroundColor = [UIColor clearColor];
    textView.text = self.shareText;

    tableView_.scrollEnabled = NO;
    tableView_.tableFooterView = textView;
    [textView becomeFirstResponder];
    [textView release];
}

- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}

///////////////////////////////////////////////////////
#pragma mark -

- (void)textDidChange:(NSNotification *)notification {
    UITextView *textView = notification.object;
    if (![OUOValidator validateNONEmptyString:textView.text]) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    } else {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
}

///////////////////////////////////////////////////////
#pragma mark - Setters and Getters
/*
- (STSinaWeiboSharer *)sharer {
    if (sharer_ == nil) {
        sharer_ = [[STSinaWeiboSharer alloc] init];
        sharer_.pendingShare = ShareTypeTextAndImage;
        sharer_.rootViewController = self;
        sharer_.delegate = self;
    }
    return sharer_;
}
*/
///////////////////////////////////////////////////////
#pragma mark - SHSOAuthSharerProtocol
/*
- (void)OAuthSharerDidBeginShare:(id<SHSOAuthSharerProtocol>)oauthSharer {
    [self showHUDWithMessage:@"正在提交..."];
}

- (void)OAuthSharerDidFinishShare:(id<SHSOAuthSharerProtocol>)oauthSharer {
    [self hideHUDWithCompletionMessage:@"分享成功" finishedHandler:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)OAuthSharerDidFailShare:(id<SHSOAuthSharerProtocol>)oauthSharer {
    
}
*/
@end
