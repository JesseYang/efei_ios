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
#import "AddTeacherController.h"

static NSString* kRequestQuestionIdKey        = @"question_id";
static NSString* kRequestQuestionIdsKey       = @"question_ids";
static NSString* kRequestNoteTagKey           = @"tag";
static NSString* kRequestNoteTopicsKey        = @"topics";
static NSString* kRequestNoteSummaryKey       = @"summary";
static NSString* kRequestHomeworkIdsKey       = @"homework_ids";


static NSString* kResponseNoteKey              = @"note";
static NSString* kResponseNoteIds              = @"note_ids";
static NSString* kResponseNoteUpdateTimeKey    = @"note_update_time";
static NSString* kResponseTeacherKey           = @"teacher";
static NSString* kResponseTeachersKey          = @"teachers";


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

@interface NetWorkTaskAddQuestionList()
{
    NSArray* _noteIds;
}

@end

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
    _noteIds = nil;
    
    NSArray* array = (NSArray*)self.data;
    
    NSMutableArray* ids = [[NSMutableArray alloc] initWithCapacity:array.count];
    NSMutableArray* hIds = [[NSMutableArray alloc] initWithCapacity:array.count];
    for (Question* q in array)
    {
        [ids addObject:q.questionId];
        [hIds addObject:q.homeworkId];
    }
    
    [self.parameterDict setObject:ids forKey:kRequestQuestionIdsKey];
    [self.parameterDict setObject:hIds forKey:kRequestHomeworkIdsKey];
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
    NSLog(@"NetWorkTaskAddQuestionList:  %@  %ld", subject, time);
    
    _noteIds = [dict objectForKey:kResponseNoteIds];
    
    NSLog(@"NetWorkTaskAddQuestionList ids: %@", _noteIds);
    
    // Teacher
    NSDictionary* teacherDict = [dict objectForKey:kResponseTeacherKey];
    if ([teacherDict isKindOfClass:[NSDictionary class]])
    {
        Teacher* teacher = [[Teacher alloc] init];
        teacher.teacherId   = [teacherDict objectForKey:kResponseTeacherIdKey];
        teacher.name        = [teacherDict objectForKey:kResponseTeacherIdKey];
        teacher.subjectType = [[teacherDict objectForKey:kResponseTeacherIdKey] integerValue];
        teacher.school      = [teacherDict objectForKey:kResponseTeacherIdKey];
        
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
        
        [AddTeacherController instance].teacherToAdd = teacher;
    }
    
    return YES;
}

- (void) sucess
{
    [super sucess];
    
    NSArray* array = (NSArray*)self.data;
//    for (Question* q in array)
//    {
//        Note* note = [[Note alloc] initWithQuestion:q];
//        [[EFei instance].notebook addNote:note];
//    }

    for (int i=0; i<array.count; i++)
    {
        Question* q = [array objectAtIndex:i];
        Note* note = [[Note alloc] initWithQuestion:q];
        [[EFei instance].notebook addNote:note];
        if (i < _noteIds.count)
        {
            note.noteId = [_noteIds objectAtIndex:i];
        }
    }
    
    
    [EFei instance].newNotesAdded = YES;
}

@end