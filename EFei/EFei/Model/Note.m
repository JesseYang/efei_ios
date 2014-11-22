//
//  Note.m
//  EFei
//
//  Created by Xiangzhen Kong on 11/18/14.
//
//

#import "Note.h"

@implementation Note

- (id) initWithNoteId:(NSInteger)noteId updateTime:(NSInteger)updateTime
{
    self = [super init];
    if (self)
    {
        self.noteId = noteId;
        self.updateTime = updateTime;
    }
    
    return self;
}

@end
