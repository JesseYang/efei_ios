//
//  SignInTask.m
//  EFei
//
//  Created by Xiangzhen Kong on 11/19/14.
//
//

#import "NetworkTaskSignIn.h"
#import "EFei.h"
#import "TaskManager.h"

// Request keys.
static NSString* kRequestUsernameKey      = @"email_mobile";
static NSString* kRequestPasswordKey      = @"password";


@implementation NetworkTaskSignIn

+ (void) load
{
    [[TaskManager instance] registeTaskClass:[self class] withType:NetWorkTaskTypeSignin];
}

- (id) init
{
    self = [super init];
    if (self)
    {
        self.taskType = NetWorkTaskTypeSignin;
        self.path = @"account/sessions";
        self.httpMethod = HttpMethodPost;
    }
    return self;
}

- (void) prepareParameter
{
    SignUpInfo* info = (SignUpInfo*)self.data;
    
    [self.parameterDict setValue:info.username forKey:kRequestUsernameKey];
    [self.parameterDict setValue:info.password forKey:kRequestPasswordKey];
}


- (void) sucess
{
    SigninInfo* info = (SigninInfo*)self.data;
    [EFei instance].account.username = info.username;
    [EFei instance].account.password = info.password;
    
    [super sucess];
}

@end