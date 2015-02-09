//
//  NetWorkTaskGetTeachers.m
//  EFei
//
//  Created by Xiangzhen Kong on 11/21/14.
//
//

#import "NetWorkTaskGetTeachers.h"
#import "EFei.h"
#import "TaskManager.h"
#import "SearchTeacherController.h"

static NSString* kRsquestScopeKey         = @"scope";
static NSString* kRequestNameKey          = @"name";
static NSString* kRequesteSubjectKey      = @"subject";

static NSString* kResponseTeachersKey     = @"teachers";

static NSString* kResponseIdKey           = @"id";
static NSString* kResponseNameKey         = @"name";
static NSString* kResponseSubjectKey      = @"subject";
static NSString* kResponseSchoolKey       = @"school";
static NSString* kResponseDescKey         = @"desc";
static NSString* kResponseAvatarKey       = @"avatar";


static NSString* kResponseTeacherClassesKey      = @"classes";
static NSString* kResponseTeacherClassIdKey      = @"id";
static NSString* kResponseTeacherClassNameKey    = @"name";
static NSString* kResponseTeacherClassDescKey    = @"desc";


@implementation NetWorkTaskGetTeachers

+ (void) load
{
    [[TaskManager instance] registeTaskClass:[self class] withType:NetWorkTaskTypeGetTeachers];
}

- (id) init
{
    self = [super init];
    if (self)
    {
        self.taskType = NetWorkTaskTypeGetTeachers;
        self.httpMethod = HttpMethodGet;
        self.path = @"student/teachers";
    }
    return self;
}

- (void) prepareParameter
{
    GetTeacherInfo* info = (GetTeacherInfo*)self.data;
    [self.parameterDict setValue:[NSNumber numberWithInteger:info.scope] forKey:kRsquestScopeKey];
    
    if (info.scope == 0)
    {
        [self.parameterDict setValue:info.name forKey:kRequestNameKey];
        [self.parameterDict setValue:[NSNumber numberWithInteger:info.subject] forKey:kRequesteSubjectKey];
    }
}

- (BOOL) parseResultDict:(NSDictionary *)dict
{
    GetTeacherInfo* info = (GetTeacherInfo*)self.data;
    NSArray* teachers = [dict objectForKey:kResponseTeachersKey];
    
    if (![teachers isKindOfClass:[NSArray class]])
    {
        return NO;
    }
    
    if (info.scope == 1)
    {
        [[EFei instance].user clearTeacherList];
    }
    else
    {
        [[SearchTeacherController instance] clearTeacherList];
    }
    
    
    for (NSDictionary* teacherDict in teachers)
    {
        NSString* teacherId = [teacherDict objectForKey:kResponseIdKey];
        NSString* name = [teacherDict objectForKey:kResponseNameKey];
        SubjectType subject = [[teacherDict objectForKey:kResponseSubjectKey] integerValue];
        NSString* school = [teacherDict objectForKey:kResponseSchoolKey];
        NSString* desc = [teacherDict objectForKey:kResponseDescKey];
        NSString* avatar = [teacherDict objectForKey:kResponseAvatarKey];
        
        Teacher* teacher = [[Teacher alloc] initWithId:teacherId
                                                  name:name
                                               subject:subject
                                                school:school
                                           description:desc
                                                avatar:avatar
                                               classes:nil];
        
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
        
        // TODO: save search teacher results.
        
        if (info.scope == 1)
        {
            [[EFei instance].user addTeacher:teacher];
        }
        else
        {
            [[SearchTeacherController instance] addTeacher:teacher];
        }
        
        
        NSLog(@"NetWorkTaskGetUserInfo:  %@", name);
    }
    
    return YES;
}


@end

