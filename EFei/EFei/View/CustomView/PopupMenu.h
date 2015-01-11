//
//  PopupMenu.h
//  EFei
//
//  Created by Xiangzhen Kong on 1/10/15.
//
//

#import <UIKit/UIKit.h>

@class PopupMenu;

@protocol PopupMenuDelegate <NSObject>

- (void) popupMenu:(PopupMenu*)menu didSelectItemAtIndex:(NSInteger)index;
- (void) popupMenuDidDismiss:(PopupMenu*)menu;

@end

@interface MenuCell : UICollectionViewCell

@property (nonatomic, retain) UILabel* titleLabel;
@property (nonatomic, retain) UIImageView* imageView;
@property (nonatomic, retain) UIView* segmentView;

@end

@interface MenuArrow : UIView

@property (nonatomic, retain) UIColor* arrowColor;

@end

@interface PopupMenu : UIView<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) id<PopupMenuDelegate> delegate;
@property (nonatomic, assign) CGSize menuSize;

- (id) initWithTitles:(NSArray*)titles;
- (id) initWithImages:(NSArray*)images;

- (id) initWithMenuItemSize:(CGSize)itemSize
              menuItemCount:(NSInteger)itemCount
                     titles:(NSArray*)titles
                     images:(NSArray*)images
            backgroundColor:(UIColor*)bgColor
             seperatorColor:(UIColor*)sepColor;

- (void) showAtPoint:(CGPoint)point;
- (void) showAtPoint:(CGPoint)point withArrowOffset:(float)offset;

@end