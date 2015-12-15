//
//  LAddressPicker.h
//  WoYaoFa
//
//  Created by 林洁 on 15/12/15.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LAddressPickerDelegate <NSObject>

@required
-(void)deSelected;
-(void)selectedProvince:(NSString*)province city:(NSString*)city district:(NSString*)district;

@end

@interface LAddressPicker : UIView<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) NSDictionary *dictionary;

@property (nonatomic, strong) NSArray *provinces;

@property (nonatomic, strong) NSArray *citys;

@property (nonatomic, strong) NSArray *districts;

@property (nonatomic, strong) NSArray *selects;

@property(nonatomic, strong) UIPickerView *mPickerView;

@property(nonatomic) id<LAddressPickerDelegate> delegate;


- (id)initWithFrame:(CGRect)frame;

@end
