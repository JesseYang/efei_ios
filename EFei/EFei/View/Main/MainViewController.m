//
//  MainViewController.m
//  EFei
//
//  Created by Xiangzhen Kong on 12/2/14.
//
//

#import "MainViewController.h"
#import "UIColor+Hex.h"
#import "EFei.h"
#import "NetWorkTask.h"
#import "ToastView.h"

#define NavigationBarBackgroundColor @"#4979BD"
#define TabBarNormalColor @"#070707"

#define ShowQRScanViewControllerSegueId @"ShowQRScanViewController"
#define ShowSignInViewControllerSegueId @"ShowSignInViewController"

@interface MainViewController()<UITabBarControllerDelegate>
{
    BOOL _showNotebook;
}

@end

@implementation MainViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    self.selectedIndex = 1;
    
    self.delegate = self;
    
    [UIApplication sharedApplication].statusBarHidden = NO;
    
    UIColor* efeiColor = [UIColor colorWithHexString:NavigationBarBackgroundColor];
    UIColor* unselectedColor = [UIColor colorWithHexString:TabBarNormalColor];
    
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : unselectedColor }
                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : efeiColor }
                                             forState:UIControlStateSelected];
    
    
    NSArray* imageArray = @[@"icon_main_scan", @"icon_main_notebook", @"icon_main_settings"];
    NSArray* tabTitle = @[@"扫码", @"错题本", @"设置"];
    
    for (int i=0; i<imageArray.count; i++)
    {
        NSString* name = [imageArray objectAtIndex:i];
        NSString* onImage = [NSString stringWithFormat:@"%@_on.png", name];
        NSString* offImage = [NSString stringWithFormat:@"%@_off.png", name];
        UITabBarItem  *tab = [self.tabBar.items objectAtIndex:i];
        
        tab.image = [[UIImage imageNamed:offImage] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
        tab.selectedImage = [[UIImage imageNamed:onImage] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
     
        tab.title = [tabTitle objectAtIndex:i];
    }
    
    [[UINavigationBar appearance] setBarTintColor:efeiColor];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]}];
    
    
    
    [self setupNetworkNotification];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    if ([EFei instance].account.needSignIn)
    {
        [self performSegueWithIdentifier:ShowSignInViewControllerSegueId sender:self];
    }
    
    if (_showNotebook)
    {
        self.selectedIndex = 1;
        _showNotebook = NO;
    }
    
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    NSInteger index = [self.viewControllers indexOfObject:viewController];
    return index != 0;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    NSInteger index = [tabBar.items indexOfObject:item];
    NSLog(@"selected item at index: %ld", index);
    if (index == 0)
    {
        _showNotebook = YES;
        [self performSegueWithIdentifier:ShowQRScanViewControllerSegueId sender:self];
    }
}

- (void) signOut
{
    [[EFei instance] signOut];
    self.selectedIndex = 1;
    [self performSegueWithIdentifier:ShowSignInViewControllerSegueId sender:self];
}

- (void) setupNetworkNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNetworkNotification:)
                                                 name:kNetworkNotificationName
                                               object:nil];
    
}

- (void) receiveNetworkNotification:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:kNetworkNotificationName])
    {
        NSString* error = notification.object;
        NSLog (@"Network notification %@", error);
        [ToastView showMessage:error];
    }
}

@end
