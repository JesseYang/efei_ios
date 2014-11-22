//
//  NetWorkTaskGetNoteList.m
//  EFei
//
//  Created by Xiangzhen Kong on 11/22/14.
//
//

#import "NetWorkTaskGetNoteList.h"
#import "EFei.h"
#import "TaskManager.h"

static NSString* kResponseNotesKey        = @"notes";

@implementation NetWorkTaskGetNoteList

+ (void) load
{
    [[TaskManager instance] registeTaskClass:[self class] withType:NetWorkTaskTypeGetNoteList];
}

- (id) init
{
    self = [super init];
    if (self)
    {
        self.taskType = NetWorkTaskTypeGetNoteList;
        self.httpMethod = HttpMethodGet;
        self.path = @"student/notes";
    }
    return self;
}


- (void) prepareParameter
{
}


- (BOOL) parseResultDict:(NSDictionary *)dict
{
    NSArray* notes = [dict objectForKey:kResponseNotesKey];
    if (![notes isKindOfClass:[NSArray class]])
    {
        return NO;
    }
    
    
    for (NSArray* nArray in notes)
    {
        NSString* noteId = [nArray objectAtIndex:0];
        NSInteger updateTime = [[nArray objectAtIndex:1] integerValue];
        
        [[EFei instance].notebook addNoteWithId:noteId lastUpdateTime:updateTime];
    }
    
    return YES;
}

@end
