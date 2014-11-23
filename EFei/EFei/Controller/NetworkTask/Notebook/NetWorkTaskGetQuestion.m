//
//  NetWorkTaskGetQuestion.m
//  EFei
//
//  Created by Xiangzhen Kong on 11/22/14.
//
//

#import "NetWorkTaskGetQuestion.h"
#import "EFei.h"
#import "TaskManager.h"

static NSString* kResponseNoteIdKey        = @"note_id";
static NSString* kResponseQuestionKey        = @"question";

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
static NSString* kResponseTypeKey              = @"type";
static NSString* kResponseUpdatedAtKey         = @"updated_at";
static NSString* kResponseUserIdKey            = @"user_id";



@implementation NetWorkTaskGetQuestion

+ (void) load
{
    [[TaskManager instance] registeTaskClass:[self class] withType:NetWorkTaskTypeGetQuestion];
}

- (id) init
{
    self = [super init];
    if (self)
    {
        self.taskType = NetWorkTaskTypeGetQuestion;
        self.httpMethod = HttpMethodGet;
        self.path = @"student/questions";
    }
    return self;
}


- (void) prepareParameter
{
    Question* question = (Question*)self.data;
    self.path = [NSString stringWithFormat:@"%@/%@", self.path, question.questionId];
}


- (BOOL) parseResultDict:(NSDictionary *)dict
{
    NSString* noteId = [dict objectForKey:kResponseNoteIdKey];
    if (noteId.length > 0)
    {
        NSLog(@"NetWorkTaskGetQuestion: note id: %@", noteId);
        return YES;
    }
    
    
    Question* question = (Question*)self.data;
    
    NSDictionary* noteDict = [dict objectForKey:kResponseNoteIdKey];
    if (![noteDict isKindOfClass:[NSDictionary class]])
    {
        return NO;
    }
    
    question.questionId = [[noteDict objectForKey:kResponseIdKey] objectForKey:kResponseIdOidKey];
    question.answer = [[noteDict objectForKey:kResponseAnswerKey] integerValue];
    question.answerContents = [noteDict objectForKey:kResponseAnswerContentKey];
    question.items = [noteDict objectForKey:kResponseItemsKey];
    question.answerContents = [noteDict objectForKey:kResponseAnswerContentKey];
    question.answerContents = [noteDict objectForKey:kResponseAnswerContentKey];
    question.questionType = [[noteDict objectForKey:kResponseQuestionTypeKey] integerValue];
    question.subjectType = [[noteDict objectForKey:kResponseSubjectKey] integerValue];
    question.tags = [noteDict objectForKey:kResponseTagSetKey];
    
    return YES;
}

@end
