//
//  SearchTeacherController.h
//  EFei
//
//  Created by Xiangzhen Kong on 1/8/15.
//
//

#import <Foundation/Foundation.h>
#import "Teacher.h"

@interface SearchTeacherController : NSObject

+ (SearchTeacherController*) instance;

@property (nonatomic, readonly) NSArray* searchedTeachers;
@property (nonatomic, readonly) Teacher* teacherToAdd;

- (void) clearTeacherList;
- (void) addTeacher:(Teacher*)teacher;

- (void) selectSearchedTeacher:(NSInteger)index;

@end
