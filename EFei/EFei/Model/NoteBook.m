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

- (NSArray*)filetedNotes
{
    NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:self.notes.count];
    for (Note* note in self.notes)
    {
        BOOL pass = YES;
        for (DataFilter* filter in _filters.allValues)
        {
            pass = [filter filterData:note];
            
            if (!pass)
            {
                break;
            }
        }
        
        if (pass)
        {
            [array addObject:note];
        }
    }
    
    return array;
    
//    NSArray *sortedArray;
//    sortedArray = [array sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
//        NSDate *first = [(Note*)a createDate];
//        NSDate *second = [(Note*)b createDate];
//        BOOL res = [second compare:first];
//        return res;
//    }];
//    
//    return sortedArray;
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

- (NSArray*) searchNotesWithText:(NSString *)text
{
    NSArray* array = self.filetedNotes;
    NSMutableArray* result = [[NSMutableArray alloc] initWithCapacity:array.count];
    for (Note* note in array)
    {
        if ([note matchText:text])
        {
            [result addObject:note];
        }
    }
    return result;
}

- (void) clearNotes
{
    [_notes removeAllObjects];
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
