//
//  NetWorkTaskGetVerifyCode.m
//  EFei
//
//  Created by Xiangzhen Kong on 11/21/14.
//
//

#import "NetWorkTaskSendVerifyCode.h"
#import "EFei.h"
#import "TaskManager.h"

// Request keys.
static NSString* kRequestUsernameKey      = @"email_mobile";


@implementation NetWorkTaskSendVerifyCode

+ (void) load
{
    [[TaskManager instance] registeTaskClass:[self class] withType:NetWorkTaskTypeSendVerifyCode];
}

- (id) init
{
    self = [super init];
    if (self)
    {
        self.taskType = NetWorkTaskTypeSendVerifyCode;
        self.path = @"account/passwords";
        self.httpMethod = HttpMethodPost;
    }
    return self;
}

- (void) prepareParameter
{
    SignUpInfo* info = (SignUpInfo*)self.data;
    
    [self.parameterDict setValue:info.username forKey:kRequestUsernameKey];
}


- (void) sucess
{
    [super sucess];
}

@end

