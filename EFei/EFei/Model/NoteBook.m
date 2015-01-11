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
    
    NSMutableDictionary* _filters;
}

@end

@implementation NoteBook

- (id) init
{
    self = [super init];
    if (self)
    {
        _notes = [[NSMutableArray alloc] init];
        
        [self initFilters];
    }
    return self;
}

- (void) addNote:(Note*)note
{
    [_notes addObject:note];
}

- (void) deleteNote:(Note *)note
{
    [_notes removeObject:note];
}

- (void) addNoteWithId:(NSString*)noteId lastUpdateTime:(NSInteger)updateTime
{
    Note* note = [[Note alloc] initWithNoteId:noteId updateTime:updateTime];
    [self addNote:note];
}
- (Note*) noteWithId:(NSString*)noteId
{
    for (Note* note in _notes)
    {
        if ([note.noteId isEqualToString:noteId])
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


#pragma mark fileter

- (void) initFilters
{
    _filters = [[NSMutableDictionary alloc] init];
    
    [_filters setObject:[[TimeDataFilter alloc] init] forKey:[NSNumber numberWithInteger:DataFilterTypeTime]];
    [_filters setObject:[[TagDataFilter alloc] init] forKey:[NSNumber numberWithInteger:DataFilterTypeTag]];
    [_filters setObject:[[SubjectDataFilter alloc] init] forKey:[NSNumber numberWithInteger:DataFilterTypeSubject]];
}

- (DataFilter*) fileterWithType:(DataFilterType)type
{
    return [_filters objectForKey:[NSNumber numberWithInteger:type]];
}

@end
