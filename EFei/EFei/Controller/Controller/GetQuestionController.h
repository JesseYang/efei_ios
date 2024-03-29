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
#import "Note.h"

@interface GetQuestionController : NSObject

@property (nonatomic, copy) NSString* shortUrl;
@property (nonatomic, copy) NSString* questionId;
@property (nonatomic, copy) NSString* homeworkId;
@property (nonatomic, copy) ControllerCompletionBlock completionBlock;
@property (nonatomic, strong) NSArray* noteList;
@property (nonatomic, strong) Note* currentNote;

+ (GetQuestionController*) instance;

- (void) startGetQuestion;

- (BOOL) questionExist:(NSString*)showUrl;

- (Note*) noteWithShortUrl:(NSString*)url;

- (void) addQuestionToList;
- (void) discardCurrentQuestion;
- (void) discardQuestionList;

@end
