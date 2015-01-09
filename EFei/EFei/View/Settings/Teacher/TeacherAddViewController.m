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
    self.teacherLabel.text = [NSString stringWithFormat:@"%@  %@  %@", teacher.school, teacher.subject, teacher.name];
}

- (IBAction)onAddTeacher:(id)sender
{
    
}

@end