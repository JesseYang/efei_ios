//
//  UserCommand.h
//  EFei
//
//  Created by Xiangzhen Kong on 11/19/14.
//
//

#import <Foundation/Foundation.h>
#import "TaskManager.h"
#import "Controller.h"
#import "Topics.h"

//////////////////////////////////////////////////////////////////////////////////////

@interface UserCommand : NSObject

@end


//////////////////////////////////////////////////////////////////////////////////////


@interface GetTeachersCommand : NSObject

+ (void) executeWithCompleteHandler:(CompletionBlock)handler;
+ (void) executeWithSubject:(NSInteger)subject name:(NSString*)name completeHandler:(CompletionBlock)handler;

@end

//////////////////////////////////////////////////////////////////////////////////////