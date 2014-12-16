//
//  NoteCell.h
//  EFei
//
//  Created by Xiangzhen Kong on 11/30/14.
//
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    NoteCellStatusNone,
    NoteCellStatusExport,
    NoteCellStatusDelete,
    NoteCellStatusSelect,
} NoteCellStatus;

@class Note;

@interface NoteCell : UICollectionViewCell

@property (nonatomic, assign) NoteCellStatus status;
@property (weak, nonatomic) IBOutlet UIView *noteContentView;
@property (weak, nonatomic) IBOutlet UIButton *exportButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

- (void) setStatusWithNoAnimation:(NoteCellStatus)status;

- (void) configWithNote:(Note*)note;

@end
