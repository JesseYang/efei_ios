//
//  EFei.m
//  EFei
//
//  Created by Xiangzhen Kong on 11/18/14.
//
//

#import "EFei.h"
#import "DataBase.h"
#import "UIColor+Hex.h"

#define EFeiColorString @"#4979BD"

@interface EFei()
{
    DataBase* _database;
}

@end

@implementation EFei

+ (EFei*) instance
{
    static EFei* _instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _instance = [[EFei alloc] init];
    });
    
    return _instance;
}

- (id) init
{
    self = [super init];
    if (self)
    {
        _database           = [[DataBase alloc] init];
        self.account        = [[Account alloc] init];
        self.user           = [[User alloc] init];
        self.notebook       = [[NoteBook alloc] init];
        self.settings       = [[Settings alloc] init];
        self.subjectManager = [[SubjectManager alloc] init];
        self.searchManager  = [[SearchManager alloc] init];
        
        self.efeiColor = [UIColor colorWithHexString:EFeiColorString];
        
        [self load];
    }
    return self;
}

- (void) save
{
}

- (void) load
{
}

@end
