//
//  Topics.h
//  EFei
//
//  Created by Xiangzhen Kong on 11/22/14.
//
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger
{
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
} SubjectType;

@interface Topic : NSObject

@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* quickName;

@end

@interface Subject : NSObject

@property (nonatomic, copy) NSString* name;
@property (nonatomic, readonly) NSArray* topics;

- (void) clearAllTopics;
- (void) addTopic:(Topic*)topic;

@end


@interface SubjectManager : NSObject

@property (nonatomic, readonly) NSArray* subjects;

- (Subject*) subjectWithType:(SubjectType)type;
- (NSString*) subjectNameWithType:(SubjectType)type;

@end

