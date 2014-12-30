//
//  NoteCategoryTabView.h
//  EFei
//
//  Created by Xiangzhen Kong on 12/30/14.
//
//

#import <UIKit/UIKit.h>

@class NoteCategoryTabView;

@protocol NoteCategoryTabViewDelegate <NSObject>

- (void) noteCategoryTabView:(NoteCategoryTabView*)tabView didSelectedTabAtIndex:(NSInteger)index;

@end


@interface NoteCategoryTabView : UIView

@property (nonatomic, readonly) NSInteger selectedIndex;
@property (nonatomic, weak) id<NoteCategoryTabViewDelegate> delegate;
@property (nonatomic, copy) UIColor* indicatorColor;

- (id) initWithTabNames:(NSArray*)names andViews:(NSArray*)views;

@end
