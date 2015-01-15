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
        self.path = @"student/teachers";
    }
    return self;
}

- (void) prepareParameter
{
    Teacher* teacher = (Teacher*)self.data;
    self.path = [NSString stringWithFormat:@"%@/%@", self.path, teacher.teacherId];
}


- (BOOL) parseResultDict:(NSDictionary *)dict
{
    return YES;
}


- (void) sucess
{
    [super sucess];
    
    Teacher* teacher = (Teacher*)self.data;
    [[EFei instance].user deleteTeacher:teacher];
}

@end

