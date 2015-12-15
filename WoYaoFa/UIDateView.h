//
//  UIDateView.h
//  HeMiaoForTeacher
//
//  Created by Lin on 15/4/23.
//  Copyright (c) 2015年 MaiMiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UIDateViewDelegate <NSObject>

@required
-(void)selected:(NSDate*)date;
-(void)deSelected;

@end

@interface UIDateView : UIView{
    UIDatePicker *_datePicker;
    CGFloat height;
    NSDate *pickerDate;
    NSTimeZone *_timeZone;
    id delegate;
}

@property(nonatomic) UIDatePicker *_datePicker;
@property(nonatomic) id<UIDateViewDelegate> delegate;

-(id)initWithTimeZone:(NSTimeZone*)timeZone locale:(NSLocale*)locale mode:(UIDatePickerMode)datePickerMode maxDate:(NSDate*)date;
-(void)show;
-(void)hide;

@end
