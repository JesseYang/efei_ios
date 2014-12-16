//
//  SearchView.h
//  EFei
//
//  Created by Xiangzhen Kong on 12/12/14.
//
//

#import <UIKit/UIKit.h>

@class SearchView;

@protocol SearchViewDataSource <NSObject>

- (NSArray*) searchView:(SearchView*)searchView searchResultWithText:(NSString*)text;

@end

@protocol SearchViewDelegate <NSObject>

- (void) searchView:(SearchView*)searchView didAddContent:(NSString*)content;

@end

@interface SearchView : UIView

@property (nonatomic, strong) UIView* searchBar;
@property (nonatomic, weak) id<SearchViewDelegate> delegate;
@property (nonatomic, weak) id<SearchViewDataSource> dataSource;

@end
