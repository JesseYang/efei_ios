//
//  QuestionViewController.m
//  EFei
//
//  Created by Xiangzhen Kong on 12/2/14.
//
//

#import "QuestionViewController.h"
#import "GetQuestionController.h"
#import "RichTextView.h"
#import "QuestionView.h"
#import "NoteTagViewController.h"
#import "NoteTopicViewController.h"
#import "Note.h"
#import "NotebookCommand.h"
#import "PopupMenu.h"
#import "EFei.h"
#import "UIPlaceHolderTextView.h"
#import "NotebookExportViewController.h"
#import "ToastView.h"

#define EditTagSegueId @"ShowTagViewController"
#define EditKnowledgeSegueId @"ShowKnowledgeViewController"
#define ShowNotebookExportViewControllerSegueId @"ShowNotebookExportViewController"

@interface QuestionViewController()<UITableViewDataSource, UITableViewDelegate, QuestionViewDelegate, PopupMenuDelegate>
{
    NSArray* _noteTableTitles;
    NSArray* _noteTableContentLables;
    
    PopupMenu* _popupMenu;
    
    BOOL _noteModified;
    
    Note* _backupNote;
}

@property (weak, nonatomic) IBOutlet QuestionView *questionView;
@property (weak, nonatomic) IBOutlet UITableView *noteTableView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPlaceHolderTextView *summaryTextView;


@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightBBI;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *questionViewHeightConstraint;

- (IBAction)onDone:(id)sender;
- (IBAction)onMore:(id)sender;
- (IBAction)onBack:(id)sender;

@end

@implementation QuestionViewController

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
    
    [self.noteTableView reloadData];
}


- (void) setupNavigator
{
    self.navigationController.navigationBarHidden = NO;
}

- (void) setupData
{
    _noteTableTitles = [NSArray arrayWithObjects:@"标签", @"知识点", nil];
    
    CGRect rect = CGRectMake(0, 0, 100, 50);
    UILabel* label1 = [[UILabel alloc] initWithFrame:rect];
    label1.font = [UIFont systemFontOfSize:15];
    label1.textAlignment = NSTextAlignmentRight;
    
    UILabel* label2 = [[UILabel alloc] initWithFrame:rect];
    label2.font = [UIFont systemFontOfSize:15];
    label2.textAlignment = NSTextAlignmentRight;
    _noteTableContentLables = [NSArray arrayWithObjects:label1, label2, nil];
    
    _backupNote = [[Note alloc] init];
    _backupNote.tag = self.note.tag;
    _backupNote.topics = [NSArray arrayWithArray:self.note.topics];
}

- (void) setupViews
{
    [self updateScrollSize];
    
    self.noteTableView.dataSource = self;
    self.noteTableView.delegate = self;
    
    self.questionView.delegate = self;
    
    self.questionView.question = self.note;
    
    self.summaryTextView.placeholder = @"总结";
    
    NSArray* imageNames = [NSArray arrayWithObjects:
                           @"icon_notebook_delete.png",@"icon_notebook_delete.png",
                           @"icon_notebook_export.png", @"icon_notebook_export.png", nil];
    
    NSMutableArray* images = [[NSMutableArray alloc] initWithCapacity:imageNames.count];
    for (NSString* name in imageNames)
    {
        UIImage* image = [UIImage imageNamed:name];
        [images addObject:image];
    }
    NSArray* titles = [NSArray arrayWithObjects:@"删除",@"导出", nil];
    
    _popupMenu = [[PopupMenu alloc] initWithMenuItemSize:CGSizeMake(80, 30)
                                           menuItemCount:titles.count
                                                  titles:titles
                                                  images:images
                                         backgroundColor:[EFei instance].efeiColor
                                          seperatorColor:[UIColor colorWithWhite:1.0 alpha:0.8]];
    _popupMenu.delegate = self;
    
    
    if (self.note.noteId.length > 0)
    {
        self.rightBBI.title = @"保存";
        
        self.summaryTextView.text = self.note.summary;
        
        UIImage* backImage = [UIImage imageNamed:@"icon_setting_teacher_back.png"];
        self.navigationItem.leftBarButtonItem = [self barItemWithImage:backImage
                                                                 title:@"返回"
                                                                target:self
                                                                action:@selector(onBack:)];
        
        UIImage* moreImage = [UIImage imageNamed:@"icon_notebook_question_more.png"];
        UIBarButtonItem* bbi = [[UIBarButtonItem alloc] initWithImage:moreImage
                                                                style:UIBarButtonItemStylePlain
                                                               target:self
                                                               action:@selector(onMore:)];
        
        
        self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:bbi, self.rightBBI, nil];
    }
    else
    {
        self.rightBBI.title = @"保存";
    }
}

- (void) updateScrollSize
{
    UIScrollView* scrollView = (UIScrollView*)self.view;
    
    if ([scrollView isKindOfClass:[UIScrollView class]])
    {
        CGSize size = self.view.frame.size;
        size.height = self.summaryTextView.frame.origin.y + self.summaryTextView.frame.size.height;
        scrollView.contentSize = size;
    }
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

- (void) viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    float height = self.questionView.viewHeight;
    [self.questionViewHeightConstraint setConstant:height];
    
    [self updateScrollSize];
}

#pragma mark -- Action

- (IBAction)onBack:(id)sender
{
    // recover note
    self.note.tag = _backupNote.tag;
    self.note.topics = [NSArray arrayWithArray:_backupNote.topics];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
//    if (![self.note.summary isEqualToString:_summaryTextView.text])
//    {
//        self.note.summary = _summaryTextView.text;
//        self.note.modified = YES;
//    }
//    
//    if (self.note.modified && self.note.noteId.length > 0)
//    {
//        CompletionBlock handler = ^(NetWorkTaskType taskType, BOOL success) {
//            
//            if (success)
//            {
//                self.note.modified = NO;
//            }
//            
//            [self.navigationController popViewControllerAnimated:YES];
//        };
//        [NotebookUpdateNoteCommand executeWithNote:self.note completeHandler:handler];
//    }
//    else
//    {
//        [self.navigationController popViewControllerAnimated:YES];
//    }
}

- (IBAction)onDone:(id)sender
{
    if (self.note.noteId.length > 0)
    {
        [self updateNote];
    }
    else
    {
        [self addQuestionAsNote];
    }
}

- (IBAction) onMore:(id)sender
{
    [self showNoteOperationMenu];
}

- (void) updateNote
{
    CompletionBlock handler = ^(NetWorkTaskType taskType, BOOL success) {
        
        if (success)
        {
            self.note.modified = NO;
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    };
    [NotebookUpdateNoteCommand executeWithNote:self.note completeHandler:handler];
}

- (void) addQuestionAsNote
{
    self.note.summary = _summaryTextView.text;
    
    if ([EFei instance].account.needSignIn)
    {
        [ToastView showMessage:kErrorMessageNeedSignIn];
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        CompletionBlock handler = ^(NetWorkTaskType taskType, BOOL success) {
            
            if (success)
            {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            
        };
        
        [AddQuestionToNotebookCommand executeWithNote:self.note completeHandler:handler];
    }
    
    
}

- (void) showNoteOperationMenu
{
    float x = self.view.frame.size.width - 30;
    [_popupMenu showAtPoint:CGPointMake(x, 65) withArrowOffset:0.8];
}

- (void) exportNote
{
    [self performSegueWithIdentifier:ShowNotebookExportViewControllerSegueId sender:self];
}

- (void) deleteNote
{
    CompletionBlock handler = ^(NetWorkTaskType taskType, BOOL success) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    };
    
    [NotebookDeleteNoteCommand executeWithNote:self.note completeHandler:handler];
}

#pragma mark -- PopupMenuDelegate

- (void) popupMenu:(PopupMenu *)menu didSelectItemAtIndex:(NSInteger)index
{
    switch (index)
    {
        case 0:
            [self deleteNote];
            break;
            
        case 1:
            [self exportNote];
            break;
            
        default:
            break;
    }
}

- (void) popupMenuDidDismiss:(PopupMenu *)menu
{
    
}


#pragma mark - QuestionView
- (void) questionView:(QuestionView *)question showHideAnswer:(BOOL)show withHeightChange:(float)delta
{
    [UIView animateWithDuration:0.5 animations:^{
        
        CGRect rect = self.noteTableView.frame;
        rect.origin.y += delta;
        self.noteTableView.frame = rect;
        
        rect = self.summaryTextView.frame;
        rect.origin.y += delta;
        self.summaryTextView.frame = rect;
    }];
}

#pragma mark - UITableView

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _noteTableTitles.count;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    cell.textLabel.text = [_noteTableTitles objectAtIndex:indexPath.row];
    
    UILabel* contentLabel = (UILabel*)[cell viewWithTag:999];
    if (contentLabel == nil)
    {
        UILabel* label = [_noteTableContentLables objectAtIndex:indexPath.row];
        label.tag = 999;
        CGRect rect = label.frame;
        rect.origin.x = cell.frame.size.width - rect.size.width - 50;
        label.frame = rect;
        
        [cell addSubview:label];
        
        contentLabel = label;
    }
    
    if (indexPath.row == 0)
    {
        contentLabel.text = self.note.tag;
    }
    else if (indexPath.row == 1)
    {
        contentLabel.text = self.note.topicString;// [self.note.topics firstObject];
    }
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0)
    {
        [self performSegueWithIdentifier:EditTagSegueId sender:self];
    }
    else if (indexPath.row == 1)
    {
        [self performSegueWithIdentifier:EditKnowledgeSegueId sender:self];
    }
    
}

#pragma mark - Navigation

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:EditTagSegueId])
    {
        NoteTagViewController* tagVC = (NoteTagViewController*)segue.destinationViewController;
        tagVC.note = self.note;
    }
    else if ([segue.identifier isEqualToString:EditKnowledgeSegueId])
    {
        NoteTopicViewController* knowledgeVC = (NoteTopicViewController*)segue.destinationViewController;
        knowledgeVC.note = self.note;
    }
    else if([segue.identifier isEqualToString:ShowNotebookExportViewControllerSegueId])
    {
        NotebookExportViewController* exportVC = (NotebookExportViewController*)segue.destinationViewController;
        exportVC.notes = [NSArray arrayWithObjects:self.note, nil];
    }
}


@end
