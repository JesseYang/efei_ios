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

static NSString* kResponseIdKey           = @"id";
static NSString* kResponseNameKey         = @"name";
static NSString* kResponseSubjectKey      = @"subject";
static NSString* kResponseSchoolKey       = @"school";
static NSString* kResponseDescKey         = @"desc";
static NSString* kResponseAvatarKey       = @"avatar";


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
        self.path = @"student/students/teachers";
    }
    return self;
}

- (BOOL) parseResultDict:(NSDictionary *)dict
{
    NSInteger teacherId = [[dict objectForKey:kResponseIdKey] integerValue];
    NSString* name = [dict objectForKey:kResponseNameKey];
    NSString* subject = [dict objectForKey:kResponseSubjectKey];
    NSString* school = [dict objectForKey:kResponseSchoolKey];
    NSString* desc = [dict objectForKey:kResponseDescKey];
    NSString* avatar = [dict objectForKey:kResponseAvatarKey];
    
    Teacher* teacher = [[Teacher alloc] initWithId:teacherId
                                              name:name
                                           subject:subject
                                            school:school
                                       description:desc
                                            avatar:avatar];
    
    // TODO: save search teacher results.
    
    [[EFei instance].user addTeacher:teacher];
    
    NSLog(@"NetWorkTaskGetUserInfo:  %@", name);
    
    return YES;
}


@end

