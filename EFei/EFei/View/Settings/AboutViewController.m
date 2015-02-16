//
//  AboutViewController.m
//  EFei
//
//  Created by Xiangzhen Kong on 2/16/15.
//
//

#import "AboutViewController.h"
#import "EFei.h"
#import "AccountCommand.h"

@interface AboutViewController()
{
    
}

@property (weak, nonatomic) IBOutlet UILabel *currentVersionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *updateImageView;
@property (weak, nonatomic) IBOutlet UILabel *lastestVersionLabel;


@end

@implementation AboutViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNavigationBar];
    
    [self setupView];
    
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self getAppVersion];
}


- (void) setupNavigationBar
{
    self.navigationItem.title = @"关于易飞";
}

- (void) setupView
{
    self.currentVersionLabel.text = [NSString stringWithFormat:@"易飞网v%@", [EFei instance].account.appVersion];
    
    float currentVersion = [[EFei instance].account.appVersion floatValue];
    float lastestVersion = [[EFei instance].account.lastestVersion floatValue];
    if (currentVersion < lastestVersion)
    {
        self.updateImageView.hidden = NO;
        self.lastestVersionLabel.text = [NSString stringWithFormat:@"v%@", [EFei instance].account.lastestVersion];
    }
    else
    {
        self.updateImageView.hidden = YES;
        self.lastestVersionLabel.text = @"已是最新版本";
    }
}

- (void) getAppVersion
{
    CompletionBlock handler = ^(NetWorkTaskType taskType, BOOL success) {
        
        if (success)
        {
            [self setupView];
        }
    };
    
    [GetAppVersionCommand executeCompleteHandler:handler];
}


@end
