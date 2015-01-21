//
//  NetWorkTaskGetResetPasswordToken.m
//  EFei
//
//  Created by Xiangzhen Kong on 11/21/14.
//
//

#import "NetWorkTaskGetResetPasswordToken.h"
#import "EFei.h"
#import "TaskManager.h"
#import "ResetPasswordController.h"

// Request keys.
static NSString* kRequestUsernameKey        = @"mobile";
static NSString* kRequestVerifyCodeKey      = @"verify_code";

static NSString* kResponseResetPasswordTokenKey = @"reset_password_token";

@implementation NetWorkTaskGetResetPasswordToken

+ (void) load
{
    [[TaskManager instance] registeTaskClass:[self class] withType:NetWorkTaskTypeGetResetPasswordToken];
}

- (id) init
{
    self = [super init];
    if (self)
    {
        self.taskType = NetWorkTaskTypeGetResetPasswordToken;
        self.path = @"account/passwords/verify_code";
        self.httpMethod = HttpMethodPost;
    }
    return self;
}

- (void) prepareParameter
{
    ResetPasswordInfo* info = (ResetPasswordInfo*)self.data;
    
    [self.parameterDict setValue:info.phoneNumber forKey:kRequestUsernameKey];
    [self.parameterDict setValue:info.verifyCode forKey:kRequestVerifyCodeKey];
}


- (BOOL) parseResultDict:(NSDictionary *)dict
{
    NSString* token = [dict objectForKey:kResponseResetPasswordTokenKey];
    NSLog(@"NetWorkTaskGetResetPasswordToken:  %@", token);
    
    [ResetPasswordController instance].resetPasswordToken = token;
    
    return token.length > 0;
}


@end

