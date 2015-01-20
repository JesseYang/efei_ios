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

- (void) setEmail:(NSString *)email
{
    if (email != nil)
    {
        _email  = [email copy];
    }
    else
    {
        _email = @"";
    }
}

- (void) setName:(NSString *)name
{
    if (name != nil)
    {
        _name  = [name copy];
    }
    else
    {
        _name = @"";
    }
}

- (void) setMobile:(NSString *)mobile
{
    if (mobile != nil)
    {
        _mobile  = [mobile copy];
    }
    else
    {
        _mobile = @"";
    }
}

- (void) clearTeacherList
{
    [_teachers removeAllObjects];
}

- (void) addTeacher:(Teacher*)teacher
{
    [_teachers addObject:teacher];
}

- (void) deleteTeacher:(Teacher *)teacher
{
    [_teachers removeObject:teacher];
}

- (void) deleteTeacherWithId:(NSString*)teacherId
{
    for (Teacher* t in _teachers)
    {
        if ([t.teacherId isEqualToString:teacherId])
        {
            [_teachers removeObject:t];
            break;
        }
    }
}

- (Teacher*) teacherWithId:(NSString*)teacherId
{
    for (Teacher* t in _teachers)
    {
        if ([t.teacherId isEqualToString:teacherId])
        {
            return t;
        }
    }
    return nil;
}

@end
