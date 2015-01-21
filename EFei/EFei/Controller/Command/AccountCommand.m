//
//  AccountCommand.m
//  EFei
//
//  Created by Xiangzhen Kong on 11/19/14.
//
//

#import "AccountCommand.h"
#import "EFei.h"

//////////////////////////////////////////////////////////////////////////////////////

@implementation SignInCommand

+ (void) executeWithUsername:(NSString*)username password:(NSString*)password completeHandler:(CompletionBlock)handler
{
    SigninInfo* info = [[SigninInfo alloc] init];
    info.username = username;
    info.password = password;
    
    [[TaskManager instance] startNetworkTask:NetWorkTaskTypeSignin withData:info completeHandler:handler];
}

@end

//////////////////////////////////////////////////////////////////////////////////////

@implementation SignUpCommand


+ (void) executeWithUsername:(NSString*)username
                    nickName:(NSString*)nickName
                      idCode:(NSString*)idCode
                 phoneNumber:(NSString*)phone
                    authCode:(NSString*)authCode
                    password:(NSString*)password
             completeHandler:(CompletionBlock)handler
{
    SignUpInfo* info = [[SignUpInfo alloc] init];
    info.username = username;
    info.nickName = nickName;
    info.password = password;
    
    [[TaskManager instance] startNetworkTask:NetWorkTaskTypeSignup withData:info completeHandler:handler];
}

@end

//////////////////////////////////////////////////////////////////////////////////////

@implementation SignOutCommand

+ (void) executeWithCompleteHandler:(CompletionBlock)handler;
{
    [[TaskManager instance] startNetworkTask:NetWorkTaskTypeSignout withData:nil completeHandler:handler];
}

@end

//////////////////////////////////////////////////////////////////////////////////////


@implementation SendVerifyCodeCommand

+ (void) executeWithPhoneNumber:(NSString*)phone completeHandler:(CompletionBlock)handler;
{
    [[TaskManager instance] startNetworkTask:NetWorkTaskTypeSendVerifyCode withData:phone completeHandler:handler];
}

@end

//////////////////////////////////////////////////////////////////////////////////////


@implementation GetResetPasswordTokenCommand

+ (void) executeWithPhoneNumber:(NSString *)phone authCode:(NSString *)code completeHandler:(CompletionBlock)handler
{
    ResetPasswordInfo* info = [[ResetPasswordInfo alloc] init];
    info.phoneNumber = phone;
    info.verifyCode = code;
    
    [[TaskManager instance] startNetworkTask:NetWorkTaskTypeGetResetPasswordToken withData:info completeHandler:handler];
}

@end

//////////////////////////////////////////////////////////////////////////////////////

@implementation ResetPasswordCommand

+ (void) executeWithToken:(NSString *)token password:(NSString *)password completeHandler:(CompletionBlock)handler
{
    ResetPasswordInfo* info = [[ResetPasswordInfo alloc] init];
    info.password = password;
    info.token = token;
    
    [[TaskManager instance] startNetworkTask:NetWorkTaskTypeResetPassword withData:info completeHandler:handler];
}

@end

//////////////////////////////////////////////////////////////////////////////////////
