//
//  Account.h
//  EFei
//
//  Created by Xiangzhen Kong on 11/18/14.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Account : NSObject

@property (nonatomic, copy) NSString* token;
@property (nonatomic, readonly) NSString* client;
@property (nonatomic, copy) NSString* username;
@property (nonatomic, copy) NSString* password;
@property (nonatomic, assign) BOOL autoSignIn;

@property (nonatomic, readonly) BOOL needSignIn;

@property (nonatomic, copy) NSString* appVersion;
@property (nonatomic, copy) NSString* lastestVersion;

- (void) save;
- (void) load;

- (void) signout;

@end
