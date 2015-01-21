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


static NSString* kResponseIdKey                = @"_id";
static NSString* kResponseIdOidKey             = @"$oid";
static NSString* kResponseQuestionIdKey        = @"question_id";
static NSString* kResponseAFiguresKey          = @"a_figures";
static NSString* kResponseAnswerKey            = @"answer";
static NSString* kResponseAnswerContentKey     = @"answer_content";
static NSString* kResponseContentKey           = @"content";
static NSString* kResponseCreatedAtKey         = @"created_at";
static NSString* kResponseInlineImagesKey      = @"inline_images";
static NSString* kResponseItemsKey             = @"items";
static NSString* kResponseLastUpdateTimeKey    = @"last_update_time";
static NSString* kResponsePreviewKey           = @"preview";
static NSString* kResponseQFiguresKey          = @"q_figures";
static NSString* kResponseQuestionStrKey       = @"question_str";
static NSString* kResponseQuestionTypeKey      = @"question_type";
static NSString* kResponseSubjectKey           = @"subject";
static NSString* kResponseSummaryKey           = @"summary";
static NSString* kResponseTagKey               = @"tag";
static NSString* kResponseTagSetKey            = @"tag_set";
static NSString* kResponseTopicIdsKey          = @"topic_ids";
static NSString* kResponseTopicStrKey          = @"topic_str";
static NSString* kResponseTypeKey              = @"type";
static NSString* kResponseUpdatedAtKey         = @"updated_at";
static NSString* kResponseUserIdKey            = @"user_id";



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
    Note* note = (Note*)self.data;
    
    NSDictionary* noteDict = [dict objectForKey:kResponseNoteKey];
    if (![noteDict isKindOfClass:[NSDictionary class]])
    {
        return NO;
    }
    
    NSLog(@"Note  %@", dict);
    
    note.noteId = [noteDict objectForKey:kResponseIdKey];
    if ([noteDict objectForKey:kResponseAnswerKey] != [NSNull null])
    {
        note.answer = [[noteDict objectForKey:kResponseAnswerKey] integerValue];
    }
    note.contents = [noteDict objectForKey:kResponseContentKey];
    note.answerContents = [noteDict objectForKey:kResponseAnswerContentKey];
    note.items = [noteDict objectForKey:kResponseItemsKey];
    note.updateTime = [[noteDict objectForKey:kResponseLastUpdateTimeKey] integerValue];
    note.questionType = [[noteDict objectForKey:kResponseQuestionTypeKey] integerValue];
    note.subjectType = [[noteDict objectForKey:kResponseSubjectKey] integerValue];
    note.summary = [noteDict objectForKey:kResponseSummaryKey];
    note.tag = [noteDict objectForKey:kResponseTagKey];
    note.tagsetString = [noteDict objectForKey:kResponseTagSetKey];
    note.topicString = [noteDict objectForKey:kResponseTopicStrKey];
    note.createTime = [noteDict objectForKey:kResponseCreatedAtKey];
    note.lastUpdateTime = [noteDict objectForKey:kResponseUpdatedAtKey];
    
    note.updated = YES;
    
    [[EFei instance].notebook addNote:note];
    [EFei instance].newNotesAdded = YES;
    
    return YES;
}

- (void) sucess
{
//    Note* note = (Note*)self.data;
//    [[EFei instance].notebook addNote:note];
//    [EFei instance].newNotesAdded = YES;
    
    [super sucess];
}

@end
