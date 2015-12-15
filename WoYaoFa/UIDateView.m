//
//  UIDateView.m
//  HeMiaoForTeacher
//
//  Created by Lin on 15/4/23.
//  Copyright (c) 2015年 MaiMiao. All rights reserved.
//

#import "UIDateView.h"

#define Screen  [UIScreen mainScreen].bounds.size

@implementation UIDateView
@synthesize _datePicker;
@synthesize delegate;


-(id)initWithTimeZone:(NSTimeZone *)timeZone locale:(NSLocale *)locale mode:(UIDatePickerMode)datePickerMode maxDate:(NSDate *)date{
    height = 240;
    self = [super initWithFrame:CGRectMake(0, Screen.height, Screen.width, height)];
    if (self) {
        _timeZone = timeZone;
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 44, Screen.width, height - 44)];
        [_datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
        _datePicker.datePickerMode = datePickerMode;
        if (date != nil) {
            _datePicker.maximumDate = date;
        }
        _datePicker.locale = locale;
        _datePicker.timeZone = timeZone;
        
        [self addSubview:_datePicker];
        
        UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, Screen.width, 44)];
        toolBar.barTintColor = [UIColor whiteColor];
        [self addSubview:toolBar];
        
        UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(onCancel)];
        UIBarButtonItem *spaceItem1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem *dateBtn = [[UIBarButtonItem alloc] initWithTitle:@"选择日期" style:UIBarButtonItemStylePlain target:nil action:nil];
        dateBtn.tintColor = [UIColor grayColor];
        dateBtn.enabled = NO;
        UIBarButtonItem *spaceItem2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem *okBtn = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(onOk)];
        NSArray *buttons = @[cancelBtn,spaceItem1,dateBtn,spaceItem2,okBtn];
        [toolBar setItems:buttons];
    }
    return self;
}

-(void)show{
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = CGRectMake(0, Screen.height - height, Screen.width, height);
        self.hidden = NO;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)hide{
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = CGRectMake(0, Screen.height, Screen.width, height);
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

-(void)onCancel{
    if ([delegate respondsToSelector:@selector(deSelected)]) {
        [delegate deSelected];
    }
}

-(void)onOk{
    if (!pickerDate) {
        NSDate *date = [NSDate date];
        pickerDate = [date dateByAddingTimeInterval:[_timeZone secondsFromGMTForDate:date]];
    }
    if ([delegate respondsToSelector:@selector(selected:)]) {
        [delegate selected:pickerDate];
    }
}


-(void)dateChanged:(id)sender{
    NSDate *date = _datePicker.date;
    NSInteger interval = [_timeZone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    pickerDate = localeDate;
}

@end
