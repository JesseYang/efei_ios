//
//  Topics.m
//  EFei
//
//  Created by Xiangzhen Kong on 11/22/14.
//
//

#import "Topics.h"

@implementation Topic

@end



@interface Subject()
{
    NSMutableArray* _topics;
}

@end

@implementation Subject

- (id) init
{
    self = [super init];
    if (self)
    {
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

@end







@interface SubjectManager()
{
    NSDictionary* _subjectDict;
}

@end

@implementation SubjectManager

- (id) init
{
    self = [super init];
    if (self)
    {
        _subjectDict = [NSDictionary dictionaryWithObjectsAndKeys:
                        [Subject new], [NSNumber numberWithInteger:SubjectTypeBiology],
                        [Subject new], [NSNumber numberWithInteger:SubjectTypeChemistry],
                        [Subject new], [NSNumber numberWithInteger:SubjectTypeChinese],
                        [Subject new], [NSNumber numberWithInteger:SubjectTypeEnglish],
                        [Subject new], [NSNumber numberWithInteger:SubjectTypeGeography],
                        [Subject new], [NSNumber numberWithInteger:SubjectTypeHistroy],
                        [Subject new], [NSNumber numberWithInteger:SubjectTypeMathematics],
                        [Subject new], [NSNumber numberWithInteger:SubjectTypePhysics],
                        [Subject new], [NSNumber numberWithInteger:SubjectTypePolitics],
                        [Subject new], [NSNumber numberWithInteger:SubjectTypeOther],
                        nil];
        
        
    }
    return self;
}

- (NSArray*) subjects
{
    return _subjectDict.allValues;
}

- (Subject*) subjectWithType:(SubjectType)type
{
    return [_subjectDict objectForKey:[NSNumber numberWithInteger:type]];
}

@end