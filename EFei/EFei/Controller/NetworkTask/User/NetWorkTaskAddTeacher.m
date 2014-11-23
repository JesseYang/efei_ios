//
//  NetWorkTaskAddTeacher.m
//  EFei
//
//  Created by Xiangzhen Kong on 11/21/14.
//
//

#import "NetWorkTaskAddTeacher.h"
#import "EFei.h"
#import "TaskManager.h"

static NSString* kReqeustTeacherIdKey           = @"teacher_id";
static NSString* kReqeustClassIdKey           = @"class_id";


@implementation NetWorkTaskAddTeacher

+ (void) load
{
    [[TaskManager instance] registeTaskClass:[self class] withType:NetWorkTaskTypeAddTeacher];
}

- (id) init
{
    self = [super init];
    if (self)
    {
        self.taskType = NetWorkTaskTypeAddTeacher;
        self.httpMethod = HttpMethodPost;
        self.path = @"student/students/teachers";
    }
    return self;
}

- (void) prepareParameter
{
    AddRemoveTeacherInfo* info = (AddRemoveTeacherInfo*)self.data;
    
    [self.parameterDict setValue:[NSNumber numberWithInteger:info.teacherId] forKey:kReqeustTeacherIdKey];
    if (info.classId > 0)
    {
        [self.parameterDict setValue:[NSNumber numberWithInteger:info.classId] forKey:kReqeustTeacherIdKey];
    }
}


- (BOOL) parseResultDict:(NSDictionary *)dict
{
    
    return YES;
}


@end


