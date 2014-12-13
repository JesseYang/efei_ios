//
//  TagViewController.m
//  EFei
//
//  Created by Xiangzhen Kong on 12/12/14.
//
//

#import "TagViewController.h"
#import "Note.h"

@interface TagViewController()<UITableViewDataSource, UITableViewDelegate>
{
    NSArray* _tagTitles;
    
    NSInteger _selectedTagIndex;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end

@implementation TagViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNavigator];
    [self setupViews];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    CGRect frame = self.tableView.frame;
    frame.size.height = 136 + _tagTitles.count * 44;
    self.tableView.frame = frame;
}


- (void) setupNavigator
{
    self.navigationItem.title = @"标签编辑";
    
    UIBarButtonItem* doneBBI = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleBordered target:self action:@selector(onDone:)];
    
    self.navigationItem.rightBarButtonItem = doneBBI;
}

- (void) setupViews
{
    _tagTitles = [NSArray arrayWithObjects:
                  @"不懂",
                  @"不会",
                  @"不对",
                  @"典型题",
                  @"计算错误",
                  @"概念错误",nil];
    
    _tagTitles = self.note.tags;
    
    _selectedTagIndex = -1;
    
    _titleLabel.text = @"请选择一个您想添加的标签";
    
}

- (void) onDone:(id)sender
{
    if (_selectedTagIndex >= 0)
    {
        self.note.tag = [_tagTitles objectAtIndex:_selectedTagIndex];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
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
    return _tagTitles.count;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"TagTableViewCell" forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:@"icon_question_tag.jpg"];
    cell.textLabel.text = [_tagTitles objectAtIndex:indexPath.row];
    
    if (cell.accessoryView == nil)
    {
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        imageView.image = nil;
        imageView.highlightedImage = [UIImage imageNamed:@"icon_question_tag_selected.jpg"];
        cell.accessoryView = imageView;
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
    if (_selectedTagIndex >= 0)
    {
        NSIndexPath *preIndexPath = [NSIndexPath indexPathForRow:_selectedTagIndex inSection:0];
        UITableViewCell* cell = [tableView cellForRowAtIndexPath:preIndexPath];
        UIImageView* imageView = (UIImageView*)cell.accessoryView;
        
        imageView.highlighted = NO;
    }
    
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    UIImageView* imageView = (UIImageView*)cell.accessoryView;
    
    imageView.highlighted = !imageView.highlighted;
    
    _selectedTagIndex = imageView.highlighted ? indexPath.row : -1;
}

//- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return @"Select a tag";
//}
//
//- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
//{
//    UITableViewHeaderFooterView *v = (UITableViewHeaderFooterView *)view;
//    v.textLabel.font = [UIFont systemFontOfSize:15];
//    v.textLabel.textAlignment = NSTextAlignmentCenter;
//    v.backgroundView.backgroundColor = [UIColor whiteColor];
//}

@end
