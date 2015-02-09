//
//  FeedbackViewController.m
//  EFei
//
//  Created by Xiangzhen Kong on 2/9/15.
//
//

#import "FeedbackViewController.h"
#import "EFei.h"
#import "UserCommand.h"
#import "UIPlaceHolderTextView.h"
#import "ToastView.h"

@interface FeedbackViewController()
{
    
}

@property (strong, nonatomic) IBOutlet UIPlaceHolderTextView *textView;
- (IBAction)onDone:(id)sender;


@end

@implementation FeedbackViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNavigationBar];
    
    [self setupView];
    
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    
//    CGRect frame = self.textView.frame;
//    frame.origin.y = 20;
//    self.textView.frame = frame;
//    NSLog(@"%f, %f, %f, %f ", frame.size.width, frame.size.height, frame.origin.x, frame.origin.y );
//    
//    frame = self.textView.frame;
//    NSLog(@"%f, %f, %f, %f ", frame.size.width, frame.size.height, frame.origin.x, frame.origin.y );
//    
//    [self.textView scrollRectToVisible:CGRectZero animated:NO];
//    [self.textView setNeedsDisplay];
//    [self.textView layoutIfNeeded];
//    
//    [self.view setNeedsDisplay];
//    [self.view layoutIfNeeded];
//    
}


- (void) setupNavigationBar
{
    self.navigationItem.title = @"意见反馈";
}

- (void) setupView
{
    self.textView.placeholder = @"请留下您的宝贵意见";
    self.textView.layer.cornerRadius = 5;
}

- (void) viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
}

- (IBAction)onDone:(id)sender
{
    CompletionBlock handler = ^(NetWorkTaskType taskType, BOOL success) {
        
        if (success)
        {
            [ToastView showMessage:kErrorMessageSendFeedbackSuccess];
        }
        else
        {
            [ToastView showMessage:kErrorMessageSendFeedbackFailed];
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    };
    
    [SendFeedbackCommand executeWithFeedback:self.textView.text completeHandler:handler];
}

@end
