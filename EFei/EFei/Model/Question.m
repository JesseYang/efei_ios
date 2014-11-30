//
//  Question.m
//  EFei
//
//  Created by Xiangzhen Kong on 11/18/14.
//
//

#import "Question.h"


@implementation Question

- (void) setQuestionTypeString:(NSString *)questionTypeString
{
    _questionTypeString = [questionTypeString copy];
    _questionType = [Question typeWithString:questionTypeString];
}

+ (QuestionType) typeWithString:(NSString*)typeString
{
    static NSDictionary* questionTypeDict = nil;
    if (questionTypeDict == nil)
    {
        [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:QuestionTypeChoice], @"choice",
         [NSNumber numberWithInteger:QuestionTypeAnalysis], @"analysis", nil];
    }
    
    if ([questionTypeDict objectForKey:typeString] != nil)
    {
        return [[questionTypeDict objectForKey:typeString] integerValue];
    }
    
    return QuestionTypeOther;
}

@end


@interface QuestionList()
{
    NSMutableArray* _questions;
}

@end

@implementation QuestionList

- (id) init
{
    self = [super init];
    if (self)
    {
        _questions = [[NSMutableArray alloc] init];
        
    }
    return self;
}

- (void) addQuestion:(Question *)question
{
    [_questions addObject:question];
}

- (void) clearAllQuestion
{
    [_questions removeAllObjects];
}

@end