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

- (NSArray*) searchHistroies
{
    return _searchHistroies;
}

- (void) addSearch:(NSString *)search
{
    [_searchHistroies removeObject:search];
    [_searchHistroies insertObject:search atIndex:0];
}

- (void) clearHistory
{
    [_searchHistroies removeAllObjects];
}

@end
