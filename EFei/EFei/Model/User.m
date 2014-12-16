//
//  User.m
//  EFei
//
//  Created by Xiangzhen Kong on 11/18/14.
//
//

#import "User.h"
#import "Teacher.h"

@interface User ()
{
    NSMutableArray* _teachers;
}

@end

@implementation User

- (id) init
{
    self = [super init];
    if (self)
    {
        _teachers = [[NSMutableArray alloc] init];
        
        self.name = @"";
        self.email = @"";
        self.mobile = @"";
    }
    return self;
}

- (void) addTeacher:(Teacher*)teacher
{
    [_teachers addObject:teacher];
}

- (void) deleteTeacherWithId:(NSInteger)teacherId
{
    
}

- (Teacher*) teacherWithId:(NSInteger)teacherId
{
    for (Teacher* t in _teachers)
    {
        if (t.teacherId == teacherId)
        {
            return t;
        }
    }
    return nil;
}

@end
