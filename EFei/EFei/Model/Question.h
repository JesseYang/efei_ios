//
//  Question.h
//  EFei
//
//  Created by Xiangzhen Kong on 11/18/14.
//
//

#import <Foundation/Foundation.h>
#import "Topics.h"

typedef enum : NSUInteger
{
    QuestionTypeChoice,
    QuestionTypeAnalysis,
    QuestionTypeOther,
} QuestionType;

@interface Question : NSObject

@property (nonatomic, copy) NSString* questionId;
@property (nonatomic, assign) SubjectType subjectType;
@property (nonatomic, assign) QuestionType questionType;
@property (nonatomic, copy) NSString* questionTypeString;
@property (nonatomic, strong) NSArray* contents;
@property (nonatomic, strong) NSArray* items;
@property (nonatomic, assign) NSInteger answer;
@property (nonatomic, strong) NSArray* answerContents;
@property (nonatomic, strong) NSArray* tags;
@property (nonatomic, copy) NSString* tagsetString;
@property (nonatomic, copy) NSString* imagePath;

@property (nonatomic, copy) NSString* homeworkId;

@end

@interface QuestionList : NSObject

@property (nonatomic, strong) NSArray* questions;

- (void) addQuestion:(Question*)question;

- (void) clearAllQuestion;

@end