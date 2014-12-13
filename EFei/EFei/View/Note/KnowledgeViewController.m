//
//  KnowledgeViewController.m
//  EFei
//
//  Created by Xiangzhen Kong on 12/12/14.
//
//

#import "KnowledgeViewController.h"
#import "SearchView.h"
#import "TagCollectionView.h"
#import "Note.h"

@interface KnowledgeViewController()<SearchViewDelegate>
{
    
}

@property (weak, nonatomic) IBOutlet SearchView *searchView;
@property (weak, nonatomic) IBOutlet TagCollectionView *tagCollectionView;

- (void) setupNavigator;
- (void) setupViews;

- (void) onDone:(id)sender;

@end

@implementation KnowledgeViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNavigator];
    [self setupViews];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
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
}

- (void) onDone:(id)sender
{
    self.note.topics = [NSArray arrayWithArray:self.tagCollectionView.titles];
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - SearchView

- (void) searchView:(SearchView *)searchView didAddContent:(NSString *)content
{
    [self.tagCollectionView addTitle:content];
}



@end
