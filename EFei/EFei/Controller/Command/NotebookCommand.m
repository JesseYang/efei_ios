//
//  NotebookCommand.m
//  EFei
//
//  Created by Xiangzhen Kong on 11/19/14.
//
//

#import "NotebookCommand.h"
#import "GetQuestionController.h"

@implementation  NotebookCommand

@end

//////////////////////////////////////////////////////////////////////////////////////


@implementation ParseShortUrlCommand

+ (void) executeWithUrl:(NSString*)url completeHandler:(CompletionBlock)handler
{
    [[TaskManager instance] startNetworkTask:NetWorkTaskTypeParseShortUrl
                                    withData:url
                             completeHandler:handler];
}

@end

//////////////////////////////////////////////////////////////////////////////////////


@implementation GetQuestionContentCommand

+ (void) executeWithCompleteHandler:(CompletionBlock)handler
{
    
}

+ (void) executeWithShortUrl:(NSString*)url completeHandler:(ControllerCompletionBlock)handler
{
    GetQuestionController* controller = [GetQuestionController instance];
    controller.shortUrl = url;
    controller.completionBlock = handler;
    [controller startGetQuestion];
}

@end

//////////////////////////////////////////////////////////////////////////////////////


@implementation AddQuestionToNotebookCommand

+ (void) executeWithCompleteHandler:(CompletionBlock)handler
{
}

@end

//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////

@implementation GetTopicsCommand

+ (void) executeWithCompleteHandler:(CompletionBlock)handler
{
}

@end

//////////////////////////////////////////////////////////////////////////////////////

@implementation GetUpdateTimeCommand

+ (void) executeWithCompleteHandler:(CompletionBlock)handler
{
    [[TaskManager instance] startNetworkTask:NetWorkTaskTypeGetNotebookUpdateTime
                                    withData:nil
                             completeHandler:handler];
}

@end

//////////////////////////////////////////////////////////////////////////////////////
