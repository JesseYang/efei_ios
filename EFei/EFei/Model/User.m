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
    NSMutableDictionary* _teachersDict;
    
    NSMutableArray* _ignoredTeachers;
}

@end

@implementation User

- (id) init
{
    self = [super init];
    if (self)
    {
        _teachersDict = [[NSMutableDictionary alloc] init];
        _ignoredTeachers = [[NSMutableArray alloc] init];
        
        self.name = @"";
        self.email = @"";
        self.mobile = @"";
    }
    return self;
}

- (void) setEmail:(NSString *)email
{
    if (email != nil && [email isKindOfClass:[NSString class]])
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
    if (name != nil && [name isKindOfClass:[NSString class]])
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
    if (mobile != nil && [mobile isKindOfClass:[NSString class]])
    {
        _mobile  = [mobile copy];
    }
    else
    {
        _mobile = @"";
    }
}

- (NSArray*)teachers
{
    return _teachersDict.allValues;
}

- (void) clearTeacherList
{
    [_teachersDict removeAllObjects];
}

- (void) addTeacher:(Teacher*)teacher
{
    _teachersDict[teacher.teacherId] = teacher;
}

- (void) deleteTeacher:(Teacher *)teacher
{
    [_teachersDict removeObjectForKey:teacher.teacherId];
}

- (void) deleteTeacherWithId:(NSString*)teacherId
{
    [_teachersDict removeObjectForKey:teacherId];
    
}

- (Teacher*) teacherWithId:(NSString*)teacherId
{
    return _teachersDict[teacherId];
}

- (BOOL) hasTeacher:(NSString*)teacherId
{
    return [self teacherWithId:teacherId] != nil;
}

- (BOOL) isIgnoreTeacher:(NSString*)teacherId
{
    return [_ignoredTeachers containsObject:teacherId];
}

- (void) addIgnoreTeacher:(NSString*)teacherId
{
    [_ignoredTeachers addObject:teacherId];
}

@end
