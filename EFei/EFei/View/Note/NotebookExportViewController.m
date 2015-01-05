//
//  NotebookExportViewController.m
//  EFei
//
//  Created by Xiangzhen Kong on 1/5/15.
//
//

#import "NotebookExportViewController.h"

@interface NotebookExportViewController()<UITableViewDataSource, UITableViewDelegate>
{
    NSArray* _exportFormatArray;
    NSArray* _exportContentArray;
    NSArray* _exportDestinationArray;
    
}

@property (weak, nonatomic) IBOutlet UILabel *noteCountLabel;
@property (weak, nonatomic) IBOutlet UITableView *exportFormatTableView;
@property (weak, nonatomic) IBOutlet UITableView *exportContentTableView;
@property (weak, nonatomic) IBOutlet UITableView *exprotDestinationTableView;
@property (weak, nonatomic) IBOutlet UIImageView *emailImageView;
@property (weak, nonatomic) IBOutlet UITextField *emailTextFeild;


@end

@implementation NotebookExportViewController

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
    self.navigationItem.title = @"导出";
    
    UIBarButtonItem* doneBBI = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleBordered target:self action:@selector(onDone:)];
    
    self.navigationItem.rightBarButtonItem = doneBBI;
}

- (void) setupData
{
    _exportFormatArray = [NSArray arrayWithObjects:
                  @"导出Word文档",
                  @"导出Pdf文档",nil];
    
    _exportContentArray = [NSArray arrayWithObjects:
                          @"包含答案",
                          @"包含笔记",nil];
    
    _exportDestinationArray = [NSArray arrayWithObjects:
                          @"直接下载",
                          @"发送至邮箱",nil];

    
}

- (void) setupViews
{
    self.noteCountLabel.text = [NSString stringWithFormat:@"导出选中的 %ld 道题目", self.notes.count];
}

- (void) onDone:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    // Force your tableview margins (this may be a bad idea)
    if ([self.exportFormatTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.exportFormatTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.exportFormatTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.exportFormatTableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    
    if ([self.exportContentTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.exportContentTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.exportContentTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.exportContentTableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    
    if ([self.exprotDestinationTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.exprotDestinationTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.exprotDestinationTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.exprotDestinationTableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark -- UITableView

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.exportFormatTableView)
    {
        return _exportFormatArray.count;
    }
    
    if (tableView == self.exportContentTableView)
    {
        return _exportContentArray.count;
    }
    
    
    if (tableView == self.exprotDestinationTableView)
    {
        return _exportDestinationArray.count;
    }
    
    return 0;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ExportOptionCell" forIndexPath:indexPath];

//    UIView *bgColorView = [[UIView alloc] init];
//    bgColorView.backgroundColor = [UIColor whiteColor];
//    [cell setSelectedBackgroundView:bgColorView];
    
    if (tableView == self.exportFormatTableView)
    {
        cell.textLabel.text = [_exportFormatArray objectAtIndex:indexPath.row];
    }
    
    if (tableView == self.exportContentTableView)
    {
        cell.textLabel.text = [_exportContentArray objectAtIndex:indexPath.row];
    }
    
    
    if (tableView == self.exprotDestinationTableView)
    {
        cell.textLabel.text = [_exportDestinationArray objectAtIndex:indexPath.row];
    }
    
    if (cell.accessoryView == nil)
    {
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 18, 18)];
        imageView.image = nil;
        imageView.highlightedImage = [UIImage imageNamed:@"icon_notebook_select.png"];
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
    if (tableView == self.exprotDestinationTableView)
    {
        self.emailTextFeild.enabled = (indexPath.row == 1);
        self.emailImageView.highlighted = (indexPath.row == 1);
    }
    
}


@end
