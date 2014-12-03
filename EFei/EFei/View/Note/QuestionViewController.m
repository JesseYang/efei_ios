//
//  QuestionViewController.m
//  EFei
//
//  Created by Xiangzhen Kong on 12/2/14.
//
//

#import "QuestionViewController.h"
#import "GetQuestionController.h"
#import "NoteTextView.h"

@interface QuestionViewController()
{
    
}

- (IBAction)onDone:(id)sender;


@end

@implementation QuestionViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    GetQuestionController* controller = [GetQuestionController instance];
    Question* question = [controller.questionList.questions lastObject];
    
    UITextView* textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 200)];
    textView.text = [question.contents firstObject];
    textView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:textView];
    
    
    NoteTextView* noteTextView = [[NoteTextView alloc] initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 300)];
    [noteTextView setNoteContent:question.contents];
    [self.view addSubview:noteTextView];
    
    NSLog(@"question view controller load");
}

- (IBAction)onDone:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
