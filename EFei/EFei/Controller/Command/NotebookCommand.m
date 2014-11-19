//
//  NotebookCommand.m
//  EFei
//
//  Created by Xiangzhen Kong on 11/19/14.
//
//

#import "NotebookCommand.h"

@implementation NotebookCommand

@end


//////////////////////////////////////////////////////////////////////////////////////

@implementation GetUpdateTimeCommand

+ (void) executeWithCompleteHandler:(CompletionBlock)handler;
{
    [[TaskManager instance] startNetworkTask:NetWorkTaskTypeGetNotebookUpdateTime
                                    withData:nil
                             completeHandler:handler];
}

@end

//////////////////////////////////////////////////////////////////////////////////////
