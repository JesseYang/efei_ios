//
//  TaskManager.h
//  EFei
//
//  Created by Xiangzhen Kong on 11/19/14.
//
//

#import <Foundation/Foundation.h>

#import <Foundation/Foundation.h>
#import "NetWorkTask.h"

@interface TaskManager : NSObject

+ (TaskManager*) instance;

- (void) registeTaskClass:(Class)klass withType:(NetWorkTaskType)taskType;

- (void) startNetworkTask:(NetWorkTaskType)type withData:(id)data completeHandler:(CompletionBlock)handler;

@end
