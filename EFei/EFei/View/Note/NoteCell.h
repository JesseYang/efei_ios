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
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
@property (weak, nonatomic) IBOutlet UILabel *topicLabel;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;


//@property (nonatomic, assign) BOOL noteSelected;

- (void) setStatusWithNoAnimation:(NoteCellStatus)status;

- (void) configWithNote:(Note*)note;

@end
