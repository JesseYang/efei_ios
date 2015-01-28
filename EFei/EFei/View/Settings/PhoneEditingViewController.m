//
//  PhoneEditingViewController.m
//  EFei
//
//  Created by Xiangzhen Kong on 12/16/14.
//
//

#import "PhoneEditingViewController.h"
#import "EFei.h"
#import "UserCommand.h"
#import "VerifyCodeViewController.h"
#import "NSString+Email.h"
#import "ToastView.h"

@interface PhoneEditingViewController()
{
    
}
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;


- (IBAction)onCancel:(id)sender;
- (IBAction)onNext:(id)sender;

@end

@implementation PhoneEditingViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNavigationBar];
    
}


- (void) setupNavigationBar
{
    self.navigationItem.title = @"手机设置";
    self.navigationItem.leftBarButtonItem.title = @"取消";
    self.navigationItem.rightBarButtonItem.title = @"下一步";
}


- (IBAction)onCancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)onNext:(id)sender
{
    if (![self checkEmail])
    {
        return;
    }
    
    NSString* text = self.emailTextField.text;
    CompletionBlock handler = ^(NetWorkTaskType taskType, BOOL success) {
        
        if (success)
        {
            [self performSegueWithIdentifier:@"ShowVerifyCodeViewController" sender:self];
        }
        
    };
    
    [UpdatePhoneNumberCommand executeWithNumber:text completeHandler:handler];
    
}

- (BOOL) checkEmail
{
    NSString* text = self.emailTextField.text;
    if ([text isValidPhoneNumber])
    {
        return YES;
    }
    else
    {
        [ToastView showMessage:kErrorMessageWrongPhoneNumber];
        
        return NO;
    }
}


#pragma mark -- Navigation
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowVerifyCodeViewController"])
    {
        VerifyCodeViewController* resultVC = (VerifyCodeViewController*)segue.destinationViewController;
        resultVC.phone = self.emailTextField.text;
    }
}



@end


