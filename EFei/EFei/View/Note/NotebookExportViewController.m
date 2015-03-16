//
//  NotebookExportViewController.m
//  EFei
//
//  Created by Xiangzhen Kong on 1/5/15.
//
//

#import "NotebookExportViewController.h"
#import "EFei.h"
#import "NotebookCommand.h"
#import "ToastView.h"
#import "ExportNotesController.h"

#import "SetEmailController.h"

@interface NotebookExportViewController()<UITableViewDataSource, UITableViewDelegate, UIDocumentInteractionControllerDelegate>
{
    NSArray* _exportFormatArray;
    NSArray* _exportContentArray;
    NSArray* _exportDestinationArray;
    
    
    
    NSString*  _fileType;
    BOOL       _hasAnswer;
    BOOL       _hasNote;
    NSString*  _email;
    ExportDestination _destination;
}

@property (weak, nonatomic) IBOutlet UILabel *noteCountLabel;
@property (weak, nonatomic) IBOutlet UITableView *exportFormatTableView;
@property (weak, nonatomic) IBOutlet UITableView *exportContentTableView;
@property (weak, nonatomic) IBOutlet UITableView *exprotDestinationTableView;
@property (weak, nonatomic) IBOutlet UIImageView *emailImageView;
@property (weak, nonatomic) IBOutlet UITextField *emailTextFeild;

@property (nonatomic, retain) UIDocumentInteractionController* documentInteractionController;

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
    
    NSString* email = @"发送至邮箱（未设置）";
    if ([EFei instance].user.email.length > 0)
    {
        email = [NSString stringWithFormat:@"发送至 %@", [EFei instance].user.email];
    }
    
    _exportDestinationArray = [NSArray arrayWithObjects:
                          @"直接下载",
                          email,nil];
    

    _fileType = @"word";
    
    NotebookExportSetting* settings = [EFei instance].settings.exportSetting;
    _fileType = settings.fileType;
    _hasAnswer = settings.hasAnswer;
    _hasNote = settings.hasNote;
    _email = settings.email;
    _destination = settings.destination;
    
    self.emailTextFeild.text = _email;
    if (_destination == ExportDestinationEmail)
    {
        self.emailTextFeild.enabled = YES;
        self.emailImageView.highlighted = YES;
        self.emailTextFeild.backgroundColor = [UIColor whiteColor];
    }
    else
    {
        self.emailTextFeild.enabled = NO;
        self.emailImageView.highlighted = NO;
        self.emailTextFeild.backgroundColor = [UIColor lightGrayColor];
    }
}

- (void) setupViews
{
    self.noteCountLabel.text = [NSString stringWithFormat:@"导出选中的 %ld 道题目", self.notes.count];
}

- (void) onDone:(id)sender
{
    if (self.notes.count == 0)
    {
        return;
    }
    
//    if (self.emailTextFeild.enabled)
//    {
//        _email = self.emailTextFeild.text;
//    }
//    else
//    {
//        _email = @"";
//    }
    
    _email = [EFei instance].user.email;
    
    if (![self checkSetting])
    {
        return;
    }
    
    NotebookExportSetting* settings = [EFei instance].settings.exportSetting;
    settings.fileType  = _fileType;
    settings.hasAnswer = _hasAnswer;
    settings.hasNote   = _hasNote;
    settings.email     = _email;
    settings.destination = _destination;
    
    CompletionBlock handler = ^(NetWorkTaskType taskType, BOOL success) {
        
        if (success)
        {
            if (_destination == ExportDestinationDownload)
            {
                [self downloadFile];
            }
            else
            {
                [ToastView showMessage:kErrorMessageSendToMailSuccess];
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        }
    };
    
    [NotebookExportCommand executeWithNotes:self.notes fileType:_fileType hasAnswer:_hasAnswer hasNote:_hasNote email:_email completeHandler:handler];
}

- (void) downloadFile
{
    ExportNotesControllerDoneBlock handler = ^(BOOL success) {
        
        if (success)
        {
            [ToastView showMessage:kErrorMessageDownloadSuccess];
            [self openFile];
        }
        else
        {
            [ToastView showMessage:kErrorMessageDownloadFailed];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    };
    [[ExportNotesController instance] startDonwloadWithBlock:handler];
}

- (void) openFile
{
    dispatch_async(dispatch_get_main_queue(), ^() {
        
        
        NSURL *url = [NSURL fileURLWithPath:[ExportNotesController instance].filePath];
        
        if (url != nil)
        {
            // Initialize Document Interaction Controller
            self.documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:url];
            
            // Configure Document Interaction Controller
            [self.documentInteractionController setDelegate:self];
            
            // Preview PDF
            //        [documentInteractionController presentPreviewAnimated:YES];
            CGRect rect = CGRectMake(0, 0, 100, 100);
            [self.documentInteractionController presentOpenInMenuFromRect:rect inView:self.view animated:YES];
        }
        
    });
}


- (BOOL) checkSetting
{
    if (_destination == ExportDestinationNone)
    {
        [ToastView showMessage:kErrorMessageNoExportDestination];
        return NO;
    }
    
//    if (_destination == ExportDestinationEmail)
//    {
//        if ([self isValidEmail:_email])
//        {
//            return YES;
//        }
//        else
//        {
//            [ToastView showMessage:kErrorMessageWrongEmail];
//            return NO;
//        }
//    }
    
    return YES;
}

- (BOOL) isValidEmail:(NSString*)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

- (void) gotoEmailSetting
{
    NSArray* vcs = self.tabBarController.viewControllers;
    if (vcs.count >= 3)
    {
        [SetEmailController instance].autoSet = YES;
        self.tabBarController.selectedIndex = 2;
    }
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

#pragma mark -- UIDocumentInteractionController

- (void)documentInteractionController:(UIDocumentInteractionController *)controller didEndSendingToApplication:(NSString *)application
{
    [self.navigationController popViewControllerAnimated:YES];
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

    
    UIImageView* imageView = nil;
    if (cell.accessoryView == nil)
    {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 18, 18)];
        cell.accessoryView = imageView;
    }
    imageView = (UIImageView*)cell.accessoryView;
    
    if (tableView == self.exportFormatTableView)
    {
        cell.textLabel.text = [_exportFormatArray objectAtIndex:indexPath.row];
    }
    
    if (tableView == self.exportContentTableView)
    {
        cell.textLabel.text = [_exportContentArray objectAtIndex:indexPath.row];
        
        if ((indexPath.row == 0 && _hasAnswer) || (indexPath.row==1 && _hasNote))
        {
            imageView.image = [UIImage imageNamed:@"icon_notebook_select.png"];
        }
        else
        {
            imageView.image = nil;
        }
    }
    
    
    if (tableView == self.exprotDestinationTableView)
    {
        cell.textLabel.text = [_exportDestinationArray objectAtIndex:indexPath.row];
        
        if ((indexPath.row == 0 && _destination == ExportDestinationDownload)
            ||(indexPath.row == 1 && _destination == ExportDestinationEmail))
        {
            imageView.image = [UIImage imageNamed:@"icon_notebook_select.png"];
        }
        else
        {
            imageView.image = nil;
        }
        
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
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (tableView == self.exprotDestinationTableView)
    {
        self.emailTextFeild.enabled = (indexPath.row == 1);
        self.emailImageView.highlighted = (indexPath.row == 1);
        
        if (indexPath.row == 0)
        {
            _destination = ExportDestinationDownload;
        }
        else if(indexPath.row == 1)
        {
            if ([EFei instance].user.email.length > 0)
            {
                _destination = ExportDestinationEmail;
            }
            else
            {
                [self gotoEmailSetting];
                return;
            }
        }
        
        if (self.emailTextFeild.enabled)
        {
            self.emailTextFeild.backgroundColor = [UIColor whiteColor];
        }
        else
        {
            self.emailTextFeild.backgroundColor = [UIColor lightGrayColor];
        }
    }
    
    if (tableView == self.exportFormatTableView)
    {
        if (indexPath.row == 0)
        {
            _fileType = @"word";
        }
        else if(indexPath.row == 1)
        {
            _fileType = @"pdf";
        }
    }
    
    
    if (tableView == self.exportContentTableView)
    {
        if (indexPath.row == 0)
        {
            _hasAnswer = !_hasAnswer;
        }
        else if(indexPath.row == 1)
        {
            _hasNote = !_hasNote;
        }
    }
    
    [tableView reloadData];
}


@end
