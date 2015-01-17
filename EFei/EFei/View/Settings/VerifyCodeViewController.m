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

@interface VerifyCodeViewController ()
{
    
}

@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

- (IBAction)onSubmit:(id)sender;
- (IBAction)onCancel:(id)sender;

@end

@implementation VerifyCodeViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNavigationBar];
    
}

- (void) setupNavigationBar
{
    self.navigationItem.title = @"手机设置";
    self.navigationItem.leftBarButtonItem.title = @"取消";
    
    self.phoneLabel.text = [EFei instance].user.mobile;
}

- (IBAction)onSubmit:(id)sender
{
    NSString* text = self.phoneTextField.text;
    CompletionBlock handler = ^(NetWorkTaskType taskType, BOOL success) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    };
    
    [UpdatePhoneSendVerifyCodeCommand executeWithVerifyCode:text completeHandler:handler];
    
}

- (IBAction)onCancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
