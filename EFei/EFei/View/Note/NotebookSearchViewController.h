//
//  NotebookSearchViewController.h
//  EFei
//
//  Created by Xiangzhen Kong on 1/4/15.
//
//

#import <UIKit/UIKit.h>

@class SearchBarView;

typedef void (^SearchViewControllerDoneBlock)(NSString* text);

@interface NotebookSearchViewController : UIViewController

@property (nonatomic, weak) SearchBarView* searchBarView;
@property (nonatomic, copy) SearchViewControllerDoneBlock doneBlock;

@end
