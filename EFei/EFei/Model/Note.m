//
//  Note.m
//  EFei
//
//  Created by Xiangzhen Kong on 11/18/14.
//
//

#import "Note.h"

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

@end
