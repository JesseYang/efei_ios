//
//  EFei.h
//  EFei
//
//  Created by Xiangzhen Kong on 11/18/14.
//
//

#import <Foundation/Foundation.h>

#import "Account.h"
#import "User.h"
#import "Question.h"
#import "Note.h"
#import "NoteBook.h"
#import "Settings.h"
#import "Infos.h"
#import "Teacher.h"
#import "Topics.h"
#import "SearchManager.h"

// Access point of data model

@interface EFei : NSObject

@property (nonatomic, strong) Account* account;
@property (nonatomic, strong) User* user;
@property (nonatomic, strong) NoteBook* notebook;
@property (nonatomic, strong) Settings* settings;
@property (nonatomic, strong) SubjectManager* subjectManager;
@property (nonatomic, strong) SearchManager* searchManager;
@property (nonatomic, copy) UIColor* efeiColor;

@property (nonatomic, assign) BOOL newNotesAdded;

+ (EFei*) instance;

- (void) signOut;

- (void) loadData;
- (void) saveData;


- (void) loadSubject:(Subject*)subject;
- (void) saveSubject:(Subject*)subject;

- (void) saveNotebookExportFile:(NSString*)path;

@end
