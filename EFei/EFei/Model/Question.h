//
//  Question.h
//  EFei
//
//  Created by Xiangzhen Kong on 11/18/14.
//
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger
{
    SubjectTypeChinese      = 1,
    SubjectTypeMathematics  = 2,
    SubjectTypeEnglish      = 4,
    SubjectTypePhysics      = 8,
    SubjectTypeChemistry    = 16,
    SubjectTypeBiology      = 32,
    SubjectTypeHistroy      = 64,
    SubjectTypeGeography    = 128,
    SubjectTypePolitics     = 256,
    SubjectTypeOther        = 512,
} SubjectType;

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
@property (nonatomic, strong) NSArray* contents;
@property (nonatomic, strong) NSArray* items;
@property (nonatomic, assign) NSInteger answer;
@property (nonatomic, strong) NSArray* answerContents;
@property (nonatomic, strong) NSArray* tags;


@end

