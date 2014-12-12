//
//  QuestionViewController.m
//  EFei
//
//  Created by Xiangzhen Kong on 12/2/14.
//
//

#import "QuestionViewController.h"
#import "GetQuestionController.h"
#import "NoteTextView.h"
#import "QuestionView.h"

#define EditTagSegueId @"ShowTagViewController"
#define EditKnowledgeSegueId @"ShowKnowledgeViewController"

@interface QuestionViewController()<UITableViewDataSource, UITableViewDelegate>
{
    NSArray* _noteTableTitles;
    NSArray* _noteTableContentLables;
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
    
    self.noteTableView.dataSource = self;
    self.noteTableView.delegate = self;
    
    
    GetQuestionController* controller = [GetQuestionController instance];
    Question* question = [controller.questionList.questions lastObject];
    self.questionView.question = question;
    NSLog(@"question view controller load");
    
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
    
    
    
    
    CGRect questionRect = self.questionView.frame;
    questionRect.size.height = 300;
    self.questionView.frame = questionRect;
    [self.view layoutIfNeeded];
}

- (IBAction)onDone:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _noteTableTitles.count;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    cell.textLabel.text = [_noteTableTitles objectAtIndex:indexPath.row];
    
    UILabel* label = [_noteTableContentLables objectAtIndex:indexPath.row];
    CGRect rect = label.frame;
    rect.origin.x = cell.frame.size.width - rect.size.width - 50;
    label.frame = rect;
    
    [cell addSubview:label];
    
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


@end
