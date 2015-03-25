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
#import "AddTeacherController.h"

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
        self.path = @"student/teachers";
    }
    return self;
}

- (void) prepareParameter
{
    Teacher* teacher = (Teacher*)self.data;
    
    [self.parameterDict setValue:teacher.teacherId forKey:kReqeustTeacherIdKey];
    if (teacher.classId.length > 0)
    {
        [self.parameterDict setValue:teacher.classId forKey:kReqeustClassIdKey];
    }
}


- (BOOL) parseResultDict:(NSDictionary *)dict
{
    
    return YES;
}

- (void) sucess
{
    Teacher* teacher = (Teacher*)self.data;
    
    [[AddTeacherController instance] removeTeacher:teacher];
    
    [super sucess];
    
    
    [[EFei instance].user addTeacher:teacher];
}


@end


