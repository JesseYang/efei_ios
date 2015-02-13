//
//  TagCollectionView.m
//  EFei
//
//  Created by Xiangzhen Kong on 12/13/14.
//
//

#import "TagCollectionView.h"
#import "TagCollectionViewCell.h"

#define TagCollectionViewCellId @"TagCollectionViewCell"

@implementation TagCollectionViewFlowLayout

- (NSArray *) layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *answer = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    
    for(int i = 1; i < [answer count]; ++i)
    {
        UICollectionViewLayoutAttributes *currentLayoutAttributes = answer[i];
        UICollectionViewLayoutAttributes *prevLayoutAttributes = answer[i - 1];
        NSInteger maximumSpacing = 4;
        NSInteger origin = CGRectGetMaxX(prevLayoutAttributes.frame);
        if(origin + maximumSpacing + currentLayoutAttributes.frame.size.width < self.collectionViewContentSize.width)
        {
            CGRect frame = currentLayoutAttributes.frame;
            frame.origin.x = origin + maximumSpacing;
            currentLayoutAttributes.frame = frame;
        }
    }
    return answer;
}

@end

@interface TagCollectionView()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
{
    NSMutableArray* _titles;
}

- (void) onDeleteTag:(id)sender event:(UIEvent*)event;

@end

@implementation TagCollectionView

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self setupUI];
    }
    return self;
}

- (id) initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self)
    {
        [self setupUI];
    }
    return self;
}

- (void) setupUI
{
    self.dataSource = self;
    self.delegate = self;
    _titles = [[NSMutableArray alloc] init];
    
    UICollectionViewFlowLayout* flowLayout = (UICollectionViewFlowLayout*)self.collectionViewLayout;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 12.0, 0, 12.0);
}

- (void) addTitle:(NSString*)title
{
    NSString *trimmedString = [title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (trimmedString.length > 0)
    {
        [_titles addObject:title];
        [self reloadData];
    }
}

- (void) onDeleteTag:(id)sender event:(UIEvent *)event
{
    UITouch* touch = [event.allTouches anyObject];
    CGPoint point = [touch locationInView:self];
    NSIndexPath* indexPath = [self indexPathForItemAtPoint:point];
    [_titles removeObjectAtIndex:indexPath.row];
    
    [self reloadData];
}

#pragma mark Delegate

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _titles.count;
}

- (UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TagCollectionViewCell* cell = (TagCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:TagCollectionViewCellId forIndexPath:indexPath];
    NSString* tilte = [_titles objectAtIndex:indexPath.row];
    cell.contentLabel.text = tilte;
    [cell.deleteButton addTarget:self action:@selector(onDeleteTag:event:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* tilte = [_titles objectAtIndex:indexPath.row];
    return [TagCollectionViewCell cellSizeWithString:tilte];
}



@end
