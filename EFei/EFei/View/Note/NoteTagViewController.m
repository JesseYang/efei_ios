//
//  TagViewController.m
//  EFei
//
//  Created by Xiangzhen Kong on 12/12/14.
//
//

#import "NoteTagViewController.h"
#import "Note.h"

@interface NoteTagViewController()<UITableViewDataSource, UITableViewDelegate>
{
    NSArray* _tagTitles;
    
    NSInteger _selectedTagIndex;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end

@implementation NoteTagViewController

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
    
    UIView* view = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.tableFooterView = view;
    
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
    cell.imageView.image = [UIImage imageNamed:@"icon_question_tag.png"];
    cell.textLabel.text = [_tagTitles objectAtIndex:indexPath.row];
    
    UIImageView* imageView = nil;
    if (cell.accessoryView == nil)
    {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 16, 16)];
        cell.accessoryView = imageView;
    }
    imageView = (UIImageView*)cell.accessoryView;
    if (indexPath.row == _selectedTagIndex)
    {
        imageView.image = [UIImage imageNamed:@"icon_question_tag_select.png"];
    }
    else
    {
        imageView.image = nil;
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _selectedTagIndex = indexPath.row;
    [tableView reloadData];
}

@end
