


@interface CustomPageControl : UIControl



- (CGSize)sizeForNumberOfPages:(NSInteger)pageCount;
- (void)updateCurrentPageDisplay;

@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) NSInteger numberOfPages;
@property (nonatomic, assign) BOOL defersCurrentPageDisplay;
@property (nonatomic, assign) BOOL hidesForSinglePage;
@property (nonatomic, assign) BOOL wrap;

@property (nonatomic, retain) UIColor *otherColour;
@property (nonatomic, retain) UIColor *currentColor;
@property (nonatomic, assign) CGFloat controlSpacing;
@property (nonatomic, assign) CGFloat controlSize;


@end
