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

- (void) addTeacher:(Teacher*)teacher;
- (void) deleteTeacherWithId:(NSInteger)teacherId;
- (Teacher*) teacherWithId:(NSInteger)teacherId;

@end
