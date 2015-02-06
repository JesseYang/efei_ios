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

@property (nonatomic, strong) Teacher* teacherToAdd;

+ (AddTeacherController*) instance;

@end
