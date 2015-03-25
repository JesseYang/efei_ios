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
#import "GetQuestionController.h"
#import "AddTeacherController.h"

static NSString* kRequestQuestionIdKey        = @"question_id";
static NSString* kRequestQuestionIdsKey       = @"question_ids";
static NSString* kRequestNoteTagKey           = @"tag";
static NSString* kRequestNoteTopicsKey        = @"topics";
static NSString* kRequestNoteSummaryKey       = @"summary";
static NSString* kRequestHomeworkIdKey        = @"homework_id";


static NSString* kResponseNoteKey              = @"note";
static NSString* kResponseNoteUpdateTimeKey    = @"note_update_time";
static NSString* kResponseTeacherKey           = @"teacher";
static NSString* kResponseTeachersKe           = @"teachers";


static NSString* kResponseTeacherIdKey           = @"id";
static NSString* kResponseTeacherNameKey         = @"name";
static NSString* kResponseTeacherSubjectKey      = @"subject";
static NSString* kResponseTeacherSchoolKey       = @"school";
static NSString* kResponseTeacherDescKey         = @"desc";
static NSString* kResponseTeacherAvatarKey       = @"avatar";


static NSString* kResponseTeacherClassesKey      = @"classes";
static NSString* kResponseTeacherClassIdKey      = @"id";
static NSString* kResponseTeacherClassNameKey    = @"name";
static NSString* kResponseTeacherClassDescKey    = @"desc";

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
    [self.parameterDict setObject:note.homeworkId forKey:kRequestHomeworkIdKey];
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
    
    if([dict objectForKey:kResponseItemsKey] != [NSNull null])
    {
        note.items = [dict objectForKey:kResponseItemsKey];
    }
    
    note.contents = [noteDict objectForKey:kResponseContentKey];
    note.answerContents = [noteDict objectForKey:kResponseAnswerContentKey];
    note.updateTime = [[noteDict objectForKey:kResponseLastUpdateTimeKey] integerValue];
    note.questionType = [[noteDict objectForKey:kResponseQuestionTypeKey] integerValue];
    note.subjectType = [[noteDict objectForKey:kResponseSubjectKey] integerValue];
    note.summary = [noteDict objectForKey:kResponseSummaryKey];
    note.tag = [noteDict objectForKey:kResponseTagKey];
    note.tagsetString = [noteDict objectForKey:kResponseTagSetKey];
    note.topicString = [noteDict objectForKey:kResponseTopicStrKey];
    note.createTime = [noteDict objectForKey:kResponseCreatedAtKey];
    note.lastUpdateTime = [noteDict objectForKey:kResponseUpdatedAtKey];
    note.imagePath = [noteDict objectForKey:kResponseImagePathKey];
    
    note.updated = YES;
    
    // Teacher
    NSDictionary* teacherDict = [dict objectForKey:kResponseTeacherKey];
    if ([teacherDict isKindOfClass:[NSDictionary class]])
    {
        Teacher* teacher = [[Teacher alloc] init];
        teacher.teacherId   = [teacherDict objectForKey:kResponseTeacherIdKey];
        teacher.name        = [teacherDict objectForKey:kResponseTeacherNameKey];
        teacher.subjectType = [[teacherDict objectForKey:kResponseTeacherSubjectKey] integerValue];
        teacher.school      = [teacherDict objectForKey:kResponseTeacherSchoolKey];
        
        NSArray* classes = [teacherDict objectForKey:kResponseTeacherClassesKey];
        if ([classes isKindOfClass:[NSArray class]])
        {
            NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:classes.count];
            for (NSDictionary* cDict in classes)
            {
                TeacherClass* teacherClass = [[TeacherClass alloc] init];
                teacherClass.classId = [cDict objectForKey:kResponseTeacherClassIdKey];
                teacherClass.name    = [cDict objectForKey:kResponseTeacherClassNameKey];
                teacherClass.desc    = [cDict objectForKey:kResponseTeacherClassDescKey];
                
                [array addObject:teacherClass];
            }
         
            teacher.classes = array;
        }
        
        if (![[EFei instance].user hasTeacher:teacher.teacherId] &&
            ![[EFei instance].user isIgnoreTeacher:teacher.teacherId] )
        {
            [[AddTeacherController instance] clearTeachers];
            [[AddTeacherController instance] addTeacher:teacher];
        }
    }
    
    
    [[EFei instance].notebook addNote:note];
    [EFei instance].newNotesAdded = YES;
    
    [GetQuestionController instance].currentNote = nil;
    
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
