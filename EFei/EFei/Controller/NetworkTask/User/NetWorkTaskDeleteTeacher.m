//
//  NetWorkTaskDeleteTeacher.m
//  EFei
//
//  Created by Xiangzhen Kong on 11/21/14.
//
//

#import "NetWorkTaskDeleteTeacher.h"
#import "EFei.h"
#import "TaskManager.h"

static NSString* kReqeustTeacherIdKey           = @"teacher_id";


@implementation NetWorkTaskDeleteTeacher

+ (void) load
{
    [[TaskManager instance] registeTaskClass:[self class] withType:NetWorkTaskTypeDeleteTeacher];
}

- (id) init
{
    self = [super init];
    if (self)
    {
        self.taskType = NetWorkTaskTypeDeleteTeacher;
        self.httpMethod = HttpMethodDelete;
        self.path = @"student/students/teachers";
    }
    return self;
}

- (void) prepareParameter
{
    AddRemoveTeacherInfo* info = (AddRemoveTeacherInfo*)self.data;
    self.path = [NSString stringWithFormat:@"%@/%ld", self.path, info.teacherId];
}


- (BOOL) parseResultDict:(NSDictionary *)dict
{
    return YES;
}


@end

