//
//  NoteBook.m
//  EFei
//
//  Created by Xiangzhen Kong on 11/18/14.
//
//

#import "NoteBook.h"

@interface NoteBook ()
{
    NSMutableArray* _notes;
}

@end

@implementation NoteBook

- (id) init
{
    self = [super init];
    if (self)
    {
        _notes = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) addNote:(Note*)note
{
    [_notes addObject:note];
}
- (void) addNoteWithId:(NSInteger)noteId lastUpdateTime:(NSInteger)updateTime
{
    Note* note = [[Note alloc] initWithNoteId:noteId updateTime:updateTime];
    [self addNote:note];
}
- (Note*) noteWithId:(NSInteger)noteId
{
    for (Note* note in _notes)
    {
        if (note.noteId == noteId)
        {
            return note;
        }
    }
    return nil;
}

- (Note*) noteAtIndex:(NSInteger)index
{
    return [_notes objectAtIndex:index];
}


@end
