//
//  UILabel+LLabel.m
//  WoYaoFa
//
//  Created by 林洁 on 15/12/7.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "UILabel+LLabel.h"

@implementation UILabel (LLabel)

- (void)textUpdateHight:(NSString *)text{
    self.text = text;
    self.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, [self contentSize].height);
}

- (void)textUpdateWidth:(NSString *)text{
    self.text = text;
    self.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, [self contentSize].width, self.bounds.size.height);
}

- (void)textUpdateSize:(NSString *)text{
    self.text = text;
    self.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, [self contentSize].width, [self contentSize].height);
}

- (CGSize)contentSize {
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = self.lineBreakMode;
    paragraphStyle.alignment = self.textAlignment;
    
    NSDictionary * attributes = @{NSFontAttributeName : self.font,
                                  NSParagraphStyleAttributeName : paragraphStyle};
    
    CGSize contentSize = [self.text boundingRectWithSize:CGSizeMake(SCREEN.width, MAXFLOAT)
                                                 options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                              attributes:attributes
                                                 context:nil].size;
    return contentSize;
}

@end
