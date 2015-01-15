//
//  Teacher.m
//  EFei
//
//  Created by Xiangzhen Kong on 11/21/14.
//
//

#import "Teacher.h"
#import "EFei.h"

@implementation Teacher

- (id) initWithId:(NSString*)teacherId
             name:(NSString*)name
          subject:(SubjectType)subject
           school:(NSString*)school
      description:(NSString*)desc
           avatar:(NSString*)avatar
{
    self = [self init];
    if (self)
    {
        self.teacherId = teacherId;
        self.name = name;
        self.subjectType = subject;
        self.school = school;
        self.desc = desc;
        self.avatar = avatar;
        
        self.subjectName = [[EFei instance].subjectManager subjectNameWithType:self.subjectType];
    }
    return self;
}

@end

