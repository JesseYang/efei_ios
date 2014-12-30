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

#define EditTagSegueId @"ShowTagViewController"
#define EditKnowledgeSegueId @"ShowKnowledgeViewController"

@interface QuestionViewController()<UITableViewDataSource, UITableViewDelegate, QuestionViewDelegate>
{
    NSArray* _noteTableTitles;
    NSArray* _noteTableContentLables;
    
    Note* _note;
}

@property (weak, nonatomic) IBOutlet QuestionView *questionView;

@property (weak, nonatomic) IBOutlet UITableView *noteTableView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


- (IBAction)onDone:(id)sender;


@end

@implementation QuestionViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
    
    self.noteTableView.dataSource = self;
    self.noteTableView.delegate = self;
    
    self.questionView.delegate = self;
    
    GetQuestionController* controller = [GetQuestionController instance];
    Question* question = [controller.questionList.questions lastObject];
    self.questionView.question = question;
    NSLog(@"question view controller load");
    
    _note = [[Note alloc] initWithQuestion:question];
    
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

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    [self.noteTableView reloadData];
}


- (IBAction)onDone:(id)sender
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
