//
//  NoteTextView.h
//  EFei
//
//  Created by Xiangzhen Kong on 12/3/14.
//
//

#import <UIKit/UIKit.h>

@class NoteTextView;

@protocol NoteTextViewDelegate <NSObject>

- (void) noteTextView:(NoteTextView*)view didClickImage:(NSString*)imageName;

@end

@interface NoteTextView : UITextView

@property (nonatomic, weak) id<NoteTextViewDelegate> noteDelegate;

- (void) setNoteContent:(NSArray*)contents;

@end
