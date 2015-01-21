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


@interface TeacherAddViewController()
{
    
}

@property (weak, nonatomic) IBOutlet UILabel *teacherLabel;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

- (IBAction)onAddTeacher:(id)sender;

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
    
    Teacher* teacher = [SearchTeacherController instance].teacherToAdd;
    self.teacherLabel.text = [NSString stringWithFormat:@"%@  %@  %@", teacher.school, teacher.subjectName, teacher.name];
}

- (IBAction)onAddTeacher:(id)sender
{
    Teacher* teacher = [SearchTeacherController instance].teacherToAdd;
    CompletionBlock handler = ^(NetWorkTaskType taskType, BOOL success) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    };
    [AddTeacherCommand executeWithTeacher:teacher completeHandler:handler];
}

@end
