//
//  PhoneEditingViewController.m
//  EFei
//
//  Created by Xiangzhen Kong on 12/16/14.
//
//

#import "PhoneEditingViewController.h"
#import "EFei.h"

@interface PhoneEditingViewController()
{
    
}
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;


- (IBAction)onCancel:(id)sender;
- (IBAction)onNext:(id)sender;

@end

@implementation PhoneEditingViewController

- (IBAction)onCancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onNext:(id)sender
{
    [EFei instance].user.mobile = self.emailTextField.text;
    
    [self performSegueWithIdentifier:@"ShowVerifyCodeViewController" sender:self];
}

@end


