//
//  Topics.m
//  EFei
//
//  Created by Xiangzhen Kong on 11/22/14.
//
//

#import "Topics.h"
#import <math.h>
#import "EFei.h"

@implementation Topic

@end



@interface Subject()
{
    NSMutableArray* _topics;
}

@end

@implementation Subject

- (id) initWithName:(NSString *)name
{
    self = [super init];
    if (self)
    {
        self.name = name;
        _topics = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) clearAllTopics
{
    [_topics removeAllObjects];
}

- (void) addTopic:(Topic *)topic
{
    [_topics addObject:topic];
}

- (void) loadData
{
    [[EFei instance] loadSubject:self];
}

- (void) saveData
{
    [[EFei instance] saveSubject:self];
}

@end







@interface SubjectManager()
{
    NSMutableDictionary* _subjectDict;
    NSArray*      _subjectNames;
}

@end

@implementation SubjectManager

- (id) init
{
    self = [super init];
    if (self)
    {
//        _subjectDict = [NSDictionary dictionaryWithObjectsAndKeys:
//                        [[Subject alloc] init], [NSNumber numberWithInteger:SubjectTypeBiology],
//                        [[Subject alloc] init], [NSNumber numberWithInteger:SubjectTypeChemistry],
//                        [[Subject alloc] init], [NSNumber numberWithInteger:SubjectTypeChinese],
//                        [[Subject alloc] init], [NSNumber numberWithInteger:SubjectTypeEnglish],
//                        [[Subject alloc] init], [NSNumber numberWithInteger:SubjectTypeGeography],
//                        [[Subject alloc] init], [NSNumber numberWithInteger:SubjectTypeHistroy],
//                        [[Subject alloc] init], [NSNumber numberWithInteger:SubjectTypeMathematics],
//                        [[Subject alloc] init], [NSNumber numberWithInteger:SubjectTypePhysics],
//                        [[Subject alloc] init], [NSNumber numberWithInteger:SubjectTypePolitics],
//                        [[Subject alloc] init], [NSNumber numberWithInteger:SubjectTypeOther],
//                        nil];
//        
//        _subjectNames = [NSArray arrayWithObjects:@"语文", @"数学", @"英语", @"物理",
//                         @"化学", @"生物", @"历史", @"地理", @"政治", @"其他", @"全科", nil];
//        
//        
//        
        _subjectDict = [[NSMutableDictionary alloc] init];
        _subjectDict[@(SubjectTypeChinese)]     = [[Subject alloc] initWithName:@"语文"];
        _subjectDict[@(SubjectTypeMathematics)] = [[Subject alloc] initWithName:@"数学"];
        _subjectDict[@(SubjectTypeEnglish)]     = [[Subject alloc] initWithName:@"英语"];
        _subjectDict[@(SubjectTypePhysics)]     = [[Subject alloc] initWithName:@"物理"];
        _subjectDict[@(SubjectTypeChemistry)]   = [[Subject alloc] initWithName:@"化学"];
        _subjectDict[@(SubjectTypeBiology)]     = [[Subject alloc] initWithName:@"生物"];
        _subjectDict[@(SubjectTypeHistroy)]     = [[Subject alloc] initWithName:@"历史"];
        _subjectDict[@(SubjectTypeGeography)]   = [[Subject alloc] initWithName:@"地理"];
        _subjectDict[@(SubjectTypePolitics)]    = [[Subject alloc] initWithName:@"政治"];
        _subjectDict[@(SubjectTypeOther)]       = [[Subject alloc] initWithName:@"其他"];
        _subjectDict[@(SubjectTypeAll)]         = [[Subject alloc] initWithName:@"全科"];
    }
    return self;
}


- (void) loadData
{
    for (Subject* subject in _subjectDict.allValues)
    {
        [subject loadData];
    }
}

- (void) saveData
{
    for (Subject* subject in _subjectDict.allValues)
    {
        [subject saveData];
    }
}

- (NSArray*) subjects
{
    return _subjectDict.allValues;
}

- (Subject*) subjectWithType:(SubjectType)type
{
    return _subjectDict[@(type)];
//    return [_subjectDict objectForKey:[NSNumber numberWithInteger:type]];
}

- (NSString*) subjectNameWithType:(SubjectType)type
{
    Subject* subject = _subjectDict[@(type)];
    return subject.name;
    
//    NSInteger index = log2(type);
//    return [_subjectNames objectAtIndex:index];
}

@end