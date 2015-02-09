//
//  UserCommand.h
//  EFei
//
//  Created by Xiangzhen Kong on 11/19/14.
//
//

#import <Foundation/Foundation.h>
#import "TaskManager.h"
#import "Controller.h"
#import "Topics.h"

//////////////////////////////////////////////////////////////////////////////////////

@interface UserCommand : NSObject

@end

//////////////////////////////////////////////////////////////////////////////////////

@interface GetUserInfoCommand : NSObject

+ (void) executeWithCompleteHandler:(CompletionBlock)handler;

@end


//////////////////////////////////////////////////////////////////////////////////////


@interface GetTeachersCommand : NSObject

+ (void) executeWithCompleteHandler:(CompletionBlock)handler;
+ (void) executeWithSubject:(NSInteger)subject name:(NSString*)name completeHandler:(CompletionBlock)handler;

@end

//////////////////////////////////////////////////////////////////////////////////////

@class Teacher;

@interface AddTeacherCommand : NSObject

+ (void) executeWithTeacher:(Teacher*)teacher completeHandler:(CompletionBlock)handler;

@end

//////////////////////////////////////////////////////////////////////////////////////

@interface RemoveTeacherCommand : NSObject

+ (void) executeWithTeacher:(Teacher*)teacher completeHandler:(CompletionBlock)handler;

@end

//////////////////////////////////////////////////////////////////////////////////////

@interface RenameCommand : NSObject

+ (void) executeWithName:(NSString*)name completeHandler:(CompletionBlock)handler;

@end

//////////////////////////////////////////////////////////////////////////////////////

@interface UpdateEmailCommand : NSObject

+ (void) executeWithEmail:(NSString*)email completeHandler:(CompletionBlock)handler;

@end


//////////////////////////////////////////////////////////////////////////////////////

@interface UpdatePhoneNumberCommand : NSObject

+ (void) executeWithNumber:(NSString*)phone completeHandler:(CompletionBlock)handler;

@end

//////////////////////////////////////////////////////////////////////////////////////

@interface UpdatePhoneSendVerifyCodeCommand : NSObject

+ (void) executeWithVerifyCode:(NSString*)code completeHandler:(CompletionBlock)handler;

@end

//////////////////////////////////////////////////////////////////////////////////////


@interface SendFeedbackCommand : NSObject

+ (void) executeWithFeedback:(NSString*)feedback completeHandler:(CompletionBlock)handler;

@end

//////////////////////////////////////////////////////////////////////////////////////


