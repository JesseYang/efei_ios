//
//  Infos.h
//  EFei
//
//  Created by Xiangzhen Kong on 11/19/14.
//
//

#import <Foundation/Foundation.h>

@interface Infos : NSObject

@end

@interface SigninInfo : NSObject

@property (nonatomic, copy) NSString* username;
@property (nonatomic, copy) NSString* password;

@end


@interface SignUpInfo : NSObject

@property (nonatomic, copy) NSString* username;
@property (nonatomic, copy) NSString* nickName;
@property (nonatomic, copy) NSString* password;

@end
