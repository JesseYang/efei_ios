//
//  SettinsViewController.m
//  EFei
//
//  Created by Xiangzhen Kong on 12/16/14.
//
//

#import "SettinsViewController.h"
#import "EFei.h"
#import "MainViewController.h"
#import "FeedbackViewController.h"

#define NavigationBarTilte @"设置"

#define PersonalSettingsImage @"icon_settings_personal.jpg"
#define RightArrowImage @"icon_settings_arrow.png"

#define CellReuseIdentifier @"CellReuseIdentifier"

#define TitlePersonal @"个人设置"
#define TitleMyTeachers @"我的老师"
#define TitleAbout @"关于易飞"
#define TitleFeedback @"意见反馈"

#define LogoutButtonTitle @"退出登录"

#define ShowTeacherViewControllerSegueId @"ShowTeacherViewController"
#define ShowFeedbackViewControllerSegueId @"ShowFeedbackViewController"

@interface SettinsViewController()<UITableViewDataSource, UITableViewDelegate>
{
    NSArray*      _titlesArray;
    NSArray*      _actionArray;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)onSignOut:(id)sender;

@end

@implementation SettinsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNavigationBar];
    [self setupData];
}


- (void) setupNavigationBar
{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.title = NavigationBarTilte;
    
//    UIBarButtonItem*  backNavigationItem= [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:NavigationBackImage]
//                                                                           style:UIBarButtonItemStylePlain
//                                                                          target:self
//                                                                          action:@selector(onBack:)];
//    
//    if([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0)
//    {
//        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//        negativeSpacer.width = -10;
//        self.navigationItem.leftBarButtonItems = @[negativeSpacer, backNavigationItem];
//    }
//    else
//    {
//        self.navigationItem.leftBarButtonItem = backNavigationItem;
//    }
}

- (void) setupData
{
    _titlesArray = @[@[TitlePersonal],
                     @[TitleMyTeachers, TitleAbout, TitleFeedback]];
    
    _actionArray = @[@[@"onPersonalClicked"],
                     @[@"onMyTeachersClicked", @"onAboutClicked", @"onFeedbackClicked"]];
    
}

- (IBAction)onSignOut:(id)sender
{
    MainViewController* mainVC = (MainViewController*)self.tabBarController;
    [mainVC signOut];
}


#pragma mark - UITableView

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return _titlesArray.count;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray* array = [_titlesArray objectAtIndex:section];
    return array.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 22.0f;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellReuseIdentifier forIndexPath:indexPath];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellReuseIdentifier];
    }
    
    NSArray* titles = [_titlesArray objectAtIndex:indexPath.section];
    
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.text = [titles objectAtIndex:indexPath.row];
    
    if (indexPath.section == 0)
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
        UIImageView* icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:PersonalSettingsImage]];
        icon.frame = CGRectMake(0, 0, cell.frame.size.height, cell.frame.size.height);
        cell.accessoryView = icon;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}



- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSArray* array = [_actionArray objectAtIndex:indexPath.section];
    NSString* actionString = [array objectAtIndex:indexPath.row];
    
    SEL selector = NSSelectorFromString(actionString);
    IMP imp = [self methodForSelector:selector];
    void (*func)(id, SEL) = (void *)imp;
    func(self, selector);
}

#pragma mark - Navigation

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}

#pragma mark - Actions


- (void) onPersonalClicked
{
    [self performSegueWithIdentifier:@"ShowPersonalSettingViewController" sender:self];
}

- (void) onMyTeachersClicked
{
    [self performSegueWithIdentifier:ShowTeacherViewControllerSegueId sender:self];
}

- (void) onAboutClicked
{
}

- (void) onFeedbackClicked
{
    [self performSegueWithIdentifier:ShowFeedbackViewControllerSegueId sender:self];
}

@end

