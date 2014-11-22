//
//  NetWorkTaskExportNotes.m
//  EFei
//
//  Created by Xiangzhen Kong on 11/22/14.
//
//

#import "NetWorkTaskExportNotes.h"
#import "EFei.h"
#import "TaskManager.h"

static NSString* kRequestFileTypeKey         = @"file_type";
static NSString* kRequestHasAnswerKey        = @"has_answer";
static NSString* kRequestHasNoteKey          = @"has_note";
static NSString* kRequestNoteIdStrKey        = @"note_id_str";
static NSString* kRequestEmailKey            = @"email";

static NSString* kResponseFilePathKey        = @"file_path";



@implementation NetWorkTaskExportNotes

+ (void) load
{
    [[TaskManager instance] registeTaskClass:[self class] withType:NetWorkTaskTypeExportNotes];
}

- (id) init
{
    self = [super init];
    if (self)
    {
        self.taskType = NetWorkTaskTypeExportNotes;
        self.httpMethod = HttpMethodGet;
        self.path = @"student/notes/export";
    }
    return self;
}


- (void) prepareParameter
{
    ExportInfo* info = (ExportInfo*)self.data;
    
    [self.parameterDict setObject:info.fileType forKey:kRequestFileTypeKey];
    [self.parameterDict setObject:[NSNumber numberWithBool:info.hasAnswer] forKey:kRequestHasAnswerKey];
    [self.parameterDict setObject:[NSNumber numberWithBool:info.hadNote] forKey:kRequestHasNoteKey];
    [self.parameterDict setObject:info.noteIdStr forKey:kRequestNoteIdStrKey];
    [self.parameterDict setObject:info.email forKey:kRequestEmailKey];
    
}


- (BOOL) parseResultDict:(NSDictionary *)dict
{
    NSString* filePath = [dict objectForKey:kResponseFilePathKey];
    NSLog(@"NetWorkTaskExportNotes: %@", filePath);
    return YES;
}

@end
