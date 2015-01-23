//
//  EmailEditingResultViewController.m
//  EFei
//
//  Created by Xiangzhen Kong on 12/16/14.
//
//

#import "EmailEditingResultViewController.h"
#import "EFei.h"

@interface EmailEditingResultViewController()
{
    
}

@property (weak, nonatomic) IBOutlet UILabel *infoLabel;


- (IBAction)onDone:(id)sender;

@end

@implementation EmailEditingResultViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNavigationBar];
    
}

- (void) setupNavigationBar
{
    self.navigationItem.title = @"邮箱换绑";
    self.navigationItem.leftBarButtonItem.title = @"完成";
    
    self.infoLabel.textColor = [EFei instance].efeiColor;
    self.infoLabel.text = [EFei instance].user.mobile;
}

- (IBAction)onDone:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
