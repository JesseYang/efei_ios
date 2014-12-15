//
//  SignUpViewController.m
//  EFei
//
//  Created by Xiangzhen Kong on 11/20/14.
//
//

#import "SignUpViewController.h"
#import "AccountCommand.h"

@interface SignUpViewController()
{
    
}

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *nicknameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)onSignUp:(id)sender;
- (IBAction)onCancel:(id)sender;

@end

@implementation SignUpViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}


- (IBAction)onSignUp:(id)sender
{
    CompletionBlock handler = ^(NetWorkTaskType taskType, BOOL success) {
        NSLog(@"");
        
        if (success)
        {
            [self onCancel:nil];
        }
        
    };
    
    [SignUpCommand executeWithUsername:self.usernameTextField.text
                              nickName:self.nicknameTextField.text
                                idCode:nil phoneNumber:nil
                              authCode:nil password:self.passwordTextField.text
                       completeHandler:handler];
}

- (IBAction)onCancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
