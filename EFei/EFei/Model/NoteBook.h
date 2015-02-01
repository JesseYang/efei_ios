//
//  NoteBook.h
//  EFei
//
//  Created by Xiangzhen Kong on 11/18/14.
//
//

#import <Foundation/Foundation.h>
#import "Note.h"
#import "DataFilter.h"

@interface NoteBook : NSObject

@property (nonatomic, readonly) NSArray* notes;
@property (nonatomic, readonly) NSArray* filetedNotes;

- (void) addNote:(Note*)note;
- (void) deleteNote:(Note*)note;
- (void) addNoteWithId:(NSString*)noteId lastUpdateTime:(NSInteger)updateTime;
- (Note*) noteWithId:(NSString*)noteId;
- (Note*) noteAtIndex:(NSInteger)index;

- (DataFilter*) fileterWithType:(DataFilterType)type;

- (NSArray*) searchNotesWithText:(NSString*)text;

- (void) clearNotes;

@end
