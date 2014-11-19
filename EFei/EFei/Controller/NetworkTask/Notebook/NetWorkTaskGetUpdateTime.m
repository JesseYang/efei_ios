//
//  NetWorkTaskGetUpdateTime.m
//  EFei
//
//  Created by Xiangzhen Kong on 11/19/14.
//
//

#import "NetWorkTaskGetUpdateTime.h"
#import "EFei.h"
#import "TaskManager.h"

static NSString* kResponseUpdateTimeKey        = @"note_update_time";

@implementation NetWorkTaskGetUpdateTime

+ (void) load
{
    [[TaskManager instance] registeTaskClass:[self class] withType:NetWorkTaskTypeGetNotebookUpdateTime];
}

- (id) init
{
    self = [super init];
    if (self)
    {
        self.taskType = NetWorkTaskTypeGetNotebookUpdateTime;
        self.httpMethod = HttpMethodGet;
        self.path = @"student/notes/note_update_time";
    }
    return self;
}

- (BOOL) parseResultDict:(NSDictionary *)dict
{
    NSString* time = [dict objectForKey:kResponseUpdateTimeKey];
    NSLog(@"NetWorkTaskGetUpdateTime:  %@", time);
    
    return time.length > 0;
}


@end
