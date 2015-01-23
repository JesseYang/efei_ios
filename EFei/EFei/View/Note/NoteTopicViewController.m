//
//  KnowledgeViewController.m
//  EFei
//
//  Created by Xiangzhen Kong on 12/12/14.
//
//

#import "NoteTopicViewController.h"
#import "SearchView.h"
#import "TagCollectionView.h"
#import "Note.h"
#import "EFei.h"
#import "NotebookCommand.h"

@interface NoteTopicViewController()<SearchViewDelegate, SearchViewDataSource>
{
    
}

@property (weak, nonatomic) IBOutlet SearchView *searchView;
@property (weak, nonatomic) IBOutlet TagCollectionView *tagCollectionView;

- (void) setupNavigator;
- (void) setupViews;

- (void) onDone:(id)sender;

@end

@implementation NoteTopicViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNavigator];
    [self setupViews];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    Subject* subject = [[EFei instance].subjectManager subjectWithType:self.note.subjectType];
    
    if (subject.topics.count == 0)
    {
        CompletionBlock handler = ^(NetWorkTaskType taskType, BOOL success) {
            
            
            
        };
        
        [GetTopicsCommand executeWithSubjectType:self.note.subjectType completeHandler:handler];
    }
}

- (void) setupNavigator
{
    self.navigationItem.title = @"知识点编辑";
    
    UIBarButtonItem* doneBBI = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleBordered target:self action:@selector(onDone:)];
    
    self.navigationItem.rightBarButtonItem = doneBBI;
}

- (void) setupViews
{
    self.searchView.delegate = self;
    self.searchView.dataSource = self;
    
    for (NSString* t in self.note.topics)
    {
        [self.tagCollectionView addTitle:t];
    }
    
    [self.view bringSubviewToFront:self.searchView];
}

- (void) onDone:(id)sender
{
    self.note.topics = [NSArray arrayWithArray:self.tagCollectionView.titles];
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - SearchView

- (void) searchView:(SearchView *)searchView didAddContent:(NSString *)content
{
    if ([self.tagCollectionView.titles indexOfObject:content] == NSNotFound)
    {
        [self.tagCollectionView addTitle:content];
    }
}

- (NSArray*) searchView:(SearchView *)searchView searchResultWithText:(NSString *)text
{
    NSMutableArray* res = [[NSMutableArray alloc] init];
    Subject* subject = [[EFei instance].subjectManager subjectWithType:self.note.subjectType];
    for (Topic* topic in subject.topics)
    {
        NSString* lowerStr = [text lowercaseString];
        if ([topic.name hasPrefix:text] || [topic.quickName hasPrefix:lowerStr])
        {
            [res addObject:topic.name];
        }
    }
    
    return res;
}



@end
