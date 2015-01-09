//
//  NetWorkTaskAddQuestionList.m
//  EFei
//
//  Created by Xiangzhen Kong on 1/8/15.
//
//

#import "NetWorkTaskAddQuestionList.h"
#import "EFei.h"
#import "TaskManager.h"

static NSString* kRequestQuestionIdKey        = @"question_id";
static NSString* kRequestQuestionIdsKey       = @"question_ids";
static NSString* kRequestNoteTagKey           = @"tag";
static NSString* kRequestNoteTopicsKey        = @"topics";
static NSString* kRequestNoteSummaryKey       = @"summary";


static NSString* kResponseNoteKey              = @"note";
static NSString* kResponseNoteUpdateTimeKey    = @"note_update_time";
static NSString* kResponseTeacherKey           = @"teacher";
static NSString* kResponseTeachersKey          = @"teachers";




@implementation NetWorkTaskAddQuestionList

+ (void) load
{
    [[TaskManager instance] registeTaskClass:[self class] withType:NetWorkTaskTypeAddQuestionList];
}

- (id) init
{
    self = [super init];
    if (self)
    {
        self.taskType = NetWorkTaskTypeAddQuestionList;
        self.httpMethod = HttpMethodPost;
        self.path = @"student/notes/batch";
    }
    return self;
}


- (void) prepareParameter
{
    NSArray* array = (NSArray*)self.data;
    
    NSMutableArray* ids = [[NSMutableArray alloc] initWithCapacity:array.count];
    for (Question* q in array)
    {
        [ids addObject:q.questionId];
    }
    
    [self.parameterDict setObject:ids forKey:kRequestQuestionIdsKey];
}


- (BOOL) parseResultDict:(NSDictionary *)dict
{
    NSDictionary* updateTimeDict = [dict objectForKey:kResponseNoteUpdateTimeKey];
    
    if (![updateTimeDict isKindOfClass:[NSDictionary class]])
    {
        return NO;
    }
    
    NSString* subject = [updateTimeDict.allKeys firstObject];
    NSInteger time = [[updateTimeDict objectForKey:subject] integerValue];
    NSLog(@"NetWorkTaskGetUpdateTime:  %@  %ld", subject, time);
    
    return YES;
}

- (void) sucess
{
    [super sucess];
    
    NSArray* array = (NSArray*)self.data;
    for (Question* q in array)
    {
        Note* note = [[Note alloc] initWithQuestion:q];
        [[EFei instance].notebook addNote:note];
    }
    
    [EFei instance].newNotesAdded = YES;
}

@end