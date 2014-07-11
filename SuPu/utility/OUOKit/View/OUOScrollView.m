//
//  OUOScrollView.m
//  SuPu
//
//  Created by 杨福军 on 12-10-23.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "OUOScrollView.h"

#define TAG_OFFSET 800

@interface OUOScrollView () {
    OUOScrollViewDataSource      dataSource_;
    OUOScrollViewPageChanged   handlerPageChange_;
    
    NSUInteger itemCount_;
}

- (void)setup;
- (void)notifyPageChanged;
- (void)buttonTapped:(UIButton *)sender;
@end

@implementation OUOScrollView
@synthesize rightScrollIndicator = rightScrollIndicator_;
@synthesize pageChangeHandler = pageChangeHandler_;
@synthesize pageWillChangeHandler = pageWillChangeHandler_;
@synthesize LeftScrollIndicator = LeftScrollIndicator_;
@synthesize itemTappedHandler = itemTappedHandler_;
@synthesize pageControl = pageControl_;
@synthesize currentPage = currentPage_;

///////////////////////////////////////////////////////
#pragma mark -

- (void)dealloc {
    OUOSafeRelease(rightScrollIndicator_);
    OUOSafeRelease(pageChangeHandler_);
    OUOSafeRelease(pageWillChangeHandler_);
    OUOSafeRelease(itemTappedHandler_);
    OUOSafeRelease(LeftScrollIndicator_);
    OUOSafeRelease(pageControl_);
    [super dealloc];
}

///////////////////////////////////////////////////////
#pragma mark -

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

///////////////////////////////////////////////////////
#pragma mark -

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    
    //    if (LeftScrollIndicator_ && rightScrollIndicator_) {
    //        LeftScrollIndicator_.alpha = 0.;
    //        rightScrollIndicator_.alpha = 0.;
    //        [UIView animateWithDuration:0.5 animations:^{
    //            LeftScrollIndicator_.alpha = 1.;
    //            rightScrollIndicator_.alpha = 1.;
    //        }];
    //    }
}

///////////////////////////////////////////////////////
#pragma mark -

- (void)setup {
    self.delegate = self;
    self.pagingEnabled = YES;
    self.showsHorizontalScrollIndicator = NO;
}

///////////////////////////////////////////////////////
#pragma mark - UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    CGFloat pageWidth = self.frame.size.width;
    int currentPage = floor((self.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.currentPage = currentPage;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)sscrollView {
    if (pageChangeHandler_) {
        pageChangeHandler_(currentPage_);
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    if (pageWillChangeHandler_) {
        pageWillChangeHandler_(currentPage_);
    }
}

///////////////////////////////////////////////////////
#pragma mark - Setters & Getters

-(NSInteger)currentPage {
    return currentPage_;
}

-(void)setCurrentPage:(NSInteger)page {
    if (currentPage_ != page) {
        currentPage_ = page;
    }
    [self notifyPageChanged];
}

///////////////////////////////////////////////////////
#pragma mark -

- (void)notifyPageChanged {
    if(pageControl_ != nil &&  [pageControl_ currentPage] != currentPage_) {
        pageControl_.currentPage = currentPage_;
    }
}

- (void)reloadData {
    [self removeAllSubviews];
    
    NSUInteger pageNumber = 0;          ///当前页码
    NSUInteger itemCountPerPage = 0;   ///每页放多少个
    CGFloat horizontalMargin = 0.;      ///各个按钮之间的水平间隔是多少
    CGFloat xOffset = 0.;
    for (int i = 0; i != itemCount_; i++) {
        UIButton *button = dataSource_(i);
        button.tag = i + TAG_OFFSET;
        [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        [button verticalCenterInView:self];
        
        itemCountPerPage = self.frameWidth / button.frameWidth;
        horizontalMargin = (lround(self.frameWidth) % lround(button.frameWidth)) / (itemCountPerPage + 1);
        xOffset += horizontalMargin;
        button.frameX = xOffset;
        xOffset += button.frameWidth;
        
        if ((i + 1) % itemCountPerPage == 0) {  ///是否应该开启新的一页
            pageNumber ++;
            xOffset = pageNumber * self.frameWidth;
        }
        
        [self addSubview:button];
    }
    if (itemCount_ == 1) {  ///只有一个的时候将其居中显示
        [self.subviews enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
            [button horizontalCenterInView:self];
        }];
    }
    if (itemCountPerPage == 0) {
        itemCountPerPage = 1;
    }
    NSUInteger pageCount = ceil(itemCount_ / [[NSNumber numberWithInt:itemCountPerPage] floatValue]);  ///总页数
    self.contentSize = CGSizeMake(self.frameWidth * pageCount, self.frameHeight);
    pageControl_.userInteractionEnabled = NO;
    pageControl_.numberOfPages = pageCount;
    
    ///这行必须保留，要不然在ios 6.0sdk以下会出现第0页不会被选中的情况
    pageControl_.currentPage = pageCount;
    
    pageControl_.currentPage = 0;
}

- (void)setItemCount:(NSUInteger)itemCount withDataSource:(OUOScrollViewDataSource)dataSource {
    itemCount_ = itemCount;
    dataSource_ = dataSource;
    [self reloadData];
}

///////////////////////////////////////////////////////
#pragma mark - Actions

- (void)scrollToPage:(NSUInteger)page animated:(BOOL)animated {
    [self setContentOffset:CGPointMake(self.frameWidth * page, 0.) animated:animated];
}

///////////////////////////////////////////////////////
#pragma mark - Actions

- (void)buttonTapped:(UIButton *)sender {
    if (itemTappedHandler_) {
        itemTappedHandler_(sender.tag - TAG_OFFSET);
    }
}

@end
