//
//  UITableViewPageing.m
//  SuPu
//
//  Created by 鑫 金 on 12-10-19.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import "UITableViewPageing.h"
#import "SVPullToRefresh.h"

@implementation UITableViewPageing
@synthesize pagenum = _pagenum;
@synthesize page = _page;
@synthesize totalcount = _totalcount;
@synthesize maxpage = _maxpage;
@synthesize curpagenum = _curpagenum;
@synthesize tableviewarray = _tableviewarray;

- (void)dealloc
{
    [_tableviewarray release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame 
{
    self = [super initWithFrame:frame];
    if (self) {
        _pagenum = PAGENUM;
        _page = INITPAGE;
        _tableviewarray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        _pagenum = PAGENUM;
        _page = INITPAGE;
        _tableviewarray = [[NSMutableArray alloc] init];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (NSMutableArray *)setPageingMessage:(int)totalcount tableviewarray:(NSArray *)tableviewarray
{   
    [_tableviewarray addObjectsFromArray:tableviewarray];
    
    _totalcount = totalcount;
    _curpagenum = tableviewarray.count;
    _page++;
    _maxpage = _totalcount%_pagenum == 0 ? _totalcount/_pagenum:(_totalcount/_pagenum)+INITPAGE+1;
    if (_page <= _maxpage) {
        self.showsInfiniteScrolling = YES;
    }else {
        self.showsInfiniteScrolling = NO;
    }
    return _tableviewarray;
}

- (void)reloadPageingMessageBeforeSelect
{
    _pagenum = PAGENUM;
    _page = INITPAGE;
    self.showsInfiniteScrolling = YES;
    [_tableviewarray removeAllObjects];
   
    [self reloadData];
}

- (NSString *)totalCountStringValue
{
    NSString *totalcountstr = [[NSString alloc] initWithFormat:@"%d",_totalcount];
    return [totalcountstr autorelease];
}

- (NSString *)pageNumStringValue
{
    NSString *pageNumstr = [[NSString alloc] initWithFormat:@"%d",_pagenum];
    return [pageNumstr autorelease];
}

- (NSString *)pageStringValue
{
    NSString *pageStringstr = [[NSString alloc] initWithFormat:@"%d",_page];
    return [pageStringstr autorelease];
}

- (NSString *)maxPageStringValue
{
    NSString *maxPagestr = [[NSString alloc] initWithFormat:@"%d",_maxpage];
    return [maxPagestr autorelease];
}

- (NSString *)curPagenumStringValue
{
    NSString *curPagenumstr = [[NSString alloc] initWithFormat:@"%d",_curpagenum];
    return [curPagenumstr autorelease];
}

@end
