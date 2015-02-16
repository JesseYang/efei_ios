//
//  AccountCommand.h
//  EFei
//
//  Created by Xiangzhen Kong on 11/19/14.
//
//

#import <Foundation/Foundation.h>
#import "TaskManager.h"


//////////////////////////////////////////////////////////////////////////////////////


@interface SignInCommand : NSObject

+ (void) executeWithUsername:(NSString*)username
                    password:(NSString*)password
             completeHandler:(CompletionBlock)handler;

@end

//////////////////////////////////////////////////////////////////////////////////////


@interface SignUpCommand : NSObject

+ (void) executeWithUsername:(NSString*)username
                    nickName:(NSString*)nickName
                      idCode:(NSString*)idCode
                 phoneNumber:(NSString*)phone
                    authCode:(NSString*)authCode
                    password:(NSString*)password
             completeHandler:(CompletionBlock)handler;

@end


//////////////////////////////////////////////////////////////////////////////////////


@interface SignOutCommand : NSObject

+ (void) executeWithCompleteHandler:(CompletionBlock)handler;

@end


//////////////////////////////////////////////////////////////////////////////////////


@interface SendVerifyCodeCommand : NSObject

+ (void) executeWithPhoneNumber:(NSString*)phone
                completeHandler:(CompletionBlock)handler;

@end

//////////////////////////////////////////////////////////////////////////////////////


@interface GetResetPasswordTokenCommand : NSObject

+ (void) executeWithPhoneNumber:(NSString*)phone
                       authCode:(NSString*)code
                completeHandler:(CompletionBlock)handler;

@end

//////////////////////////////////////////////////////////////////////////////////////

@interface ResetPasswordCommand : NSObject

+ (void) executeWithToken:(NSString *)token
                 password:(NSString *)password
          completeHandler:(CompletionBlock)handler;

@end

//////////////////////////////////////////////////////////////////////////////////////


@interface GetAppVersionCommand : NSObject

+ (void) executeCompleteHandler:(CompletionBlock)handler;

@end

//////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////



//////////////////////////////////////////////////////////////////////////////////////
