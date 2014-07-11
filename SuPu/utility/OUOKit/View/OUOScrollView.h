//
//  OUOScrollView.h
//  SuPu
//
//  Created by 杨福军 on 12-10-23.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

typedef UIButton *(^OUOScrollViewDataSource)(NSUInteger itemIndex);
typedef void(^OUOScrollViewPageChanged)(NSUInteger currentPageIndex);
typedef void(^OUOScrollViewPageWillChange)(NSUInteger currentPageIndex);
typedef void(^OUOScrollViewTapOnItem)(NSUInteger itemIndex);

@interface OUOScrollView : UIScrollView<UIScrollViewDelegate>
@property (nonatomic, readwrite) NSInteger currentPage;
@property (retain, nonatomic) IBOutlet UIImageView *LeftScrollIndicator;
@property (retain, nonatomic) IBOutlet UIImageView *rightScrollIndicator;
@property (retain, nonatomic) IBOutlet UIPageControl *pageControl;
@property (copy) OUOScrollViewPageChanged pageChangeHandler;
@property (copy) OUOScrollViewPageWillChange pageWillChangeHandler;
@property (copy) OUOScrollViewTapOnItem    itemTappedHandler;

- (void)setItemCount:(NSUInteger)itemCount withDataSource:(OUOScrollViewDataSource)dataSource;
- (void)reloadData;

- (void)scrollToPage:(NSUInteger)page animated:(BOOL)animated;

@end
 