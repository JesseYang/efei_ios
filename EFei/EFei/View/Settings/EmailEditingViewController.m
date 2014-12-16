//
//  EmailEditingViewController.m
//  EFei
//
//  Created by Xiangzhen Kong on 12/16/14.
//
//

#import "EmailEditingViewController.h"
#import "EFei.h"

@interface EmailEditingViewController()
{
    
}
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;


- (IBAction)onCancel:(id)sender;
- (IBAction)onNext:(id)sender;

@end

@implementation EmailEditingViewController

- (IBAction)onCancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onNext:(id)sender
{
    [EFei instance].user.email = self.emailTextField.text;
    
    [self performSegueWithIdentifier:@"ShowEmailEditingResultViewController" sender:self];
}




@end
