//
//  NetWorkTaskChangeMobile.m
//  EFei
//
//  Created by Xiangzhen Kong on 11/21/14.
//
//

#import "NetWorkTaskChangeMobile.h"
#import "EFei.h"
#import "TaskManager.h"

// Request keys.
static NSString* kRequestMobileKey           = @"mobile";

@implementation NetWorkTaskChangeMobile

+ (void) load
{
    [[TaskManager instance] registeTaskClass:[self class] withType:NetWorkTaskTypeChangeMobile];
}

- (id) init
{
    self = [super init];
    if (self)
    {
        self.taskType = NetWorkTaskTypeChangeMobile;
        self.path = @"student/students/change_mobile";
        self.httpMethod = HttpMethodPut;
    }
    return self;
}

- (void) prepareParameter
{
    NSString* mobile = (NSString*)self.data;
    
    [self.parameterDict setValue:mobile forKey:kRequestMobileKey];
}


- (BOOL) parseResultDict:(NSDictionary *)dict
{
    return YES;
}


@end


