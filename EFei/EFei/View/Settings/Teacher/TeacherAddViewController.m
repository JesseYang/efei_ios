//
//  TeacherAddViewController.m
//  EFei
//
//  Created by Xiangzhen Kong on 1/8/15.
//
//

#import "TeacherAddViewController.h"
#import "EFei.h"
#import "SearchTeacherController.h"
#import "UserCommand.h"
#import "UIColor+Hex.h"
#import "TeacherClassViewController.h"

#define ShowTeacherClassViewControllerSegueId @"ShowTeacherClassViewController"

@interface TeacherAddViewController()
{
    
}

@property (weak, nonatomic) IBOutlet UILabel *teacherLabel;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

- (IBAction)onAddTeacher:(id)sender;
- (IBAction) onBack:(id)sender;

@end

@implementation TeacherAddViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNavigator];
    [self setupViews];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


- (void) setupNavigator
{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.title = @"添加教师";
    
    UIImage* backImage = [UIImage imageNamed:@"icon_setting_teacher_back.png"];
    self.navigationItem.leftBarButtonItem = [self barItemWithImage:backImage
                                                             title:@"返回"
                                                            target:self
                                                            action:@selector(onBack:)];
}

- (void) setupViews
{
    self.addButton.layer.cornerRadius = 5;
    self.addButton.backgroundColor = [EFei instance].efeiColor;
    
    self.teacherLabel.text = [NSString stringWithFormat:@"%@  %@  %@", self.teacher.school, self.teacher.subjectName, self.teacher.name];
}


- (UIBarButtonItem*)barItemWithImage:(UIImage*)image title:(NSString*)title target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0.0, 0.0, image.size.width + 50, image.size.height);
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [button setImage:image forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    
    CGSize imageSize = button.imageView.frame.size;
    button.imageEdgeInsets = UIEdgeInsetsMake(0.0, -imageSize.width, 0.0, 0.0);
    
    return barButtonItem;
}

- (IBAction)onAddTeacher:(id)sender
{
    if (self.teacher.classes.count > 1)
    {
        [self performSegueWithIdentifier:ShowTeacherClassViewControllerSegueId sender:self];
    }
    else
    {
        CompletionBlock handler = ^(NetWorkTaskType taskType, BOOL success) {
            
            if (success)
            {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            
        };
        
        [AddTeacherCommand executeWithTeacher:self.teacher completeHandler:handler];
    }
    
}

- (IBAction)onBack:(id)sender
{
    [[EFei instance].user addIgnoreTeacher:self.teacher.teacherId];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:ShowTeacherClassViewControllerSegueId])
    {
        TeacherClassViewController* tcVC = (TeacherClassViewController*)segue.destinationViewController;
        tcVC.teacher = self.teacher;
    }
}

@end
