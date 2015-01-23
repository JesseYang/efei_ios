//
//  SearchManager.h
//  EFei
//
//  Created by Xiangzhen Kong on 1/21/15.
//
//

#import <Foundation/Foundation.h>

@interface SearchManager : NSObject

@property (nonatomic, strong) NSArray* searchHistroies;

- (void) addSearch:(NSString*)search;
- (void) clearHistory;

@end
