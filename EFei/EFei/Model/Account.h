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

@property (nonatomic, copy) NSString* authKey;
@property (nonatomic, readonly) NSString* client;

@end
