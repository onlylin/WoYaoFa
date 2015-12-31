//
//  UIImage+LImage.m
//  WoYaoFa
//
//  Created by 林洁 on 15/12/22.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "UIImage+LImage.h"

@implementation UIImage (LImage)

/**
 *  图片压缩
 *
 *  @param size
 *
 *  @return 
 */
- (UIImage*)scaledToSize:(CGSize)size{
    // Create a graphics image context
    UIGraphicsBeginImageContext(size);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [self drawInRect:CGRectMake(0,0,size.width,size.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

/**
 *  保存图片至沙盒
 *
 *  @param imageName 图片名称
 */
- (void)saveWithNewName:(NSString *)imageName{
    NSData *imageData = UIImageJPEGRepresentation(self, 0.5);
    // 获取沙盒目录
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    
    [imageData writeToFile:fullPath atomically:NO];
}

@end
