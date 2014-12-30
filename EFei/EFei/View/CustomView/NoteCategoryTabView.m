//
//  NoteCategoryTabView.m
//  EFei
//
//  Created by Xiangzhen Kong on 12/30/14.
//
//

#import "NoteCategoryTabView.h"


static const float kTitleHeight = 50;
static const float kIndicatorWidth = 70;
static const float kIndicatorHeight = 2;
static const float kSegmentHeight = 1;

@interface NoteCategoryTabView()
{
    NSMutableArray* _tabTitles;
    NSMutableArray* _tabViews;
    UIView* _indicatorView;
    UIView* _titleView;
    UIView* _segmentView;
}

- (void) initTitles:(NSArray*)names;
- (void) initTabViews:(NSArray*)views;
- (void) initIndicator;

- (void) selectTab:(NSInteger)index animation:(BOOL)animation;

- (void) onTitleTapped:(UITapGestureRecognizer*)recognizer;

@end

@implementation NoteCategoryTabView

- (id) initWithTabNames:(NSArray *)names andViews:(NSArray *)views
{
    self = [self init];
    if (self)
    {
        [self initTitles:names];
        [self initTabViews:views];
        [self initIndicator];
        [self selectTab:0 animation:NO];
    }
    return self;
}

- (void) initTitles:(NSArray *)names
{
    _titleView = [[UIView alloc] initWithFrame:self.frame];
    _tabTitles = [[NSMutableArray alloc] initWithCapacity:names.count];
    for (NSString* name in names)
    {
        CGRect rect = CGRectMake(0, 0, 0, kTitleHeight);
        UILabel* label = [[UILabel alloc] initWithFrame:rect];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = name;
        [_tabTitles addObject:label];
        [_titleView addSubview:label];
    }
    [self addSubview:_titleView];
    UITapGestureRecognizer* recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTitleTapped:)];
    [_titleView addGestureRecognizer:recognizer];
}

- (void) initTabViews:(NSArray *)views
{
    _tabViews = [[NSMutableArray alloc] initWithCapacity:views.count];
    for (UIView* view in views)
    {
        [_tabViews addObject:view];
        [self addSubview:view];
    }
}

- (void) initIndicator
{
    CGRect rect = CGRectMake(0, kTitleHeight-kIndicatorHeight-kSegmentHeight, kIndicatorWidth, kIndicatorHeight);
    _indicatorView = [[UIView alloc] initWithFrame:rect];
    _indicatorView.backgroundColor = self.indicatorColor;
    [self addSubview:_indicatorView];
    
    CGRect segmentRect = CGRectMake(0, kTitleHeight-kSegmentHeight, self.frame.size.width, kSegmentHeight);
    _segmentView = [[UIView alloc] initWithFrame:segmentRect];
    _segmentView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_segmentView];
}

- (void) setIndicatorColor:(UIColor *)indicatorColor
{
    _indicatorColor = [indicatorColor copy];
    _indicatorView.backgroundColor = self.indicatorColor;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    _titleView.frame = CGRectMake(0, 0, self.frame.size.width, kTitleHeight);
    
    float titleWidth = self.frame.size.width / _tabTitles.count;
    for (int i=0; i<_tabTitles.count; i++)
    {
        UILabel* label = [_tabTitles objectAtIndex:i];
        CGRect rect = label.frame;
        rect.origin.x = i * titleWidth;
        rect.size.width = titleWidth;
        label.frame = rect;
    }
    
    CGRect indicatorRect = _indicatorView.frame;
    indicatorRect.origin.x = _selectedIndex * titleWidth + titleWidth / 2 - kIndicatorWidth / 2;
    _indicatorView.frame = indicatorRect;
    
    CGRect segmentRect = _segmentView.frame;
    segmentRect.size.width = self.frame.size.width;
    _segmentView.frame = segmentRect;
    
    
    CGRect viewRect = CGRectMake(0, kTitleHeight, self.frame.size.width, self.frame.size.height - kTitleHeight);
    for (UIView* view in _tabViews)
    {
        view.frame = viewRect;
    }
}

- (void) selectTab:(NSInteger)index animation:(BOOL)animation
{
    _selectedIndex = index;
    
    for (UIView* view in _tabViews)
    {
        view.hidden = YES;
    }
    
    float duration = 0.0;
    if (animation)
    {
        duration = 0.3;
    }
    
    [UIView animateWithDuration:duration animations:^(){
        
        float titleWidth = self.frame.size.width / _tabTitles.count;
        CGRect indicatorRect = _indicatorView.frame;
        indicatorRect.origin.x = _selectedIndex * titleWidth + titleWidth / 2 - kIndicatorWidth / 2;
        _indicatorView.frame = indicatorRect;
        
    }];
    
    UIView* selectedView = [_tabViews objectAtIndex:_selectedIndex];
    selectedView.hidden = NO;
    [self bringSubviewToFront:selectedView];
    
    if ([self.delegate respondsToSelector:@selector(noteCategoryTabView:didSelectedTabAtIndex:)])
    {
        [self.delegate noteCategoryTabView:self didSelectedTabAtIndex:index];
    }
}

- (void) onTitleTapped:(UITapGestureRecognizer *)recognizer
{
    CGPoint point = [recognizer locationInView:_titleView];
    NSInteger index = point.x * _tabTitles.count / _titleView.frame.size.width;
    
    [self selectTab:index animation:YES];
}

@end