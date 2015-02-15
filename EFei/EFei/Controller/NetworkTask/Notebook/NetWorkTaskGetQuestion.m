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
#import "GetQuestionController.h"

static NSString* kResponseNoteIdKey            = @"note_id";
static NSString* kResponseIdKey                = @"_id";
static NSString* kResponseSubjectKey           = @"subject";
static NSString* kResponseQuestionTypeKey      = @"type";
static NSString* kResponseContentKey           = @"content";
static NSString* kResponseItemsKey             = @"items";
static NSString* kResponseAnswerKey            = @"answer";
static NSString* kResponseAnswerContentKey     = @"answer_content";
static NSString* kResponseTagSetKey            = @"tag_set";
static NSString* kResponseImagePathKey         = @"image_path";

static NSString* kResponseTagSetSeparator     = @",";


//static NSString* kResponseAFiguresKey          = @"a_figures";
//static NSString* kResponseCreatedAtKey         = @"created_at";
//static NSString* kResponseInlineImagesKey      = @"inline_images";
//static NSString* kResponseLastUpdateTimeKey    = @"last_update_time";
//static NSString* kResponsePreviewKey           = @"preview";
//static NSString* kResponseQFiguresKey          = @"q_figures";
//static NSString* kResponseQuestionStrKey       = @"question_str";
//static NSString* kResponseQuestionTypeKey      = @"question_type";
//static NSString* kResponseSummaryKey           = @"summary";
//static NSString* kResponseTagKey               = @"tag";
//static NSString* kResponseTopicIdsKey          = @"topic_ids";
//static NSString* kResponseUpdatedAtKey         = @"updated_at";
//static NSString* kResponseUserIdKey            = @"user_id";

/*
 
 Example

{
 "id":"5471b33e692d3556421c0000",
 "subject":2,
 "type":"choice",
 "content":["（1）已知集合$$math_a42a8ed0-84d0-4956-93a2-bfbc4170c0ce*72*20.15$$，$$math_156c196e-f13a-4a3e-a47d-7054ee766e19*43.2*17.3$$. 若$$math_0fdba542-306d-4f1a-8e09-268b5fc2c9f3*50.1*13.8$$，则$$math_381141c9-c167-465d-a8f6-55b829da0cdb*9.2*9.8$$的取值范围是"],
 "items":["$$math_425b1362-e9fb-415e-8db7-27964afe9a41*48.95*15$$","$$math_fee42357-09f0-4200-bdc0-440c67a3c234*38*15$$","$$math_01e99f6e-5205-4758-bbc8-8e97e2260dd4*32.85*15$$","$$math_38bd632d-b9ad-4914-959d-310ade2c39ed*91*15$$"],
 "answer":null,
 "answer_content":[],
 "tag_set":"不懂,不会,不对,典型题",
 "success":true,
 "auth_key":"9eWXA9uQgH2YKPrOkoo2wsL9C2PwSY-cJzweEzAPDuh6ayI4uD_9Y_pOm-tx-Rnj"
 }

*/
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
    GetQuestionController* controller = (GetQuestionController*)self.data;
    self.path = [NSString stringWithFormat:@"%@/%@", self.path, controller.questionId];
}


- (BOOL) parseResultDict:(NSDictionary *)dict
{
    GetQuestionController* controller = (GetQuestionController*)self.data;
    NSString* noteId = [dict objectForKey:kResponseNoteIdKey];
    if (noteId.length > 0)
    {
        NSLog(@"NetWorkTaskGetQuestion: note id: %@", noteId);
        
        Note* note = [[EFei instance].notebook noteWithId:noteId];
        controller.currentNote = note;
        return YES;
    }
    
    Question* question = [[Question alloc] init];
    question.questionId = [dict objectForKey:kResponseIdKey];
    
    NSLog(@"--------------------------------------------");
    NSLog(@"%@", [dict objectForKey:kResponseIdKey]);
    NSLog(@"%@", question.questionId);
    NSLog(@"%@", question);
    NSLog(@"--------------------------------------------");
    
    if([dict objectForKey:kResponseAnswerKey] != [NSNull null])
    {
        question.answer = [[dict objectForKey:kResponseAnswerKey] integerValue];
    }
    question.contents = [dict objectForKey:kResponseContentKey];
    question.answerContents = [dict objectForKey:kResponseAnswerContentKey];
    question.items = [dict objectForKey:kResponseItemsKey];
    question.answerContents = [dict objectForKey:kResponseAnswerContentKey];
    question.answerContents = [dict objectForKey:kResponseAnswerContentKey];
    question.questionTypeString = [dict objectForKey:kResponseQuestionTypeKey];
    question.subjectType = [[dict objectForKey:kResponseSubjectKey] integerValue];
    question.imagePath = [dict objectForKey:kResponseImagePathKey];
    
    NSString* tagSet = [dict objectForKey:kResponseTagSetKey];
    question.tags = [tagSet componentsSeparatedByString:kResponseTagSetSeparator];
    
    controller.currentNote = [[Note alloc] initWithQuestion:question];
    
    return YES;
}

@end
