//
//  NetWorkTaskGetNote.m
//  EFei
//
//  Created by Xiangzhen Kong on 11/22/14.
//
//

#import "NetWorkTaskGetNote.h"
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
static NSString* kResponseTopicStrKey          = @"topic_str";
static NSString* kResponseTypeKey              = @"type";
static NSString* kResponseUpdatedAtKey         = @"updated_at";
static NSString* kResponseUserIdKey            = @"user_id";
static NSString* kResponseImagePathKey         = @"image_path";


@implementation NetWorkTaskGetNote

+ (void) load
{
    [[TaskManager instance] registeTaskClass:[self class] withType:NetWorkTaskTypeGetNote];
}

- (id) init
{
    self = [super init];
    if (self)
    {
        self.taskType = NetWorkTaskTypeGetNote;
        self.httpMethod = HttpMethodGet;
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
    note.imagePath = [dict objectForKey:kResponseImagePathKey];
    
    note.updated = YES;
    
    return YES;
}

@end


/*
 
Note Example:
 
{
 "_id":"548e4f67692d354ebf010000",
 "a_figures":[],
 "answer":null,
 "answer_content":[],
 "content":["（1）已知集合$$math_a42a8ed0-84d0-4956-93a2-bfbc4170c0ce*72*20.15$$，$$math_156c196e-f13a-4a3e-a47d-7054ee766e19*43.2*17.3$$. 若$$math_0fdba542-306d-4f1a-8e09-268b5fc2c9f3*50.1*13.8$$，则$$math_381141c9-c167-465d-a8f6-55b829da0cdb*9.2*9.8$$的取值范围是"],
 
 "created_at":"2014-12-15T11:03:03.717+08:00",
 "inline_images":[],
 "items":["$$math_425b1362-e9fb-415e-8db7-27964afe9a41*48.95*15$$","$$math_fee42357-09f0-4200-bdc0-440c67a3c234*38*15$$","$$math_01e99f6e-5205-4758-bbc8-8e97e2260dd4*32.85*15$$","$$math_38bd632d-b9ad-4914-959d-310ade2c39ed*91*15$$"],
 "last_update_time":1418613029,
 "preview":true,
 "q_figures":[],
 "question_id":"5471b33e692d3556421c0000",
 "question_str":"（1）已知集合$$math_a42a8ed0-84d0-4956-93a2-bfbc4170c0ce*72*20.15$$，$$math_156c196e-f13a-4a3e-a47d-7054ee766e19*43.2*17.3$$. 若$$math_0fdba542-306d-4f1a-8e09-268b5fc2c9f3*50.1*13.8$$，则$$math_381141c9-c167-465d-a8f6-55b829da0cdb*9.2*9.8$$的取值范围是$$math_425b1362-e9fb-415e-8db7-27964afe9a41*48.95*15$$$$math_fee42357-09f0-4200-bdc0-440c67a3c234*38*15$$$$math_01e99f6e-5205-4758-bbc8-8e97e2260dd4*32.85*15$$$$math_38bd632d-b9ad-4914-959d-310ade2c39ed*91*15$$",
 "subject":2,
 "summary":"",
 "tag":"不懂",
 "tag_set":"不懂,不会,不对,典型题",
 "topic_ids":["548e4f67692d354ebf020000","540c0c1498c83a89c1000002"],
 "topic_str":"三角函数,集合",
 "type":"choice",
 "updated_at":"2014-12-15T11:10:29.409+08:00",
 "user_id":"546ee90f98c83a8ae1000002"
 }
 
 */
