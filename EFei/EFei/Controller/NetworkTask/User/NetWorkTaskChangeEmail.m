//
//  NetWorkTaskChangeEmail.m
//  EFei
//
//  Created by Xiangzhen Kong on 11/21/14.
//
//

#import "NetWorkTaskChangeEmail.h"
#import "EFei.h"
#import "TaskManager.h"

// Request keys.
static NSString* kRequestEmailKey           = @"email";

@implementation NetWorkTaskChangeEmail

+ (void) load
{
    [[TaskManager instance] registeTaskClass:[self class] withType:NetWorkTaskTypeChangeEmail];
}

- (id) init
{
    self = [super init];
    if (self)
    {
        self.taskType = NetWorkTaskTypeChangeEmail;
        self.path = @"student/students/change_email";
        self.httpMethod = HttpMethodPut;
    }
    return self;
}

- (void) prepareParameter
{
    NSString* email = (NSString*)self.data;
    
    [self.parameterDict setValue:email forKey:kRequestEmailKey];
}


- (BOOL) parseResultDict:(NSDictionary *)dict
{
    return YES;
}


@end

