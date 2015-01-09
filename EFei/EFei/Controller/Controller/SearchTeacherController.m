//
//  SearchTeacherController.m
//  EFei
//
//  Created by Xiangzhen Kong on 1/8/15.
//
//

#import "SearchTeacherController.h"

@interface SearchTeacherController()
{
    NSMutableArray* _searchedTeachers;
    Teacher* _teacherToAdd;
}

@end

@implementation SearchTeacherController

+ (SearchTeacherController*) instance
{
    static SearchTeacherController* _instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _instance = [[SearchTeacherController alloc] init];
    });
    
    return _instance;
}

- (id) init
{
    self = [super init];
    if (self)
    {
        _searchedTeachers = [[NSMutableArray alloc] init];
    }
    return self;
}


- (void) clearTeacherList
{
    [_searchedTeachers removeAllObjects];
}

- (void) addTeacher:(Teacher*)teacher
{
    [_searchedTeachers addObject:teacher];
}

- (void) selectSearchedTeacher:(NSInteger)index
{
    if (index >=0 && index < _searchedTeachers.count)
    {
        _teacherToAdd = [_searchedTeachers objectAtIndex:index];
    }
}

@end
