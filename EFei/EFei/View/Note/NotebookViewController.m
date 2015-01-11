//
//  MainViewController.m
//  EFei
//
//  Created by Xiangzhen Kong on 11/30/14.
//
//

#import "NotebookViewController.h"
#import "NoteCell.h"
#import "NotebookCommand.h"
#import "EFei.h"
#import "NotebookFilterViewController.h"
#import "SearchBarView.h"
#import "NotebookExportViewController.h"
#import "QuestionViewController.h"

#define NoteCellIdentifier @"NoteCellIdentifier"

#define ShowNotebookSearchViewControllerSegueId @"ShowNotebookSearchViewController"
#define ShowNotebookFilterViewControllerSegueId @"ShowNotebookFilterViewController"
#define ShowNotebookExportViewControllerSegueId @"ShowNotebookExportViewController"
#define ShowQuestionViewControllerSegueId       @"ShowQuestionViewController"

@interface NotebookViewController()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, SearchBarViewDelegate>
{
    NSArray* _notes;
    
    BOOL _selectMode;
    
    DataFilterType _filterType;
    
    SearchBarView* _searchBarView;
    
    
    UIBarButtonItem* _leftBBI;
    UIBarButtonItem* _rightBBI;
    UIBarButtonItem* _selectLeftBBI;
    UIBarButtonItem* _selectRightBBI;
    
    NSArray* _exportNotes;
    
    Note* _selectedNote;
}

@property (weak, nonatomic) IBOutlet UICollectionView *noteCollectionView;

@property (weak, nonatomic) IBOutlet UIView *selectAllView;
@property (weak, nonatomic) IBOutlet UIView *filtersView;
@property (weak, nonatomic) IBOutlet UIButton *selectAllButton;

- (IBAction)onSelectAll:(UIButton *)sender;

- (IBAction)onYiFei:(id)sender;
- (IBAction)onSelect:(id)sender;

- (IBAction)onSubjectFilter:(id)sender;
- (IBAction)onTimeFilter:(id)sender;
- (IBAction)onTageFilter:(id)sender;

- (void) onExportAll:(id)sender;
- (void) onExportNote:(id)sender event:(id)event;
- (void) onDeleteNote:(id)sender event:(id)event;

@end

@implementation NotebookViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNavigationBar];
    [self setupViews];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    _searchBarView.hidden = NO;
    _searchBarView.editing = NO;

    if (![EFei instance].account.needSignIn)
    {
        [self getNotes];
    }
}

- (void) setupNavigationBar
{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void) setupViews
{
    float width = self.view.frame.size.width - 140;
    float height = 30;
    float x = (self.navigationController.navigationBar.frame.size.width - width) / 2;
    float y = 5;
    CGRect rect = CGRectMake(x, y, width, height);
    _searchBarView = [[SearchBarView alloc] initWithFrame:rect];
    _searchBarView.delegate = self;
    
    [self.navigationController.navigationBar addSubview:_searchBarView];
    
    
//    _leftBBI = [[UIBarButtonItem alloc] initWithTitle:@"易" style:UIBarButtonItemStylePlain target:nil action:nil];
    UIView* leftView = [self viewWithTitle:@"易"
                                          image:nil
                                         action:nil];
    _leftBBI = [[UIBarButtonItem alloc] initWithCustomView:leftView];
    
    UIView* selectAllView = [self viewWithTitle:@"选择"
                                          image:[UIImage imageNamed:@"icon_notebook_select_all.png"]
                                         action:@selector(onSelect:)];
    _rightBBI = [[UIBarButtonItem alloc] initWithCustomView:selectAllView];
    
    
    UIView* exportAllView = [self viewWithTitle:@"导出"
                                          image:[UIImage imageNamed:@"icon_notebook_export_all.png"]
                                         action:@selector(onExportAll:)];
    _selectLeftBBI = [[UIBarButtonItem alloc] initWithCustomView:exportAllView];
    
    UIView* selectCancelView = [self viewWithTitle:@"取消"
                                             image:[UIImage imageNamed:@"icon_notebook_cancel.png"]
                                            action:@selector(onSelect:)];
    _selectRightBBI = [[UIBarButtonItem alloc] initWithCustomView:selectCancelView];
    
    
    self.navigationItem.leftBarButtonItem = _leftBBI;
    self.navigationItem.rightBarButtonItem = _rightBBI;
    
    self.noteCollectionView.allowsMultipleSelection = YES;
}

- (void) resetData
{
    _notes = [EFei instance].notebook.notes;
    [self.noteCollectionView reloadData];
}

- (UIView*) viewWithTitle:(NSString*)title image:(UIImage*)image action:(SEL)action
{
    UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [button setImage:image forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    
    if (image != nil)
    {
        button.titleLabel.font = [UIFont systemFontOfSize:9];
        
        CGFloat spacing = 6.0;
        
        CGSize imageSize = button.imageView.frame.size;
        button.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, - (imageSize.height + spacing), 0.0);
        
        CGSize titleSize = button.titleLabel.frame.size;
        button.imageEdgeInsets = UIEdgeInsetsMake(- (titleSize.height + spacing), 0.0, 0.0, - titleSize.width);
    }
    else
    {
        
    }
    
    
    return button;
}

- (void) getNotes
{
    if ([EFei instance].notebook.notes.count == 0)
    {
        CompletionBlock hanlder = ^(NetWorkTaskType taskType, BOOL success) {
            
            [self resetData];
            
        };
        
        [GetNoteListCommand executeWithCompleteHandler:hanlder];
    }
    else
    {
        if ([EFei instance].newNotesAdded)
        {
            [self resetData];
            [EFei instance].newNotesAdded = NO;
        }
    }
}

#pragma mark -- Action

- (void)onDeleteNote:(id)sender event:(id)event
{
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.noteCollectionView];
    NSIndexPath *indexPath = [self.noteCollectionView indexPathForItemAtPoint:currentTouchPosition];
    NoteCell* cell = (NoteCell*)[self.noteCollectionView cellForItemAtIndexPath:indexPath];
    cell.status = NoteCellStatusNone;
    
    Note* note = [_notes objectAtIndex:indexPath.row];
    
    CompletionBlock handler = ^(NetWorkTaskType taskType, BOOL success) {
        
        [self resetData];
        [self.noteCollectionView reloadData];
        
    };
    
    [NotebookDeleteNoteCommand executeWithNote:note completeHandler:handler];
}

- (void)onExportNote:(id)sender event:(id)event
{
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.noteCollectionView];
    NSIndexPath *indexPath = [self.noteCollectionView indexPathForItemAtPoint:currentTouchPosition];
    NoteCell* cell = (NoteCell*)[self.noteCollectionView cellForItemAtIndexPath:indexPath];
    cell.status = NoteCellStatusNone;
    
    Note* note = [_notes objectAtIndex:indexPath.row];
    _exportNotes = [NSArray arrayWithObjects:note, nil];
    
    [self performSegueWithIdentifier:ShowNotebookExportViewControllerSegueId sender:self];
}

- (void) onExportAll:(id)sender
{
    [self onSelect:nil];
    
    NSArray* indexArray = [self.noteCollectionView indexPathsForSelectedItems];
    NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:indexArray.count];
    for (NSIndexPath* indexPath in indexArray)
    {
        Note* note = [_notes objectAtIndex:indexPath.row];
        [array addObject:note];
    }
    _exportNotes = array;
    
    [self performSegueWithIdentifier:ShowNotebookExportViewControllerSegueId sender:self];
}

- (IBAction)onSelectAll:(UIButton *)sender
{
    NSInteger count = [self collectionView:self.noteCollectionView numberOfItemsInSection:0];
    if (sender.tag == 0)
    {
        [sender setImage:[UIImage imageNamed:@"icon_notebook_select.png"] forState:UIControlStateNormal];
        
        
        for (int i=0; i<count; i++)
        {
            NSIndexPath* index = [NSIndexPath indexPathForItem:i inSection:0];
            [self.noteCollectionView selectItemAtIndexPath:index
                                                  animated:NO
                                            scrollPosition:UICollectionViewScrollPositionNone];
        }
    }
    else
    {
        [sender setImage:[UIImage imageNamed:@"icon_notebook_unselect.png"] forState:UIControlStateNormal];
        
        
        for (int i=0; i<count; i++)
        {
            NSIndexPath* index = [NSIndexPath indexPathForItem:i inSection:0];
            [self.noteCollectionView deselectItemAtIndexPath:index animated:NO];
        }
    }
    
    sender.tag = 1 - sender.tag;

}

- (IBAction)onYiFei:(id)sender
{
    
}

- (IBAction)onSelect:(id)sender
{
    _selectMode = !_selectMode;
    
    [self.noteCollectionView performBatchUpdates:^{
        
//        NSInteger count = [self collectionView:self.noteCollectionView numberOfItemsInSection:0];
//        
//        for (int i=0; i<count; i++)
//        {
//            NSIndexPath* index = [NSIndexPath indexPathForItem:i inSection:0];
//            NoteCell* cell = (NoteCell*)[self.noteCollectionView cellForItemAtIndexPath:index];
//            cell.status = NoteCellStatusSelect;
//        }
        
        for (NoteCell* cell in self.noteCollectionView.visibleCells)
        {
            if (_selectMode)
            {
                cell.status = NoteCellStatusSelect;
            }
            else
            {
                cell.status = NoteCellStatusNone;
            }
        }
        
    } completion:^(BOOL finished) {
        
    }];
    
//    [self.noteCollectionView reloadData];
    
    if (_selectMode)
    {
        self.navigationItem.leftBarButtonItem = _selectLeftBBI;
        self.navigationItem.rightBarButtonItem = _selectRightBBI;
        
        self.selectAllView.hidden = NO;
        self.filtersView.hidden = YES;
        
        if (self.selectAllButton.tag != 0)
        {
            [self onSelectAll:self.selectAllButton];
        }
    }
    else
    {
        self.navigationItem.leftBarButtonItem = _leftBBI;
        self.navigationItem.rightBarButtonItem = _rightBBI;
        
        self.selectAllView.hidden = YES;
        self.filtersView.hidden = NO;
    }
}

- (IBAction)onSubjectFilter:(id)sender
{
    _filterType = DataFilterTypeSubject;
    [self performSegueWithIdentifier:ShowNotebookFilterViewControllerSegueId sender:self];
}

- (IBAction)onTimeFilter:(id)sender
{
    _filterType = DataFilterTypeTime;
    [self performSegueWithIdentifier:ShowNotebookFilterViewControllerSegueId sender:self];
    
}

- (IBAction)onTageFilter:(id)sender
{
    _filterType = DataFilterTypeTag;
    [self performSegueWithIdentifier:ShowNotebookFilterViewControllerSegueId sender:self];
}


#pragma mark -- Navigation

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:ShowNotebookFilterViewControllerSegueId])
    {
        _searchBarView.hidden = YES;
        
        NotebookFilterViewController* filterVC = (NotebookFilterViewController*)segue.destinationViewController;
        filterVC.filter = [[EFei instance].notebook fileterWithType:_filterType];
        
        filterVC.doneBlock = ^(DataFilter* filter){
            
        };
    }
    
    if ([segue.identifier isEqualToString:ShowNotebookExportViewControllerSegueId])
    {
        _searchBarView.hidden = YES;
        
        NotebookExportViewController* exportVC = (NotebookExportViewController*)segue.destinationViewController;
        exportVC.notes = _exportNotes;
    }
    
    if ([segue.identifier isEqualToString:ShowQuestionViewControllerSegueId])
    {
        _searchBarView.hidden = YES;
        
        QuestionViewController* questionVC = (QuestionViewController*)segue.destinationViewController;
        questionVC.note = _selectedNote;
    }
}

#pragma mark SearchBarView
- (void) searchBarViewDidTapped:(SearchBarView *)searchBarView
{
    _searchBarView.editing = YES;
    [self performSegueWithIdentifier:ShowNotebookSearchViewControllerSegueId sender:self];
}


#pragma mark -- UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _notes.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NoteCell* cell = (NoteCell*)[collectionView dequeueReusableCellWithReuseIdentifier:NoteCellIdentifier forIndexPath:indexPath];
    [cell.exportButton addTarget:self action:@selector(onExportNote:event:) forControlEvents:UIControlEventTouchUpInside];
    [cell.deleteButton addTarget:self action:@selector(onDeleteNote:event:) forControlEvents:UIControlEventTouchUpInside];
    
    Note* note = [_notes objectAtIndex:indexPath.row];
    if (!note.updated)
    {
        CompletionBlock handler = ^(NetWorkTaskType taskType, BOOL success) {
            
            [cell configWithNote:note];
        };
        
        [GetNoteCommand executeWithNote:note completeHandler:handler];
    }
    else
    {
        [cell configWithNote:note];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"did select cell at index: %ld", indexPath.row);
    _selectedNote = [_notes objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:ShowQuestionViewControllerSegueId sender:self];
    
    return;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(collectionView.frame.size.width, 102);
}

- (void) collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    NoteCell* noteCell = (NoteCell*) cell;
    if (_selectMode)
    {
        [noteCell setStatusWithNoAnimation:NoteCellStatusSelect];
    }
    else
    {
        [noteCell setStatusWithNoAnimation:NoteCellStatusNone];
    }
}

@end



