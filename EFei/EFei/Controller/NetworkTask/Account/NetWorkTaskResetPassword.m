//
//  NetWorkTaskResetPassword.m
//  EFei
//
//  Created by Xiangzhen Kong on 11/21/14.
//
//

#import "NetWorkTaskResetPassword.h"
#import "EFei.h"
#import "TaskManager.h"

// Request keys.
static NSString* kRequestPasswordKey           = @"password";
static NSString* kRequestResetPasswordTokenKey = @"reset_password_token";

@implementation NetWorkTaskResetPassword

+ (void) load
{
    [[TaskManager instance] registeTaskClass:[self class] withType:NetWorkTaskTypeResetPassword];
}

- (id) init
{
    self = [super init];
    if (self)
    {
        self.taskType = NetWorkTaskTypeResetPassword;
        self.path = @"account/passwords";
        self.httpMethod = HttpMethodPut;
    }
    return self;
}

- (void) prepareParameter
{
    ResetPasswordInfo* info = (ResetPasswordInfo*)self.data;
    
    [self.parameterDict setValue:info.password forKey:kRequestPasswordKey];
    [self.parameterDict setValue:info.token forKey:kRequestResetPasswordTokenKey];
}


- (BOOL) parseResultDict:(NSDictionary *)dict
{
    return YES;
}


@end


