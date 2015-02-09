//
//  UserCommand.m
//  EFei
//
//  Created by Xiangzhen Kong on 11/19/14.
//
//

#import "UserCommand.h"
#import "EFei.h"

//////////////////////////////////////////////////////////////////////////////////////

@implementation UserCommand

@end


//////////////////////////////////////////////////////////////////////////////////////

@implementation GetUserInfoCommand

+ (void) executeWithCompleteHandler:(CompletionBlock)handler
{
    [[TaskManager instance] startNetworkTask:NetWorkTaskTypeGetUserInfo
                                    withData:nil
                             completeHandler:handler];
}
@end

//////////////////////////////////////////////////////////////////////////////////////

@implementation GetTeachersCommand

+ (void) executeWithCompleteHandler:(CompletionBlock)handler
{
    GetTeacherInfo* info = [[GetTeacherInfo alloc] init];
    info.scope = 1;
    
    [[TaskManager instance] startNetworkTask:NetWorkTaskTypeGetTeachers
                                    withData:info
                             completeHandler:handler];
}

+ (void) executeWithSubject:(NSInteger)subject name:(NSString*)name completeHandler:(CompletionBlock)handler
{
    GetTeacherInfo* info = [[GetTeacherInfo alloc] init];
    info.scope = 0;
    info.subject = subject;
    info.name = name;
    
    [[TaskManager instance] startNetworkTask:NetWorkTaskTypeGetTeachers
                                    withData:info
                             completeHandler:handler];
}

@end

//////////////////////////////////////////////////////////////////////////////////////

@implementation AddTeacherCommand

+ (void) executeWithTeacher:(Teacher *)teacher completeHandler:(CompletionBlock)handler
{
    [[TaskManager instance] startNetworkTask:NetWorkTaskTypeAddTeacher
                                    withData:teacher
                             completeHandler:handler];
}
@end

//////////////////////////////////////////////////////////////////////////////////////

@implementation RemoveTeacherCommand

+ (void) executeWithTeacher:(Teacher *)teacher completeHandler:(CompletionBlock)handler
{
    [[TaskManager instance] startNetworkTask:NetWorkTaskTypeDeleteTeacher
                                    withData:teacher
                             completeHandler:handler];
}
@end

//////////////////////////////////////////////////////////////////////////////////////

@implementation RenameCommand

+ (void) executeWithName:(NSString *)name completeHandler:(CompletionBlock)handler
{
    [[TaskManager instance] startNetworkTask:NetWorkTaskTypeRename
                                    withData:name
                             completeHandler:handler];
}
@end

//////////////////////////////////////////////////////////////////////////////////////

@implementation UpdateEmailCommand

+ (void) executeWithEmail:(NSString *)email completeHandler:(CompletionBlock)handler
{
    [[TaskManager instance] startNetworkTask:NetWorkTaskTypeChangeEmail
                                    withData:email
                             completeHandler:handler];
}
@end

//////////////////////////////////////////////////////////////////////////////////////

@implementation UpdatePhoneNumberCommand

+ (void) executeWithNumber:(NSString *)phone completeHandler:(CompletionBlock)handler
{
    [[TaskManager instance] startNetworkTask:NetWorkTaskTypeChangeMobile
                                    withData:phone
                             completeHandler:handler];
}
@end

//////////////////////////////////////////////////////////////////////////////////////

@implementation UpdatePhoneSendVerifyCodeCommand

+ (void) executeWithVerifyCode:(NSString *)code completeHandler:(CompletionBlock)handler
{
    [[TaskManager instance] startNetworkTask:NetWorkTaskTypeVerifyMobile
                                    withData:code
                             completeHandler:handler];
}
@end

//////////////////////////////////////////////////////////////////////////////////////

@implementation SendFeedbackCommand

+ (void) executeWithFeedback:(NSString *)feedback completeHandler:(CompletionBlock)handler
{
    [[TaskManager instance] startNetworkTask:NetWorkTaskTypeFeedback
                                    withData:feedback
                             completeHandler:handler];
}
@end

//////////////////////////////////////////////////////////////////////////////////////


