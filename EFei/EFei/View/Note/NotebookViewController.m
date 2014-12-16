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

#define NoteCellIdentifier @"NoteCellIdentifier"



@interface NotebookViewController()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITextViewDelegate>
{
    NSArray* _notes;
    
    UITextField *textField;
    
    BOOL _select;
}

@property (weak, nonatomic) IBOutlet UICollectionView *noteCollectionView;


- (IBAction)onYiFei:(id)sender;
- (IBAction)onSelect:(id)sender;

@end

@implementation NotebookViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    float width = 200;
    float height = 34;
    float x = (self.navigationController.navigationBar.frame.size.width - width) / 2;
    float y = 2;
    textField = [[UITextField alloc] initWithFrame: CGRectMake(x, y, width, height)];
    textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.font = [UIFont systemFontOfSize:15];
    
    
    [self.navigationController.navigationBar addSubview:textField];

    if (![EFei instance].account.needSignIn)
    {
        [self getNotes];
    }
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



