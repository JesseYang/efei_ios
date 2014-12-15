//
//  UIImage+Resize.m
//  EFei
//
//  Created by Xiangzhen Kong on 12/14/14.
//
//

#import "UIImage+Resize.h"

@implementation UIImage (Resize)

+ (UIImage*) imageWithImage:(UIImage*)image sacleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

@end
