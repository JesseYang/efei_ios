//
//  NotebookCommand.h
//  EFei
//
//  Created by Xiangzhen Kong on 11/19/14.
//
//

#import <Foundation/Foundation.h>
#import "TaskManager.h"

@interface NotebookCommand : NSObject

@end


//////////////////////////////////////////////////////////////////////////////////////


@interface GetUpdateTimeCommand : NSObject

+ (void) executeWithCompleteHandler:(CompletionBlock)handler;

@end

//////////////////////////////////////////////////////////////////////////////////////