//
//  DataBase.h
//  EFei
//
//  Created by Xiangzhen Kong on 11/18/14.
//
//

#import <Foundation/Foundation.h>

@class Subject;

@interface DataBase : NSObject

- (void) createFolderForUser:(NSString*)user;
- (void) changeUser:(NSString*)user to:(NSString*)newUser;

- (void) loadSubject:(Subject*)subject;
- (void) saveSubject:(Subject*)subject;

- (void) saveNotebookExportFile:(NSString*)path;

@end
