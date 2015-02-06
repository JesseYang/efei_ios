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
}

- (void) setupViews
{
    self.addButton.layer.cornerRadius = 5;
    self.addButton.backgroundColor = [EFei instance].efeiColor;
    
    self.teacherLabel.text = [NSString stringWithFormat:@"%@  %@  %@", self.teacher.school, self.teacher.subjectName, self.teacher.name];
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
