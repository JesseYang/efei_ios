//
//  AddTeacherController.m
//  EFei
//
//  Created by Xiangzhen Kong on 2/6/15.
//
//

#import "AddTeacherController.h"

@implementation AddTeacherController

+ (AddTeacherController*) instance
{
    static AddTeacherController* _instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _instance = [[AddTeacherController alloc] init];
    });
    
    return _instance;
}

- (id) init
{
    self = [super init];
    if (self)
    {
        self.teachersToAdd = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) addTeacher:(Teacher *)teacherToAdd
{
    [self.teachersToAdd addObject:teacherToAdd];
}

- (void) removeTeacher:(Teacher *)teacher
{
    [self.teachersToAdd removeObject:teacher];
}

- (void) clearTeachers
{
    [self.teachersToAdd removeAllObjects];
}

@end
