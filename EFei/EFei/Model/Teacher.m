//
//  Teacher.m
//  EFei
//
//  Created by Xiangzhen Kong on 11/21/14.
//
//

#import "Teacher.h"

@implementation Teacher

- (id) initWithId:(NSInteger)teacherId
             name:(NSString*)name
          subject:(NSString*)subject
           school:(NSString*)school
      description:(NSString*)desc
           avatar:(NSString*)avatar
{
    self = [self init];
    if (self)
    {
        self.teacherId = teacherId;
        self.name = name;
        self.subject = subject;
        self.school = school;
        self.desc = desc;
        self.avatar = avatar;
    }
    return self;
}

@end

