//
//  UILabel+LLabel.m
//  WoYaoFa
//
//  Created by 林洁 on 15/12/7.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "UILabel+LLabel.h"

@implementation UILabel (LLabel)

- (void)setTextUpdateHight:(NSString *)textUpdateHight{
    self.text = textUpdateHight;
    self.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, [self contentSize].height);
}

- (void)setTextUpdateWidth:(NSString *)textUpdateWidth{
    self.text = textUpdateWidth;
    self.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, [self contentSize].width, self.bounds.size.height);
}

- (void)setTextUpdateSize:(NSString *)textUpdateSize{
    self.text = textUpdateSize;
    self.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, [self contentSize].width, [self contentSize].height);
}

- (NSString*)textUpdateHight{
    return self.text;
}

- (NSString*)textUpdateWidth{
    return self.text;
}

- (NSString*)textUpdateSize{
    return self.text;
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
