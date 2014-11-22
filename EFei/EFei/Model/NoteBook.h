//
//  NoteBook.h
//  EFei
//
//  Created by Xiangzhen Kong on 11/18/14.
//
//

#import <Foundation/Foundation.h>
#import "Note.h"

@interface NoteBook : NSObject

@property (nonatomic, readonly) NSArray* notes;

- (void) addNote:(Note*)note;
- (void) addNoteWithId:(NSInteger)noteId lastUpdateTime:(NSInteger)updateTime;
- (Note*) noteWithId:(NSInteger)noteId;
- (Note*) noteAtIndex:(NSInteger)index;

@end
