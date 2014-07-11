//
//  STWeiboComposeViewController.h
//  SportsTogether
//
//  Created by 杨福军 on 12-8-15.
//
//

#import "TPKeyboardAvoidingTableView.h"

@interface SPWeiboComposeViewController : SPBaseViewController

@property (retain, nonatomic) IBOutlet TPKeyboardAvoidingTableView *tableView;
@property (retain, nonatomic) NSString *shareText;

@end
