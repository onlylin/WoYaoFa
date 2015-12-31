//
//  UIImage+LImage.h
//  WoYaoFa
//
//  Created by 林洁 on 15/12/22.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LImage)

- (UIImage*)scaledToSize:(CGSize)size;

- (void)saveWithNewName:(NSString*)imageName;

@end
