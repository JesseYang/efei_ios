//
//  NetWorkTaskGetUserInfo.m
//  EFei
//
//  Created by Xiangzhen Kong on 11/21/14.
//
//

#import "NetWorkTaskGetUserInfo.h"
#import "EFei.h"
#import "TaskManager.h"

static NSString* kResponseNameKey        = @"name";
static NSString* kResponseMobileKey      = @"mobile";
static NSString* kResponseEmailKey       = @"email";

@implementation NetWorkTaskGetUserInfo

+ (void) load
{
    [[TaskManager instance] registeTaskClass:[self class] withType:NetWorkTaskTypeGetUserInfo];
}

- (id) init
{
    self = [super init];
    if (self)
    {
        self.taskType = NetWorkTaskTypeGetUserInfo;
        self.httpMethod = HttpMethodGet;
        self.path = @"student/students/info";
    }
    return self;
}

- (BOOL) parseResultDict:(NSDictionary *)dict
{
    NSString* name = [dict objectForKey:kResponseNameKey];
    NSString* mobile = [dict objectForKey:kResponseMobileKey];
    NSString* email = [dict objectForKey:kResponseEmailKey];
    
    [EFei instance].user.name = name;
    [EFei instance].user.mobile = mobile;
    [EFei instance].user.email = email;
    
    NSLog(@"NetWorkTaskGetUserInfo:  %@", name);
    
    return YES;
}


@end

