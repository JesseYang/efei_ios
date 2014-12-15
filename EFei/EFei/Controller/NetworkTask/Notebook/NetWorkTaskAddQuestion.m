//
//  NetWorkTaskAddQuestion.m
//  EFei
//
//  Created by Xiangzhen Kong on 11/22/14.
//
//

#import "NetWorkTaskAddQuestion.h"
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
static NSString* kResponseTeachersKe           = @"teachers";




@implementation NetWorkTaskAddQuestion

+ (void) load
{
    [[TaskManager instance] registeTaskClass:[self class] withType:NetWorkTaskTypeAddQuestion];
}

- (id) init
{
    self = [super init];
    if (self)
    {
        self.taskType = NetWorkTaskTypeAddQuestion;
        self.httpMethod = HttpMethodPost;
        self.path = @"student/notes";
    }
    return self;
}


- (void) prepareParameter
{
    Note* note = (Note*)self.data;
    
    [self.parameterDict setObject:note.questionId forKey:kRequestQuestionIdKey];
    [self.parameterDict setObject:note.tag forKey:kRequestNoteTagKey];
    [self.parameterDict setObject:note.topicString forKey:kRequestNoteTopicsKey];
    [self.parameterDict setObject:note.summary forKey:kRequestNoteSummaryKey];
}


- (BOOL) parseResultDict:(NSDictionary *)dict
{
    
    
    return YES;
}

@end
