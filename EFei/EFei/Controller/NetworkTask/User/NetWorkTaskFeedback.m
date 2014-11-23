//
//  NetWorkTaskFeedback.m
//  EFei
//
//  Created by Xiangzhen Kong on 11/21/14.
//
//

#import "NetWorkTaskFeedback.h"
#import "EFei.h"
#import "TaskManager.h"

static NSString* kReqeustContentKey           = @"content";


@implementation NetWorkTaskFeedback

+ (void) load
{
    [[TaskManager instance] registeTaskClass:[self class] withType:NetWorkTaskTypeFeedback];
}

- (id) init
{
    self = [super init];
    if (self)
    {
        self.taskType = NetWorkTaskTypeFeedback;
        self.httpMethod = HttpMethodPost;
        self.path = @"student/feedbacks";
    }
    return self;
}

- (void) prepareParameter
{
    NSString* content = (NSString*)self.data;
    
    [self.parameterDict setValue:content forKey:kReqeustContentKey];
}


- (BOOL) parseResultDict:(NSDictionary *)dict
{
    
    return YES;
}

@end
