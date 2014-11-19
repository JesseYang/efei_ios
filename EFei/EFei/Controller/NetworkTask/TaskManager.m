//
//  TaskManager.m
//  EFei
//
//  Created by Xiangzhen Kong on 11/19/14.
//
//

#import "TaskManager.h"

@interface TaskManager()
{
    NSMutableDictionary* _classDict;
}

- (NetWorkTask*) taskWithType:(NetWorkTaskType)type;

@end

@implementation TaskManager

+ (TaskManager*) instance
{
    static TaskManager* _instance = nil;
    if (_instance == nil)
    {
        _instance = [[TaskManager alloc] init];
    }
    return _instance;
}

- (id) init
{
    self = [super init];
    if (self)
    {
        _classDict = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void) startNetworkTask:(NetWorkTaskType)type withData:(id)data completeHandler:(CompletionBlock)handler
{
    NetWorkTask* task = [self taskWithType:type];
    task.data = data;
    task.completionBlock = handler;
    [task start];
}

- (void) registeTaskClass:(Class)klass withType:(NetWorkTaskType)taskType
{
    [_classDict setObject:klass forKey:[NSNumber numberWithInteger:taskType]];
}

- (NetWorkTask*) taskWithType:(NetWorkTaskType)type
{
    Class klass = [_classDict objectForKey:[NSNumber numberWithInteger:type]];
    NetWorkTask* task = [[klass alloc] init];

    return task;
}

@end
