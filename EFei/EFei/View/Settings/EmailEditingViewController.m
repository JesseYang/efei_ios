//
//  EmailEditingViewController.m
//  EFei
//
//  Created by Xiangzhen Kong on 12/16/14.
//
//

#import "EmailEditingViewController.h"
#import "EFei.h"
#import "UserCommand.h"

@interface EmailEditingViewController()
{
    
}
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;


- (IBAction)onCancel:(id)sender;
- (IBAction)onNext:(id)sender;

@end

@implementation EmailEditingViewController
- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNavigationBar];
    
}


- (void) setupNavigationBar
{
    self.navigationItem.title = @"邮箱设置";
    self.navigationItem.leftBarButtonItem.title = @"取消";
    self.navigationItem.rightBarButtonItem.title = @"下一步";
}


- (IBAction)onCancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onNext:(id)sender
{
    NSString* text = self.emailTextField.text;
    CompletionBlock handler = ^(NetWorkTaskType taskType, BOOL success) {
        
        [EFei instance].user.email = self.emailTextField.text;
        
        [self performSegueWithIdentifier:@"ShowEmailEditingResultViewController" sender:self];
        
    };
    
    [UpdateEmailCommand executeWithEmail:text completeHandler:handler];
    
}




@end
