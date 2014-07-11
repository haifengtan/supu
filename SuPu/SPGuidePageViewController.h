//
//  SPGuidePageViewController.h
//  SuPu
//
//  Created by 持创 on 13-4-2.
//  Copyright (c) 2013年 com.chichuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPGuidePageAction.h"
#import "SPVersionUpdateAction.h"
@protocol SPGuidePageViewControllerDelegate
-(void)guideComplete;
@end;

@interface SPGuidePageViewController : UIViewController<SPGuidePageActionDelegate,UIScrollViewDelegate,SPVersionUpdateActionDelegate>{
    id<SPGuidePageViewControllerDelegate> m_delegate;
    SPVersionUpdateAction *versionUpdateAction;
}
@property (nonatomic,assign) id<SPGuidePageViewControllerDelegate> m_delegate;
@end
