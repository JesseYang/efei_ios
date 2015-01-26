//
//  NetWorkTaskGetTopics.m
//  EFei
//
//  Created by Xiangzhen Kong on 11/22/14.
//
//

#import "NetWorkTaskGetTopics.h"
#import "EFei.h"
#import "TaskManager.h"

static NSString* kRequestSubjectKey        = @"subject";

static NSString* kResponseTopicsKey        = @"topics";

@implementation NetWorkTaskGetTopics

+ (void) load
{
    [[TaskManager instance] registeTaskClass:[self class] withType:NetWorkTaskTypeGetTopics];
}

- (id) init
{
    self = [super init];
    if (self)
    {
        self.taskType = NetWorkTaskTypeGetTopics;
        self.httpMethod = HttpMethodGet;
        self.path = @"student/topics";
    }
    return self;
}


- (void) prepareParameter
{
    NSNumber* subject = (NSNumber*)self.data;
    
    [self.parameterDict setValue:subject forKey:kRequestSubjectKey];
}


- (BOOL) parseResultDict:(NSDictionary *)dict
{
    NSArray* topics = [dict objectForKey:kResponseTopicsKey];
    if (![topics isKindOfClass:[NSArray class]] || topics.count ==0)
    {
        return NO;
    }
    
    NSNumber* type = (NSNumber*)self.data;
    Subject* subject = [[EFei instance].subjectManager subjectWithType:[type integerValue]];
    [subject clearAllTopics];
    
    for (NSArray* tArray in topics)
    {
        Topic* t = [[Topic alloc] init];
        t.name = [tArray objectAtIndex:0];
        t.quickName = [tArray objectAtIndex:1];
        
        [subject addTopic:t];
    }
    
    [subject saveData];
    
    return YES;
}


@end
