//
//  NSString+Email.m
//  EFei
//
//  Created by Xiangzhen Kong on 1/27/15.
//
//

#import "NSString+Email.h"

@implementation NSString (Email)

- (BOOL) isValidEmail
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (BOOL) isValidPhoneNumber
{
    NSCharacterSet* notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    if (self.length == 11 && [self rangeOfCharacterFromSet:notDigits].location == NSNotFound)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

@end
