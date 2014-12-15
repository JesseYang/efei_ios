//
//  NotebookCommand.h
//  EFei
//
//  Created by Xiangzhen Kong on 11/19/14.
//
//

#import <Foundation/Foundation.h>
#import "TaskManager.h"
#import "Controller.h"

@interface NotebookCommand : NSObject

@end


//////////////////////////////////////////////////////////////////////////////////////


@interface ParseShortUrlCommand : NSObject

+ (void) executeWithUrl:(NSString*)url completeHandler:(CompletionBlock)handler;

@end

//////////////////////////////////////////////////////////////////////////////////////


@interface GetQuestionContentCommand : NSObject

+ (void) executeWithCompleteHandler:(CompletionBlock)handler;
+ (void) executeWithShortUrl:(NSString*)url completeHandler:(ControllerCompletionBlock)handler;

@end

//////////////////////////////////////////////////////////////////////////////////////

@class Note;

@interface AddQuestionToNotebookCommand : NSObject

+ (void) executeWithNote:(Note*)note completeHandler:(CompletionBlock)handler;

@end

//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////

@interface GetTopicsCommand : NSObject

+ (void) executeWithCompleteHandler:(CompletionBlock)handler;

@end

//////////////////////////////////////////////////////////////////////////////////////


@interface GetUpdateTimeCommand : NSObject

+ (void) executeWithCompleteHandler:(CompletionBlock)handler;

@end
//////////////////////////////////////////////////////////////////////////////////////