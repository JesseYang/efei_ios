//
//  SubjectViewController.m
//  EFei
//
//  Created by Xiangzhen Kong on 1/13/15.
//
//

#import "SubjectViewController.h"

#import "EFei.h"

@interface SubjectViewController()
{
    NSArray* _subjectNames;
}

@end

@implementation SubjectViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNavigator];
    [self setupData];
    [self setupViews];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


- (void) setupNavigator
{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.title = @"选择学科";
}

- (void) setupData
{
    _subjectNames = [NSArray arrayWithObjects:@"语文", @"数学", @"英语", @"物理",
                                        @"化学", @"生物", nil];
}

- (void) setupViews
{
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
}

- (NSInteger) indexOfSubject:(SubjectType)type
{
//    SubjectTypeChinese      = 1,
//    SubjectTypeMathematics  = 2,
//    SubjectTypeEnglish      = 4,
//    SubjectTypePhysics      = 8,
//    SubjectTypeChemistry    = 16,
//    SubjectTypeBiology      = 32,
//    SubjectTypeHistroy      = 64,
//    SubjectTypeGeography    = 128,
//    SubjectTypePolitics     = 256,
//    SubjectTypeOther        = 512,
//    SubjectTypeAll          = 1024,
    
    NSInteger index = 0;
    switch (type)
    {
        case SubjectTypeChinese:
            index = 0;
            break;
            
        case SubjectTypeMathematics:
            index = 1;
            break;
            
        case SubjectTypeEnglish:
            index = 2;
            break;
            
        case SubjectTypePhysics:
            index = 3;
            break;
            
        case SubjectTypeChemistry:
            index = 4;
            break;
            
        case SubjectTypeBiology:
            index = 5;
            break;
            
        case SubjectTypeHistroy:
            index = 6;
            break;
        
        case SubjectTypeGeography:
            index = 7;
            break;
            
        case SubjectTypePolitics:
            index = 8;
            break;
            
        case SubjectTypeOther:
            index = 9;
            break;
            
        case SubjectTypeAll:
            index = 10;
            break;
            
        default:
            break;
    }
    
    return index;
}

- (SubjectType) subjectTypeWithIndex:(NSInteger)index
{
    SubjectType type = SubjectTypeAll;
    switch (index)
    {
        case 0:
            type = SubjectTypeChinese;
            break;
            
        case 1:
            type = SubjectTypeMathematics;
            break;
            
        case 2:
            type = SubjectTypeEnglish;
            break;
            
        case 3:
            type = SubjectTypePhysics;
            break;
            
        case 4:
            type = SubjectTypeChemistry;
            break;
            
        case 5:
            type = SubjectTypeBiology;
            break;
            
        case 6:
            type = SubjectTypeHistroy;
            break;
            
        case 7:
            type = SubjectTypeGeography;
            break;
            
        case 8:
            type = SubjectTypePolitics;
            break;
            
        default:
            break;
    }
    
    return type;
}


-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    // Force your tableview margins (this may be a bad idea)
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _subjectNames.count;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"SubjectTableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = [_subjectNames objectAtIndex:indexPath.row];
    UIView* view = [[UIView alloc] initWithFrame:cell.bounds];
    view.backgroundColor = [EFei instance].efeiColor;
    cell.selectedBackgroundView = view;
    
    if (indexPath.row == [self indexOfSubject:self.subjectType])
    {
        [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.subjectType = [self subjectTypeWithIndex:indexPath.row];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    self.doneBlock(self.subjectType);
}



@end
