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

@interface KnowledgeViewController()<SearchViewDelegate>
{
    
}

@property (weak, nonatomic) IBOutlet SearchView *searchView;
@property (weak, nonatomic) IBOutlet TagCollectionView *tagCollectionView;


@end

@implementation KnowledgeViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    self.searchView.delegate = self;
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    CGRect rect = self.searchView.frame;
    NSLog(@"%f, %f, %f, %f", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
    
    rect = self.searchView.searchBar.frame;
    NSLog(@"%f, %f, %f, %f", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
    
}

- (void) searchView:(SearchView *)searchView didAddContent:(NSString *)content
{
    [self.tagCollectionView addTitle:content];
}

@end
