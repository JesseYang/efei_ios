//
//  NetWorkTaskVerifyMobile.m
//  EFei
//
//  Created by Xiangzhen Kong on 11/21/14.
//
//

#import "NetWorkTaskVerifyMobile.h"
#import "EFei.h"
#import "TaskManager.h"

// Request keys.
static NSString* kRequestVerifyCodeKey           = @"verify_code";

@implementation NetWorkTaskVerifyMobile

+ (void) load
{
    [[TaskManager instance] registeTaskClass:[self class] withType:NetWorkTaskTypeVerifyMobile];
}

- (id) init
{
    self = [super init];
    if (self)
    {
        self.taskType = NetWorkTaskTypeVerifyMobile;
        self.path = @"student/students/verify_mobile";
        self.httpMethod = HttpMethodPost;
    }
    return self;
}

- (void) prepareParameter
{
    NSString* code = (NSString*)self.data;
    
    [self.parameterDict setValue:code forKey:kRequestVerifyCodeKey];
}


- (BOOL) parseResultDict:(NSDictionary *)dict
{
    return YES;
}


@end
