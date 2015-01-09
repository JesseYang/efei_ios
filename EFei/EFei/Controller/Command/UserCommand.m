//
//  UserCommand.m
//  EFei
//
//  Created by Xiangzhen Kong on 11/19/14.
//
//

#import "UserCommand.h"
#import "EFei.h"

//////////////////////////////////////////////////////////////////////////////////////

@implementation UserCommand

@end


//////////////////////////////////////////////////////////////////////////////////////

@implementation GetTeachersCommand

+ (void) executeWithCompleteHandler:(CompletionBlock)handler
{
    GetTeacherInfo* info = [[GetTeacherInfo alloc] init];
    info.scope = 1;
    
    [[TaskManager instance] startNetworkTask:NetWorkTaskTypeGetTeachers
                                    withData:info
                             completeHandler:handler];
}

+ (void) executeWithSubject:(NSInteger)subject name:(NSString*)name completeHandler:(CompletionBlock)handler
{
    GetTeacherInfo* info = [[GetTeacherInfo alloc] init];
    info.scope = 0;
    info.subject = subject;
    info.name = name;
    
    [[TaskManager instance] startNetworkTask:NetWorkTaskTypeGetTeachers
                                    withData:info
                             completeHandler:handler];
}

@end

//////////////////////////////////////////////////////////////////////////////////////

