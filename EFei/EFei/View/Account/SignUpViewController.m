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

@end

@implementation SignUpViewController

- (IBAction)onSignUp:(id)sender
{
    CompletionBlock handler = ^(NetWorkTaskType taskType, BOOL success) {
        NSLog(@"");
    };
    
    [SignUpCommand executeWithUsername:self.usernameTextField.text
                              nickName:self.nicknameTextField.text
                                idCode:nil phoneNumber:nil
                              authCode:nil password:self.passwordTextField.text
                       completeHandler:handler];
}

@end
