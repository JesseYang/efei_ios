//
//  PopupMenu.m
//  EFei
//
//  Created by Xiangzhen Kong on 1/10/15.
//
//

#import "PopupMenu.h"


#define MenuArrowWidth 12
#define MenuArrowHeight 8
#define MenuItemMargin 5
#define SeperatorMargin 10
#define MenuCellId @"MenuCell"

@interface MenuCell()

- (void) initUI;

@end

@implementation MenuCell

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self initUI];
    }
    
    return self;
}

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initUI];
    }
    return self;
}

- (void) initUI
{
    CGRect imageRect = CGRectMake(0, 0, self.frame.size.height, self.frame.size.height);
    self.imageView = [[UIImageView alloc] initWithFrame:imageRect];
    [self addSubview:self.imageView];
    
    CGRect labelRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.titleLabel = [[UILabel alloc] initWithFrame:labelRect];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.titleLabel];
    
    self.segmentView = [[UIView alloc] init];
    self.segmentView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.8];
    [self addSubview:self.segmentView];
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.frame = self.bounds;
    
    CGRect segmentRect = CGRectMake(SeperatorMargin, self.frame.size.height-1,
                                    self.frame.size.width-SeperatorMargin*2, 1);
    
    self.segmentView.frame = segmentRect;
    
    float width = self.frame.size.width - self.frame.size.height;
    CGRect titleRect = CGRectMake(self.frame.size.height, 0, width, self.frame.size.height);
    self.titleLabel.frame = titleRect;
}

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////

@implementation MenuArrow

-(void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextBeginPath(ctx);
    CGContextMoveToPoint   (ctx, CGRectGetMinX(rect), CGRectGetMaxY(rect));  // top left
    CGContextAddLineToPoint(ctx, CGRectGetMidX(rect), CGRectGetMinY(rect));  // mid right
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMaxY(rect));  // bottom left
    CGContextClosePath(ctx);
    
    const CGFloat* colors = CGColorGetComponents( self.arrowColor.CGColor );
    CGContextSetRGBFillColor(ctx, colors[0], colors[1], colors[2], colors[3]);
    CGContextFillPath(ctx);
}

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////

@interface PopupMenu ()
{
    UIView*           _menu;
    MenuArrow*        _menuArrow;
    UICollectionView* _itemsView;
    NSArray*          _images;
    NSArray*          _titles;
    CGSize            _itemSize;
    NSInteger         _itemCount;
    UIColor*          _backgroundColor;
    UIColor*          _seperatorColor;
}

- (void) initUI;

- (void) dismiss:(id)sender;

@end



@implementation PopupMenu

- (id) initWithTitles:(NSArray *)titles
{
    CGRect rect = [UIScreen mainScreen].bounds;
    self = [super initWithFrame:rect];
    if (self)
    {
        _titles = titles;
        [self initUI];
    }
    return self;
}

- (id) initWithImages:(NSArray *)images
{
    CGRect rect = [UIScreen mainScreen].bounds;
    self = [super initWithFrame:rect];
    if (self)
    {
        _images = images;
        [self initUI];
    }
    return self;
}

- (id) initWithMenuItemSize:(CGSize)itemSize
              menuItemCount:(NSInteger)itemCount
                     titles:(NSArray *)titles
                     images:(NSArray *)images
            backgroundColor:(UIColor *)bgColor
             seperatorColor:(UIColor *)sepColor
{
    
    CGRect rect = [UIScreen mainScreen].bounds;
    self = [super initWithFrame:rect];
    if (self)
    {
        _titles = titles;
        _images = images;
        _itemCount = itemCount;
        _itemSize = itemSize;
        _backgroundColor = bgColor;
        _seperatorColor = sepColor;
        [self initUI];
    }
    return self;
}


- (void) initUI
{
    self.backgroundColor = [UIColor clearColor];
    
    UIView* modalBackgroundView = [[UIView alloc] initWithFrame:self.frame];
    UITapGestureRecognizer* recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss:)];
    [modalBackgroundView addGestureRecognizer:recognizer];
    [self addSubview:modalBackgroundView];
    
    
    float menuWidth = _itemSize.width;
    float menuHeight = _itemSize.height * _itemCount + MenuItemMargin*2;
    self.menuSize = CGSizeMake(menuWidth, menuHeight);
    CGRect menuRect = CGRectMake(0, 0, menuWidth, menuHeight);
    _menu = [[UIView alloc] initWithFrame:menuRect];
    _menu.layer.cornerRadius = 5;
    _menu.backgroundColor = _backgroundColor;
    
    
    CGRect tableRect = CGRectMake(0, MenuItemMargin, _itemSize.width, _itemSize.height * _itemCount);
    
    UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setSectionInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    [flowLayout setMinimumLineSpacing:0.0];
    [flowLayout setMinimumInteritemSpacing:0.0];
    
    _itemsView = [[UICollectionView alloc] initWithFrame:tableRect collectionViewLayout:flowLayout];
    _itemsView.dataSource = self;
    _itemsView.delegate = self;
    _itemsView.backgroundColor = [UIColor clearColor];
    [_menu addSubview:_itemsView];
    
    [_itemsView registerClass:[MenuCell class] forCellWithReuseIdentifier:MenuCellId];
    
    [self addSubview:_menu];
    
    
    CGRect arrowRect = CGRectMake(0, 0, MenuArrowWidth, MenuArrowHeight);
    _menuArrow = [[MenuArrow alloc] initWithFrame:arrowRect];
    _menuArrow.backgroundColor = [UIColor clearColor];
    _menuArrow.arrowColor = _backgroundColor;
    [self addSubview:_menuArrow];
}


- (void) showAtPoint:(CGPoint)point
{
    [self showAtPoint:point withArrowOffset:0.5f];
}

- (void) showAtPoint:(CGPoint)point withArrowOffset:(float)offset
{
    CGRect rect = _menu.frame;
    rect.origin = CGPointMake(point.x - _itemSize.width * offset, point.y + MenuArrowHeight);
    _menu.frame = rect;
    
    CGRect arrowRect = _menuArrow.frame;
    arrowRect.origin.x = point.x - MenuArrowWidth / 2;
    arrowRect.origin.y = point.y;
    _menuArrow.frame = arrowRect;
    
    [_itemsView reloadData];
    
    [[[UIApplication sharedApplication].windows objectAtIndex:0] addSubview:self];
}

- (void) dismiss:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(popupMenuDidDismiss:)])
    {
        [self.delegate popupMenuDidDismiss:self];
        [self removeFromSuperview];
    }
}

#pragma mark - UICollectionViewDelegate

- (void) collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    MenuCell* cell = (MenuCell*)[collectionView cellForItemAtIndexPath:indexPath];
    cell.imageView.highlighted = NO;
}

- (void) collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    MenuCell* cell = (MenuCell*)[collectionView cellForItemAtIndexPath:indexPath];
    cell.imageView.highlighted = YES;
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(popupMenu:didSelectItemAtIndex:)])
    {
        [self.delegate popupMenu:self didSelectItemAtIndex:indexPath.row];
    }
    
    [self removeFromSuperview];
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _itemCount;
}

#pragma mark - UICollectionViewDataSource

- (UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MenuCell* cell = (MenuCell*)[collectionView dequeueReusableCellWithReuseIdentifier:MenuCellId forIndexPath:indexPath];
    if (cell != nil)
    {
        if (_images != nil)
        {
            UIImage* image = [_images objectAtIndex:indexPath.row*2];
            UIImage* highlightedImage = [_images objectAtIndex:(indexPath.row*2+1)];
            float screenScale = [UIScreen mainScreen].scale;
            screenScale = 1.0;
            cell.imageView.image = image;
            cell.imageView.highlightedImage = highlightedImage;
            CGRect rect = cell.imageView.frame;
            rect.origin.y = 6; //(cell.frame.size.height - image.size.height / screenScale) / 2;
            rect.size = CGSizeMake(18, 18); // CGSizeMake(image.size.width/screenScale, image.size.height/screenScale);
            
            if (_titles != nil)
            {
                rect.origin.x = rect.origin.y;
            }
            else
            {
                rect.origin.x = (cell.frame.size.width - image.size.width / screenScale) / 2;
            }
            
            cell.imageView.frame = rect;
        }
        
        cell.titleLabel.text = [_titles objectAtIndex:indexPath.row];
        cell.titleLabel.textAlignment = NSTextAlignmentLeft;
        cell.segmentView.backgroundColor = _seperatorColor;
        
        if (indexPath.row == _titles.count-1)
        {
            cell.segmentView.hidden = YES;
        }
        else
        {
            cell.segmentView.hidden = NO;
        }
        
        [cell layoutIfNeeded];
    }
    
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return _itemSize;
}

@end
