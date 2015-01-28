//
//  VerifyCodeViewController.m
//  EFei
//
//  Created by Xiangzhen Kong on 12/16/14.
//
//

#import "VerifyCodeViewController.h"
#import "EFei.h"
#import "UserCommand.h"
#import "ToastView.h"

@interface VerifyCodeViewController ()
{
    
}

@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

- (IBAction)onSubmit:(id)sender;
- (IBAction)onCancel:(id)sender;

@end

@implementation VerifyCodeViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNavigationBar];
    [self setupView];
}

- (void) setupNavigationBar
{
    self.navigationItem.title = @"手机设置";
    self.navigationItem.leftBarButtonItem.title = @"取消";
    
    self.phoneLabel.text = self.phone;
}

- (void) setupView
{
    self.submitButton.layer.cornerRadius = 5;
}

- (IBAction)onSubmit:(id)sender
{
    [self checkVerfyCode];
    
    NSString* text = self.phoneTextField.text;
    CompletionBlock handler = ^(NetWorkTaskType taskType, BOOL success) {
        
        if (success)
        {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
    };
    
    [UpdatePhoneSendVerifyCodeCommand executeWithVerifyCode:text completeHandler:handler];
    
}

- (IBAction)onCancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL) checkVerfyCode
{
    NSString* text = self.phoneTextField.text;
    if (text.length > 0)
    {
        return YES;
    }
    else
    {
        [ToastView showMessage:kErrorMessageNoVerifyCode];
        return NO;
    }
}

@end
