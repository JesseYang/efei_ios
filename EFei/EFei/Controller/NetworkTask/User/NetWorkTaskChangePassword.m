//
//  NetWorkTaskChangePassword.m
//  EFei
//
//  Created by Xiangzhen Kong on 11/21/14.
//
//

#import "NetWorkTaskChangePassword.h"
#import "EFei.h"
#import "TaskManager.h"

// Request keys.
static NSString* kRequestPasswordKey           = @"password";
static NSString* kRequestNewPasswordKey        = @"new_password";

@implementation NetWorkTaskChangePassword

+ (void) load
{
    [[TaskManager instance] registeTaskClass:[self class] withType:NetWorkTaskTypeChangePassword];
}

- (id) init
{
    self = [super init];
    if (self)
    {
        self.taskType = NetWorkTaskTypeChangePassword;
        self.path = @"student/students/change_password";
        self.httpMethod = HttpMethodPut;
    }
    return self;
}

- (void) prepareParameter
{
    ChangePasswordInfo* info = (ChangePasswordInfo*)self.data;
    
    [self.parameterDict setValue:info.password forKey:kRequestPasswordKey];
    [self.parameterDict setValue:info.passwordNew forKey:kRequestNewPasswordKey];
}


- (BOOL) parseResultDict:(NSDictionary *)dict
{
    return YES;
}


@end

