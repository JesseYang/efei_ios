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

#define EditTagSegueId @"ShowTagViewController"
#define EditKnowledgeSegueId @"ShowKnowledgeViewController"

@interface QuestionViewController()<UITableViewDataSource, UITableViewDelegate, QuestionViewDelegate, PopupMenuDelegate>
{
    NSArray* _noteTableTitles;
    NSArray* _noteTableContentLables;
    
    PopupMenu* _popupMenu;
}

@property (weak, nonatomic) IBOutlet QuestionView *questionView;

@property (weak, nonatomic) IBOutlet UITableView *noteTableView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightBBI;


- (IBAction)onDone:(id)sender;


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
}

- (void) setupViews
{
    self.noteTableView.dataSource = self;
    self.noteTableView.delegate = self;
    
    self.questionView.delegate = self;
    
    self.questionView.question = self.note;
    
    
    
    
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
        self.rightBBI.title = @"操作";
        
        
    }
    else
    {
        self.rightBBI.title = @"保存";
    }
}

#pragma mark -- Action

- (IBAction)onDone:(id)sender
{
    if (self.note.noteId.length > 0)
    {
        [self showNoteOperationMenu];
    }
    else
    {
        [self addQuestionAsNote];
    }
}

- (void) addQuestionAsNote
{
    _note.summary = @"";
    
    CompletionBlock handler = ^(NetWorkTaskType taskType, BOOL success) {
        
        if (success)
        {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
    };
    
    [AddQuestionToNotebookCommand executeWithNote:_note completeHandler:handler];
}

- (void) showNoteOperationMenu
{
    float x = self.view.frame.size.width - 30;
    [_popupMenu showAtPoint:CGPointMake(x, 65) withArrowOffset:0.8];
}

- (void) exportNote
{
    
}

- (void) deleteNote
{
    
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
        contentLabel.text = _note.tag;
    }
    else if (indexPath.row == 1)
    {
        if (_note.topics.count > 0)
        {
            contentLabel.text = [_note.topics firstObject];
        }
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
        tagVC.note = _note;
    }
    else if ([segue.identifier isEqualToString:EditKnowledgeSegueId])
    {
        NoteTopicViewController* knowledgeVC = (NoteTopicViewController*)segue.destinationViewController;
        knowledgeVC.note = _note;
    }
}


@end
