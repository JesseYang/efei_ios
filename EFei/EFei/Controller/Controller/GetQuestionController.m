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
        self.questionList = [[QuestionList alloc] init];
    }
    return self;
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
            self.completionBlock(success);
        };
        
        [[TaskManager instance] startNetworkTask:NetWorkTaskTypeGetQuestion
                                        withData:self
                                 completeHandler:handler];
    });
}

@end
