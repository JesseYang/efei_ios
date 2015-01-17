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

- (NSString*) selectedName
{
    if (self.selectedIndex>=0 && self.selectedIndex<self.items.count)
    {
        return [self.items objectAtIndex:self.selectedIndex];
    }
    
    return self.initialDisplayName;
}

@end

@interface TimeDataFilter()
{
    NSDateFormatter* _formatter;
    NSTimeInterval   _timeInterval;
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
        
        _formatter = [[NSDateFormatter alloc] init];
        [_formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZZZ"];
        
        self.initialDisplayName = @"最近";
    }
    
    return self;
}

- (void) setSelectedIndex:(NSInteger)selectedIndex
{
    [super setSelectedIndex:selectedIndex];
    
    switch (self.selectedIndex)
    {
        case 0:
            _timeInterval = 3600 * 24 * 7;
            break;
            
        case 1:
            _timeInterval = 3600 * 24 * 30;
            break;
            
        case 2:
            _timeInterval = 3600 * 24 * 90;
            break;
            
        case 3:
            _timeInterval = 3600 * 24 * 180;
            break;
            
            
        default:
            _timeInterval = 0;
            break;
    }
}

- (BOOL) filterData:(id)data
{
    if (self.selectedIndex < 0 || self.selectedIndex == 4)
    {
        return YES;
    }
    
    if (![data isKindOfClass:[Note class]])
    {
        return NO;
    }
    
    Note* note = (Note*)data;
    NSDate* date = [_formatter dateFromString:note.createTime];
    NSTimeInterval interval = [date timeIntervalSinceNow] * (-1);
    NSLog(@"Time interval: %@   ---  %f", note.createTime, interval);
    return interval <= _timeInterval;
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
        
        self.initialDisplayName = @"标签";
    }
    
    return self;
}

- (BOOL) filterData:(id)data
{
    if (self.selectedIndex < 0 || self.selectedIndex == 4)
    {
        return YES;
    }
    
    if (![data isKindOfClass:[Note class]])
    {
        return NO;
    }
    
    Note* note = (Note*)data;
    NSString* tag = [self.items objectAtIndex:self.selectedIndex];
    return [tag isEqualToString:note.tag];
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
                      @"英语",
                      @"全部科目",nil];
        self.name = @"科目筛选";
        
        self.initialDisplayName = @"全科";
        
        self.subjectType = SubjectTypeAll;
    }
    
    return self;
}

/*
 SubjectTypeChinese      = 1,
 SubjectTypeMathematics  = 2,
 SubjectTypeEnglish      = 4,
 SubjectTypePhysics      = 8,
 SubjectTypeChemistry    = 16,
 SubjectTypeBiology      = 32,
 SubjectTypeHistroy      = 64,
 SubjectTypeGeography    = 128,
 SubjectTypePolitics     = 256,
 SubjectTypeOther        = 512,
 SubjectTypeAll          = 1024,
 
 */

- (void) setSelectedIndex:(NSInteger)selectedIndex
{
    [super setSelectedIndex:selectedIndex];
    
    switch (self.selectedIndex)
    {
        case 0:
            self.subjectType = SubjectTypeMathematics;
            break;
            
        case 1:
            self.subjectType = SubjectTypePhysics;
            break;
            
        case 2:
            self.subjectType = SubjectTypeChemistry;
            break;
            
        case 3:
            self.subjectType = SubjectTypeBiology;
            break;
            
        case 4:
            self.subjectType = SubjectTypeChinese;
            break;
            
        case 5:
            self.subjectType = SubjectTypeEnglish;
            break;
            
        default:
            self.subjectType = SubjectTypeAll;
            break;
    }
}

- (BOOL) filterData:(id)data
{
    if (self.subjectType == SubjectTypeAll)
    {
        return YES;
    }
    
    if (![data isKindOfClass:[Note class]])
    {
        return NO;
    }
    
    Note* note = (Note*)data;
    return note.subjectType == self.subjectType;
}

@end


