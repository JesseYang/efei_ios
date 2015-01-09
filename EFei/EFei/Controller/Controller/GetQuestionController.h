//
//  GetQuestionController.h
//  EFei
//
//  Created by Xiangzhen Kong on 11/30/14.
//
//

#import <Foundation/Foundation.h>
#import "Controller.h"
#import "Question.h"

@interface GetQuestionController : NSObject

@property (nonatomic, copy) NSString* shortUrl;
@property (nonatomic, copy) NSString* questionId;
@property (nonatomic, copy) ControllerCompletionBlock completionBlock;
@property (nonatomic, strong) QuestionList* questionList;
@property (nonatomic, strong) Question* currentQuestion;

+ (GetQuestionController*) instance;

- (void) startGetQuestion;

- (BOOL) questionExist:(NSString*)showUrl;

- (void) addQuestionToList;
- (void) discardCurrentQuestion;
- (void) discardQuestionList;

@end
