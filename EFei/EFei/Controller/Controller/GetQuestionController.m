//
//  GetQuestionController.m
//  EFei
//
//  Created by Xiangzhen Kong on 11/30/14.
//
//

#import "GetQuestionController.h"
#import "TaskManager.h"

@interface GetQuestionController()
{
    NSMutableDictionary* _questionDcit;
    NSMutableDictionary* _notesDcit;
}

- (void) parseUrl;
- (void) getQuestion;


@end

@implementation GetQuestionController

+ (GetQuestionController*) instance
{
    static GetQuestionController* _instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _instance = [[GetQuestionController alloc] init];
    });
    
    return _instance;
}

- (id) init
{
    self = [super init];
    if (self)
    {
        _notesDcit = [[NSMutableDictionary alloc] init];
        
        _questionDcit = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (NSArray*)noteList
{
    return [_notesDcit allValues];
}

- (BOOL) questionExist:(NSString *)showUrl
{
    return [_questionDcit objectForKey:showUrl] != nil;
}

- (Note*) noteWithShortUrl:(NSString*)url;
{
    NSString* questionId = _questionDcit[url];
    return _notesDcit[questionId];
}

- (void) addQuestionToList
{
    if (self.currentNote.questionId.length > 0)
    {
        _notesDcit[self.currentNote.questionId] = self.currentNote;
    }
    else
    {
        _notesDcit[self.currentNote.noteId] = self.currentNote;
    }
    self.currentNote = nil;
}


- (void) discardCurrentQuestion
{
    self.currentNote = nil;
}

- (void) discardQuestionList
{
    [_notesDcit removeAllObjects];
}

- (void) startGetQuestion
{
    [self parseUrl];
}

- (void) parseUrl
{
    CompletionBlock handler = ^(NetWorkTaskType taskType, BOOL success){
        if (success)
        {
            [self getQuestion];
        }
        else
        {
            self.completionBlock(success);
        }
    };
    
    [[TaskManager instance] startNetworkTask:NetWorkTaskTypeParseShortUrl
                                    withData:self
                             completeHandler:handler];
}

- (void) getQuestion
{
    NSLog(@"get id: %@", self.questionId);
    dispatch_async(dispatch_get_main_queue(), ^{
        CompletionBlock handler = ^(NetWorkTaskType taskType, BOOL success){
            
            NSLog(@"get question: %@", self.questionId);
            
            if (success)
            {
                [_questionDcit setObject:self.questionId forKey:self.shortUrl];
                
            }
            
            self.completionBlock(success);
        };
        
        [[TaskManager instance] startNetworkTask:NetWorkTaskTypeGetQuestion
                                        withData:self
                                 completeHandler:handler];
    });
}

@end
