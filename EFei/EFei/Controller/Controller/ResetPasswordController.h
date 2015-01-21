//
//  ResetPasswordController.h
//  EFei
//
//  Created by Xiangzhen Kong on 1/9/15.
//
//

#import <Foundation/Foundation.h>
#import "TaskManager.h"

@interface ResetPasswordController : NSObject

@property (nonatomic, copy) NSString* email;
@property (nonatomic, copy) NSString* phone;
@property (nonatomic, copy) NSString* authCode;

@property (nonatomic, copy) NSString* resetPasswordToken;

+ (ResetPasswordController*) instance;

- (void) startResetPassword;

- (void) resetPassword:(NSString*)password withHandler:(CompletionBlock)handler;

@end
