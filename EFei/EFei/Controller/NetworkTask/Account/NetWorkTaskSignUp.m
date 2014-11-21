//
//  NetWorkTaskSignUp.m
//  EFei
//
//  Created by Xiangzhen Kong on 11/19/14.
//
//

#import "NetWorkTaskSignUp.h"
#import "EFei.h"
#import "TaskManager.h"

// Request keys.
static NSString* kRequestUsernameKey      = @"email_mobile";
static NSString* kRequestNickNameKey      = @"name";
static NSString* kRequestPasswdKey        = @"password";


@implementation NetWorkTaskSignUp

+ (void) load
{
    [[TaskManager instance] registeTaskClass:[self class] withType:NetWorkTaskTypeSignup];
}

- (id) init
{
    self = [super init];
    if (self)
    {
        self.taskType = NetWorkTaskTypeSignup;
        self.path = @"account/registrations";
        self.httpMethod = HttpMethodPost;
    }
    return self;
}

- (void) prepareParameter
{
    SignUpInfo* info = (SignUpInfo*)self.data;
    
    [self.parameterDict setValue:info.username forKey:kRequestUsernameKey];
    [self.parameterDict setValue:info.nickName forKey:kRequestNickNameKey];
    [self.parameterDict setValue:info.password forKey:kRequestPasswdKey];
}



@end

