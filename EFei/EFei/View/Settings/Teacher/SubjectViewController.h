//
//  SubjectViewController.h
//  EFei
//
//  Created by Xiangzhen Kong on 1/13/15.
//
//

#import <UIKit/UIKit.h>

#import "EFei.h"

typedef void (^SubjectControllerDoneBlock)(SubjectType subjectType);

@interface SubjectViewController : UITableViewController

@property (nonatomic, copy) SubjectControllerDoneBlock doneBlock;
@property (nonatomic, assign) SubjectType subjectType;

@end
