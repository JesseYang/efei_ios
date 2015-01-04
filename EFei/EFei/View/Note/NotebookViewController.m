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

#define NoteCellIdentifier @"NoteCellIdentifier"

#define ShowNotebookFilterViewControllerSegueId @"ShowNotebookFilterViewController"

@interface NotebookViewController()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITextViewDelegate, UITextFieldDelegate>
{
    NSArray* _notes;
    
    BOOL _select;
    
    DataFilterType _filterType;
    
    SearchBarView* _searchBarView;
}

@property (weak, nonatomic) IBOutlet UICollectionView *noteCollectionView;


- (IBAction)onYiFei:(id)sender;
- (IBAction)onSelect:(id)sender;

- (IBAction)onSubjectFilter:(id)sender;
- (IBAction)onTimeFilter:(id)sender;
- (IBAction)onTageFilter:(id)sender;


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
    float width = self.view.frame.size.width - 80;
    float height = 30;
    float x = (self.navigationController.navigationBar.frame.size.width - width) / 2;
    float y = 5;
    CGRect rect = CGRectMake(x, y, width, height);
    _searchBarView = [[SearchBarView alloc] initWithFrame:rect];
    
    [self.navigationController.navigationBar addSubview:_searchBarView];
}

- (void) resetData
{
    _notes = [EFei instance].notebook.notes;
    [self.noteCollectionView reloadData];
}

- (void) getNotes
{
    if ([EFei instance].notebook.notes.count > 0)
    {
        return;
    }
    
    CompletionBlock hanlder = ^(NetWorkTaskType taskType, BOOL success) {
        
        [self resetData];
        
    };
    
    [GetNoteListCommand executeWithCompleteHandler:hanlder];
}

- (void) textFieldDidBeginEditing:(UITextField *)textField
{
//    _searchIcon.hidden = YES;
}

- (void) textFieldDidEndEditing:(UITextField *)textField
{
    textField.text = @"";
//    _searchIcon.hidden = NO;
}

- (IBAction)onYiFei:(id)sender
{
    
}

- (IBAction)onSelect:(id)sender
{
    _select = !_select;
    
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
            if (_select)
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
    return;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(collectionView.frame.size.width, 102);
}

- (void) collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    NoteCell* noteCell = (NoteCell*) cell;
    if (_select)
    {
        [noteCell setStatusWithNoAnimation:NoteCellStatusSelect];
    }
    else
    {
        [noteCell setStatusWithNoAnimation:NoteCellStatusNone];
    }
}

@end



