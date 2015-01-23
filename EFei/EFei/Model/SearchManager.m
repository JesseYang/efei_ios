//
//  SearchManager.m
//  EFei
//
//  Created by Xiangzhen Kong on 1/21/15.
//
//

#import "SearchManager.h"

@interface SearchManager()
{
    NSMutableArray* _searchHistroies;
}

@end

@implementation SearchManager

- (id) init
{
    self = [super init];
    if (self)
    {
        _searchHistroies = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void) addSearch:(NSString *)search
{
    [_searchHistroies addObject:search];
}

- (void) clearHistory
{
    [_searchHistroies removeAllObjects];
}

@end
