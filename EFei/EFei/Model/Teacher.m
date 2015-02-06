//
//  Teacher.m
//  EFei
//
//  Created by Xiangzhen Kong on 11/21/14.
//
//

#import "Teacher.h"
#import "EFei.h"

@implementation TeacherClass


@end



@implementation Teacher

- (id) initWithId:(NSString*)teacherId
             name:(NSString*)name
          subject:(SubjectType)subject
           school:(NSString*)school
      description:(NSString*)desc
           avatar:(NSString*)avatar
          classes:(NSArray*)classes
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
        self.classes = classes;
        
        self.subjectName = [[EFei instance].subjectManager subjectNameWithType:self.subjectType];
    }
    return self;
}

- (void) setSubjectType:(SubjectType)subjectType
{
    _subjectType = subjectType;
    
    self.subjectName = [[EFei instance].subjectManager subjectNameWithType:_subjectType];
}

@end

