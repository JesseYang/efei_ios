//
//  NetWorkTaskRename.m
//  EFei
//
//  Created by Xiangzhen Kong on 11/21/14.
//
//

#import "NetWorkTaskRename.h"
#import "EFei.h"
#import "TaskManager.h"

// Request keys.
static NSString* kRequestNameKey           = @"name";

@implementation NetWorkTaskRename

+ (void) load
{
    [[TaskManager instance] registeTaskClass:[self class] withType:NetWorkTaskTypeRename];
}

- (id) init
{
    self = [super init];
    if (self)
    {
        self.taskType = NetWorkTaskTypeRename;
        self.path = @"student/students/rename";
        self.httpMethod = HttpMethodPut;
    }
    return self;
}

- (void) prepareParameter
{
    NSString* name = (NSString*)self.data;
    
    [self.parameterDict setValue:name forKey:kRequestNameKey];
}


- (BOOL) parseResultDict:(NSDictionary *)dict
{
    return YES;
}


@end

