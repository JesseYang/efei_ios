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

+ (void) load
{
    EFei* efei = [EFei instance];
    [efei loadData];
}

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
    }
    return self;
}

- (void) signOut
{
    [self.account signout];
    [self.notebook clearNotes];
}

- (void) saveData
{
}

- (void) loadData
{
    [self.subjectManager loadData];
}

- (void) loadSubject:(Subject*)subject
{
    [_database loadSubject:subject];
}

- (void) saveSubject:(Subject*)subject
{
    [_database saveSubject:subject];
}

- (void) saveNotebookExportFile:(NSString*)path
{
    [_database saveNotebookExportFile:path];
}

@end
