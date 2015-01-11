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
    
    NSMutableArray* _noteList;
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
        _noteList = [[NSMutableArray alloc] init];
        
        _questionDcit = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (BOOL) questionExist:(NSString *)showUrl
{
    return [_questionDcit objectForKey:showUrl] != nil;
}


- (void) addQuestionToList
{
    [_noteList addObject:self.currentNote];
    self.currentNote = nil;
}

- (void) discardCurrentQuestion
{
    self.currentNote = nil;
}

- (void) discardQuestionList
{
    [_noteList removeAllObjects];
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
            
            [_questionDcit setObject:self.questionId forKey:self.shortUrl];
            
            self.completionBlock(success);
        };
        
        [[TaskManager instance] startNetworkTask:NetWorkTaskTypeGetQuestion
                                        withData:self
                                 completeHandler:handler];
    });
}

@end
