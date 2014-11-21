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
#import "NoteBook.h"
#import "Settings.h"
#import "Infos.h"
#import "Teacher.h"

// Access point of data model

@interface EFei : NSObject

@property (nonatomic, strong) Account* account;
@property (nonatomic, strong) User* user;
@property (nonatomic, strong) NoteBook* notebook;
@property (nonatomic, strong) Settings* settings;

+ (EFei*) instance;

- (void) load;
- (void) save;

@end
