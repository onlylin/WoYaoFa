//
//  LAddressPicker.m
//  WoYaoFa
//
//  Created by 林洁 on 15/12/15.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "LAddressPicker.h"

#define ProvinceComponent 0
#define CityComponent 1
#define AreaComponent 2

@implementation LAddressPicker
@synthesize mPickerView;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadAddress];
        mPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, frame.size.width, frame.size.height - 44)];
        mPickerView.dataSource = self;
        mPickerView.delegate = self;
        mPickerView.showsSelectionIndicator = YES;
        [self addSubview:mPickerView];
        
        UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 44)];
        toolBar.barTintColor = [UIColor whiteColor];
        [self addSubview:toolBar];
        
        UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(onCancel)];
        UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem *okBtn = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(onOk)];
        NSArray *buttons = @[cancelBtn,spaceItem,okBtn];
        [toolBar setItems:buttons];
    }
    return self;
}

- (void)loadAddress{
    NSString* plistPath=[[NSBundle mainBundle] pathForResource:@"address" ofType:@"plist"];
    self.dictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    self.provinces = [self.dictionary allKeys];
    self.selects = [self.dictionary objectForKey:[self.provinces objectAtIndex:0]];
    if ([self.selects count] > 0) {
        self.citys = [[self.selects objectAtIndex:0] allKeys];
    }
    if ([self.citys count] > 0) {
        self.districts = [[self.selects objectAtIndex:0] objectForKey:[self.citys objectAtIndex:0]];
    }
}

-(void)onCancel{
    if ([delegate respondsToSelector:@selector(deSelected)]) {
        [delegate deSelected];
    }
}

-(void)onOk{
    NSUInteger selectedRow1 = [mPickerView selectedRowInComponent:0];
    NSUInteger selectedRow2 = [mPickerView selectedRowInComponent:1];
    NSUInteger selectedRow3 = [mPickerView selectedRowInComponent:2];
    if ([delegate respondsToSelector:@selector(selectedProvince:city:district:)]) {
        [delegate selectedProvince:[self.provinces objectAtIndex:selectedRow1] city:[self.citys objectAtIndex:selectedRow2] district:[self.districts objectAtIndex:selectedRow3]];
    }
}

#pragma mark
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == ProvinceComponent) {
        return [self.provinces count];
    }
    if (component == CityComponent) {
        return [self.citys count];
    }
    if (component == AreaComponent) {
        return [self.districts count];
    }
    return 0;
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == ProvinceComponent) {
        return [self.provinces objectAtIndex:row];
    }
    if (component == CityComponent) {
        return [self.citys objectAtIndex:row];
    }
    if (component == AreaComponent) {
        return [self.districts objectAtIndex:row];
    }
    return nil;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == ProvinceComponent) {
        self.selects = [self.dictionary objectForKey:[self.provinces objectAtIndex:row]];
        if ([self.selects count] > 0) {
            self.citys = [[self.selects objectAtIndex:0] allKeys];
        }else{
            self.citys = nil;
        }
        if ([self.citys count] > 0) {
            self.districts = [[self.selects objectAtIndex:0] objectForKey:[self.citys objectAtIndex:0]];
        }else{
            self.districts = nil;
        }
        [pickerView selectedRowInComponent:1];
        [pickerView reloadComponent:1];
        [pickerView selectedRowInComponent:2];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [pickerView selectRow:0 inComponent:2 animated:YES];
    }
    
    if (component == CityComponent) {
        if ([self.selects count] > 0 && [self.citys count] > 0) {
            self.districts = [[self.selects objectAtIndex:0] objectForKey:[self.citys objectAtIndex:row]];
        }else{
            self.districts = nil;
        }
        [pickerView selectRow:0 inComponent:2 animated:YES];
    }
    [pickerView reloadComponent:2];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    if (component == ProvinceComponent) {
        return 90.0;
    }
    if (component == CityComponent) {
        return 120.0;
    }
    if (component == AreaComponent) {
        return 100.0;
    }
    return 0;
}

@end
