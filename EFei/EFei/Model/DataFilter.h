//
//  DataFilter.h
//  EFei
//
//  Created by Xiangzhen Kong on 1/4/15.
//
//

#import <Foundation/Foundation.h>
#import "Topics.h"

typedef enum : NSUInteger {
    DataFilterTypeTime,
    DataFilterTypeTag,
    DataFilterTypeSubject,
} DataFilterType;

@interface DataFilter : NSObject

@property (nonatomic, copy) NSString* name;
@property (nonatomic, strong) NSArray* items;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, copy) NSString* selectedName;
@property (nonatomic, copy) NSString* initialDisplayName;

- (BOOL) filterData:(id)data;

@end


@interface TimeDataFilter : DataFilter

@end


@interface TagDataFilter : DataFilter

@end


@interface SubjectDataFilter : DataFilter

@property (nonatomic, assign) SubjectType subjectType;

@end