//
//  Teacher.h
//  EFei
//
//  Created by Xiangzhen Kong on 11/21/14.
//
//

#import <Foundation/Foundation.h>
#import "Topics.h"


@interface TeacherClass : NSObject

@property (nonatomic, copy) NSString* classId;
@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* desc;

@end


@interface Teacher : NSObject

@property (nonatomic, copy) NSString* teacherId;
@property (nonatomic, assign) NSInteger classId;
@property (nonatomic, copy) NSString* name;
@property (nonatomic, assign) SubjectType subjectType;
@property (nonatomic, copy) NSString* subjectName;
@property (nonatomic, copy) NSString* school;
@property (nonatomic, copy) NSString* desc;
@property (nonatomic, copy) NSString* avatar;
@property (nonatomic, strong) NSArray* classes;

- (id) initWithId:(NSString*)teacherId
             name:(NSString*)name
          subject:(SubjectType)subject
           school:(NSString*)school
      description:(NSString*)desc
           avatar:(NSString*)avatar
          classes:(NSArray*)classes;

@end

