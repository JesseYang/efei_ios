//
//  NoteTextView.h
//  EFei
//
//  Created by Xiangzhen Kong on 12/3/14.
//
//

#import <UIKit/UIKit.h>

@class RichTextView;

@protocol RichTextViewDelegate <NSObject>

- (void) noteTextView:(RichTextView*)view didClickImage:(NSString*)imageName;

@end

@interface RichTextView : UITextView

@property (nonatomic, weak) id<RichTextViewDelegate> noteDelegate;
@property (nonatomic, copy) NSString* imagePath;

- (void) setNoteContent:(NSArray*)contents;

@end
