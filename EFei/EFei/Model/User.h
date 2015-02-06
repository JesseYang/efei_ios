//
//  User.h
//  EFei
//
//  Created by Xiangzhen Kong on 11/18/14.
//
//

#import <Foundation/Foundation.h>

@class Teacher;

@interface User : NSObject

@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* mobile;
@property (nonatomic, copy) NSString* email;

@property (nonatomic, readonly) NSArray* teachers;

- (void) clearTeacherList;
- (void) addTeacher:(Teacher*)teacher;
- (void) deleteTeacher:(Teacher*)teacher;
- (void) deleteTeacherWithId:(NSString*)teacherId;
- (Teacher*) teacherWithId:(NSString*)teacherId;

- (BOOL) hasTeacher:(NSString*)teacherId;
- (BOOL) isIgnoreTeacher:(NSString*)teacherId;
- (void) addIgnoreTeacher:(NSString*)teacherId;

@end
