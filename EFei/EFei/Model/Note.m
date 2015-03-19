//
//  Note.m
//  EFei
//
//  Created by Xiangzhen Kong on 11/18/14.
//
//

#import "Note.h"
#import "NSString+Email.h"

#define TopicsSeparator @","

@implementation Note

- (id) initWithQuestion:(Question *)question
{
    self = [super init];
    if (self)
    {
        self.questionId = [question.questionId copy];
        self.subjectType = question.subjectType;
        self.questionType = question.questionType;
        self.questionTypeString = [question.questionTypeString copy];
        self.contents = [question.contents copy];
        self.items = [question.items copy];
        self.answer = question.answer;
        self.answerContents = [question.answerContents copy];
        self.tags = [question.tags copy];
        self.imagePath = [question.imagePath copy];
        self.homeworkId = [question.homeworkId copy];
        
        self.tag = @"";
        self.topicString = @"";
        self.summary = @"";
    }
    
    return self;
}

- (id) initWithNoteId:(NSString*)noteId updateTime:(NSInteger)updateTime
{
    self = [super init];
    if (self)
    {
        self.noteId = noteId;
        self.updateTime = updateTime;
    }
    
    return self;
}



- (void) setTopics:(NSArray *)topics
{
    _topics = [NSArray arrayWithArray:topics];
    
    if (_topics.count == 0)
    {
        _topicString = @"";
    }
    else
    {
        NSMutableString* res = [[NSMutableString alloc] init];
        
        for (NSString* t in self.topics)
        {
            [res appendString:t];
            if (t != [self.topics lastObject])
            {
                [res appendString:TopicsSeparator];
            }
        }
        
        _topicString = [res copy];
    }
    
}

- (void) setTopicString:(NSString *)topicString
{
    _topicString = [topicString copy];
    
    _topics = [topicString componentsSeparatedByString:TopicsSeparator];
}

- (BOOL) matchText:(NSString *)text
{
    if ([self.topicString hasSubString:text])
    {
        return YES;
    }
    
    if ([self.tag hasSubString:text])
    {
        return YES;
    }
    
    if ([self.summary hasSubString:text])
    {
        return YES;
    }
    
    for (NSString* string in self.contents)
    {
        if ([string hasSubString:text])
        {
            return YES;
        }
    }
    
    return NO;
}

- (void) setCreateTime:(NSString *)createTime
{
    _createTime = [createTime copy];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZZZ"];
    
    self.createDate = [formatter dateFromString:_createTime];
    NSLog(@"---  %@", self.createDate);
}

@end
