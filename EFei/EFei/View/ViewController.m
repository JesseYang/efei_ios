//
//  ViewController.m
//  EFei
//
//  Created by Xiangzhen Kong on 11/16/14.
//
//

#import "ViewController.h"
#import "NotebookCommand.h"
#import "SignInViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CompletionBlock handler = ^(NetWorkTaskType taskType, BOOL success) {
        NSLog(@"task : %d", success);
    };
    
    [GetUpdateTimeCommand executeWithCompleteHandler:handler];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    [self performSegueWithIdentifier:@"ShowSignInViewController" sender:self];
}

@end
