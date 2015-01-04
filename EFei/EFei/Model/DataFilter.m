//
//  DataFilter.m
//  EFei
//
//  Created by Xiangzhen Kong on 1/4/15.
//
//

#import "DataFilter.h"
#import "EFei.h"

@implementation DataFilter

- (id) init
{
    self = [super init];
    if (self)
    {
        self.selectedIndex = -1;
    }
    
    return self;
}

- (BOOL) filterData:(id)data
{
    // Default: all data can pass this filter.
    return YES;
}

@end


@implementation TimeDataFilter

- (id) init
{
    self = [super init];
    if (self)
    {
        self.items = [NSArray arrayWithObjects:@"最近一周",
                      @"最近一个月",
                      @"最近三个月",
                      @"最近半年",
                      @"全部时间",nil];
        
        self.name = @"时间筛选";
    }
    
    return self;
}

- (BOOL) filterData:(id)data
{
    return YES;
}

@end

@implementation TagDataFilter

- (id) init
{
    self = [super init];
    if (self)
    {
        self.items = [NSArray arrayWithObjects:@"不懂",
                      @"不会",
                      @"不对",
                      @"典型题",
                      @"全部标签",nil];
        self.name = @"标签筛选";
    }
    
    return self;
}

- (BOOL) filterData:(id)data
{
    return YES;
}

@end

@implementation SubjectDataFilter

- (id) init
{
    self = [super init];
    if (self)
    {
        self.items = [NSArray arrayWithObjects:@"数学",
                      @"物理",
                      @"化学",
                      @"生物",
                      @"语言",
                      @"英语",nil];
        self.name = @"科目筛选";
    }
    
    return self;
}

- (BOOL) filterData:(id)data
{
    return YES;
}

@end


