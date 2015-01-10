//
//  NotebookCommand.m
//  EFei
//
//  Created by Xiangzhen Kong on 11/19/14.
//
//

#import "NotebookCommand.h"
#import "GetQuestionController.h"
#import "EFei.h"

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

+ (void) executeWithNote:(Note*)note completeHandler:(CompletionBlock)handler
{
    [[TaskManager instance] startNetworkTask:NetWorkTaskTypeAddQuestion
                                    withData:note
                             completeHandler:handler];
}

@end

//////////////////////////////////////////////////////////////////////////////////////


@implementation AddQuestionListToNotebookCommand

+ (void) executeWithQuestionList:(NSArray *)questions completeHandler:(CompletionBlock)handler
{
    [[TaskManager instance] startNetworkTask:NetWorkTaskTypeAddQuestionList
                                    withData:questions
                             completeHandler:handler];
}

@end

//////////////////////////////////////////////////////////////////////////////////////

@implementation GetNoteListCommand

+ (void) executeWithCompleteHandler:(CompletionBlock)handler
{
    [[TaskManager instance] startNetworkTask:NetWorkTaskTypeGetNoteList
                                    withData:nil
                             completeHandler:handler];
}

@end


//////////////////////////////////////////////////////////////////////////////////////

@implementation GetNoteCommand

+ (void) executeWithNote:(Note*)note completeHandler:(CompletionBlock)handler
{
    [[TaskManager instance] startNetworkTask:NetWorkTaskTypeGetNote
                                    withData:note
                             completeHandler:handler];
}

@end


//////////////////////////////////////////////////////////////////////////////////////


@implementation GetTopicsCommand

+ (void) executeWithSubjectType:(SubjectType)type completeHandler:(CompletionBlock)handler
{
    [[TaskManager instance] startNetworkTask:NetWorkTaskTypeGetTopics
                                    withData:[NSNumber numberWithInteger:type]
                             completeHandler:handler];
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

@implementation NotebookExportCommand

+ (void) executeWithNotes:(NSArray *)notes
                 fileType:(NSString *)fileType
                hasAnswer:(BOOL)answer
                  hasNote:(BOOL)hasNote
                    email:(NSString *)email
          completeHandler:(CompletionBlock)handler
{
    NSMutableString* idStr = [[NSMutableString alloc] init];
    for (Note* note in notes)
    {
        [idStr appendFormat:@"%@,", note.noteId];
    }
    [idStr deleteCharactersInRange:NSMakeRange(idStr.length-1, 1)];
    
    
    ExportInfo* exportInfo = [[ExportInfo alloc] init];
    exportInfo.noteIdStr = idStr;
    exportInfo.fileType  = fileType;
    exportInfo.hadNote   = hasNote;
    exportInfo.hasAnswer = answer;
    exportInfo.email     = email;
    
    [[TaskManager instance] startNetworkTask:NetWorkTaskTypeExportNotes
                                    withData:exportInfo
                             completeHandler:handler];
}

+ (void) executeWithNote:(Note *)note
                fileType:(NSString *)fileType
               hasAnswer:(BOOL)answer
                 hasNote:(BOOL)hasNote
                   email:(NSString *)email
         completeHandler:(CompletionBlock)handler
{
    ExportInfo* exportInfo = [[ExportInfo alloc] init];
    exportInfo.noteIdStr = note.noteId;
    exportInfo.fileType  = fileType;
    exportInfo.hadNote   = hasNote;
    exportInfo.hasAnswer = answer;
    exportInfo.email     = email;
    
    [[TaskManager instance] startNetworkTask:NetWorkTaskTypeExportNotes
                                    withData:exportInfo
                             completeHandler:handler];
}

@end

//////////////////////////////////////////////////////////////////////////////////////

@implementation NotebookDeleteNoteCommand

+ (void) executeWithNote:(Note*)note
         completeHandler:(CompletionBlock)handler
{
    [[TaskManager instance] startNetworkTask:NetWorkTaskTypeDeleteNote
                                    withData:note
                             completeHandler:handler];
}

@end

//////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////
