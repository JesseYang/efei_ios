//
//  NotebookFilterViewController.h
//  EFei
//
//  Created by Xiangzhen Kong on 1/4/15.
//
//

#import <UIKit/UIKit.h>
#import "DataFilter.h"

typedef void (^FilterViewControllerDoneBlock)(DataFilter* filter);

@interface NotebookFilterViewController : UITableViewController

@property (nonatomic, copy) FilterViewControllerDoneBlock doneBlock;
@property (nonatomic, weak) DataFilter* filter;

@end
