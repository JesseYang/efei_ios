//
//  AddTeacherController.h
//  EFei
//
//  Created by Xiangzhen Kong on 2/6/15.
//
//

#import <Foundation/Foundation.h>
#import "Teacher.h"

@interface AddTeacherController : NSObject

@property (nonatomic, strong) NSMutableArray* teachersToAdd;

+ (AddTeacherController*) instance;

- (void) addTeacher:(Teacher*)teacherToAdd;
- (void) removeTeacher:(Teacher*)teacher;
- (void) clearTeachers;

@end
