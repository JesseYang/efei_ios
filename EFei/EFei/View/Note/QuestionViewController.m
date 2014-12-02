//
//  QuestionViewController.m
//  EFei
//
//  Created by Xiangzhen Kong on 12/2/14.
//
//

#import "QuestionViewController.h"
#import "GetQuestionController.h"

@implementation QuestionViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    GetQuestionController* controller = [GetQuestionController instance];
    Question* question = [controller.questionList.questions firstObject];
    
    UITextView* textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 300)];
    textView.text = [question.contents firstObject];
    textView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:textView];
    
    
    NSLog(@"question view controller load");
}

@end
