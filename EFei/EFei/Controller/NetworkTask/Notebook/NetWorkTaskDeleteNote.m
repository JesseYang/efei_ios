//
//  NetWorkTaskDeleteNote.m
//  EFei
//
//  Created by Xiangzhen Kong on 11/22/14.
//
//

#import "NetWorkTaskDeleteNote.h"
#import "EFei.h"
#import "TaskManager.h"

static NSString* kResponseNoteKey        = @"note";

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



@implementation NetWorkTaskDeleteNote

+ (void) load
{
    [[TaskManager instance] registeTaskClass:[self class] withType:NetWorkTaskTypeDeleteNote];
}

- (id) init
{
    self = [super init];
    if (self)
    {
        self.taskType = NetWorkTaskTypeDeleteNote;
        self.httpMethod = HttpMethodDelete;
        self.path = @"student/notes";
    }
    return self;
}


- (void) prepareParameter
{
    Note* note = (Note*)self.data;
    self.path = [NSString stringWithFormat:@"%@/%@", self.path, note.noteId];
}


- (BOOL) parseResultDict:(NSDictionary *)dict
{
//    Note* note = (Note*)self.data;
//    
//    NSDictionary* noteDict = [dict objectForKey:kResponseNoteKey];
//    if (![noteDict isKindOfClass:[NSDictionary class]])
//    {
//        return NO;
//    }
//    
//    note.noteId = [[noteDict objectForKey:kResponseIdKey] objectForKey:kResponseIdOidKey];
//    note.answer = [[noteDict objectForKey:kResponseAnswerKey] integerValue];
//    note.answerContents = [noteDict objectForKey:kResponseAnswerContentKey];
//    note.items = [noteDict objectForKey:kResponseItemsKey];
//    note.answerContents = [noteDict objectForKey:kResponseAnswerContentKey];
//    note.updateTime = [[noteDict objectForKey:kResponseLastUpdateTimeKey] integerValue];
//    note.answerContents = [noteDict objectForKey:kResponseAnswerContentKey];
//    note.questionType = [[noteDict objectForKey:kResponseQuestionTypeKey] integerValue];
//    note.subjectType = [[noteDict objectForKey:kResponseSubjectKey] integerValue];
//    note.summary = [noteDict objectForKey:kResponseSummaryKey];
//    note.tag = [noteDict objectForKey:kResponseTagKey];
//    note.tags = [noteDict objectForKey:kResponseTagSetKey];
    
    return YES;
}

- (void) sucess
{
    Note* note = (Note*)self.data;
    [[EFei instance].notebook deleteNote:note];
    
    [super sucess];
}

@end

