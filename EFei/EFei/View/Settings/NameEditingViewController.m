//
//  NameEditingViewController.m
//  EFei
//
//  Created by Xiangzhen Kong on 12/16/14.
//
//

#import "NameEditingViewController.h"
#import "EFei.h"

@interface NameEditingViewController()
{
    
}

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

- (IBAction)onCancel:(id)sender;
- (IBAction)onDone:(id)sender;

@end


@implementation NameEditingViewController- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNavigationBar];
    
}


- (void) setupNavigationBar
{
    self.navigationItem.title = @"姓名设置";
    self.navigationItem.leftBarButtonItem.title = @"取消";
    self.navigationItem.rightBarButtonItem.title = @"完成";
}


- (IBAction)onCancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onDone:(id)sender
{
    [EFei instance].user.name = self.nameTextField.text;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
