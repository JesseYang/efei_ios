//
//  SearchBarView.h
//  EFei
//
//  Created by Xiangzhen Kong on 1/4/15.
//
//

#import <UIKit/UIKit.h>

@class SearchBarView;

@protocol SearchBarViewDelegate <NSObject>

- (void) searchBarViewDidTapped:(SearchBarView*)searchBarView;

@end

@interface InsetTextFiled : UITextField

@end

@interface SearchBarView : UIView

@property (nonatomic, assign) BOOL editing;
@property (nonatomic, weak) id<SearchBarViewDelegate> delegate;

@end
