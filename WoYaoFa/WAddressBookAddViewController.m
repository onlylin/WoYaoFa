//
//  WAddressBookAddViewController.m
//  WoYaoFa
//
//  Created by 林洁 on 15/12/28.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "WAddressBookAddViewController.h"
#import "UITextView+placeholder.h"

#define FONT_S [UIFont systemFontOfSize:15.0f]

@interface WAddressBookAddViewController (){
    WAddressBook *address;
}

@end

@implementation WAddressBookAddViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.saveButton];
    [self addRACSignal];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_offset(0);
    }];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = VIEW_BG;
    
    [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(0);
        make.left.right.mas_offset(0);
        make.height.mas_equalTo(40);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.addressBook == nil) {
        return 5;
    }
    return 6;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Identifier = @"Cell";
    UITableViewCell *cell = nil;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    switch (indexPath.row) {
        case 0:
        {
            [cell addSubview:self.nameField];
            [self.nameField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_offset(15);
                make.top.bottom.right.mas_offset(0);
            }];
            break;
        }
        case 1:
        {
            [cell addSubview:self.phoneField];
            [self.phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_offset(15);
                make.top.bottom.right.mas_offset(0);
            }];
            break;
        }
        case 2:
        {
            [cell addSubview:self.addressField];
            [self.addressField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_offset(15);
                make.top.bottom.right.mas_offset(0);
            }];
            break;
        }
        case 3:
        {
            [cell addSubview:self.streetField];
            [self.streetField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_offset(15);
                make.top.bottom.right.mas_offset(0);
            }];
            break;
        }
        case 4:
        {
            [cell addSubview:self.detailField];
            [self.detailField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_offset(15);
                make.top.bottom.right.mas_offset(0);
            }];
            break;
        }
            
        default:
        {
            UILabel *label = [UILabel new];
            label.font = FONT_S;
            label.textColor = [UIColor redColor];
            if (self.addressBookType == AddressBookTypeShipper) {
                label.text = @"删除发货地址";
            }else{
                label.text = @"删除收货地址";
            }
            [cell addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_offset(15);
                make.top.bottom.right.mas_offset(0);
            }];
            break;
        }
    }
    return cell;
}

#pragma mark - LAddressPicker Delegate
- (void)selectedProvince:(NSString *)province city:(NSString *)city district:(NSString *)district{
    self.addressField.text = [NSString stringWithFormat:@"%@ %@ %@",province,city,district];
    if (self.addressBook == nil) {
        address.province = province;
        address.city = city;
        address.district = district;
    }else{
        self.addressBook.province = province;
        self.addressBook.city = city;
        self.addressBook.district = district;
    }
    [self deSelected];
}

- (void)deSelected{
    [self.addressField resignFirstResponder];
}

#pragma mark - Event Resonse
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.nameField resignFirstResponder];
    [self.phoneField resignFirstResponder];
    [self.addressField resignFirstResponder];
    [self.streetField resignFirstResponder];
    [self.detailField resignFirstResponder];
}

- (void)rightBarAction:(UIBarButtonItem*)sender{
    if (sender.tag == 1) {
        RACSignal *signal = [[LinApiManager shareInstance] modifyAddressBook:self.addressBook];
        [[signal filter:^BOOL(LDataResult *dataResult) {
            [MBProgressHUD showTextOnly:dataResult.msg];
            return dataResult.code == ResponseStatusOk;
        }] subscribeNext:^(id x) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }else{
        self.nameField.userInteractionEnabled = YES;
        self.phoneField.userInteractionEnabled = YES;
        self.addressField.userInteractionEnabled = YES;
        self.streetField.userInteractionEnabled = YES;
        self.detailField.userInteractionEnabled = YES;
        [sender setTitle:@"保存"];
        sender.tag = 1;
    }
}

#pragma mark - Private Method
- (void)addRACSignal{
    [RACObserve(self, addressBookType) subscribeNext:^(NSNumber *type) {
        if (self.addressBook == nil) {
            if ([type integerValue] == AddressBookTypeReceiver) {
                self.navigationItem.title = @"添加收货人地址";
            }else if ([type integerValue] == AddressBookTypeShipper){
                self.navigationItem.title = @"添加发货人地址";
            }
        }else{
            if ([type integerValue] == AddressBookTypeReceiver) {
                self.navigationItem.title = @"编辑收货人地址";
            }else if ([type integerValue] == AddressBookTypeShipper){
                self.navigationItem.title = @"编辑发货人地址";
            }
        }
        
    }];
    
    [[RACObserve(self, addressBook) filter:^BOOL(WAddressBook *object) {
        if (object == nil) {
            address = [[WAddressBook alloc] init];
        }
        return object != nil;
    }] subscribeNext:^(WAddressBook *object) {
        self.nameField.text = object.name;
        self.nameField.userInteractionEnabled = NO;
        self.phoneField.text = object.phone;
        self.phoneField.userInteractionEnabled = NO;
        self.addressField.text = [NSString stringWithFormat:@"%@ %@ %@",object.province,object.city,object.district];
        self.addressField.userInteractionEnabled = NO;
        self.streetField.text = object.street;
        self.streetField.userInteractionEnabled = NO;
        self.detailField.text = object.detail;
        self.detailField.userInteractionEnabled = NO;
        
        self.navigationItem.rightBarButtonItem = self.rightItem;
        if (self.addressBookType == AddressBookTypeShipper) {
            [self.view addSubview:self.setDefaultButton];
            [self.setDefaultButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_offset(0);
                make.bottom.mas_offset(0);
                make.height.mas_equalTo(40);
            }];
        }
    }];
    
    [[RACObserve(self.nameField,text) filter:^BOOL(NSString *value) {
        return value.length > 0;
    }] subscribeNext:^(NSString *value) {
        if (self.addressBook == nil) {
            address.name = value;
        }else{
            self.addressBook.name = value;
        }
    }];
    
    [[RACObserve(self.phoneField,text) filter:^BOOL(NSString *value) {
        return value.length > 0;
    }] subscribeNext:^(NSString *value) {
        if (self.addressBook == nil) {
            address.phone = value;
        }else{
            self.addressBook.phone = value;
        }
    }];
    
    [[RACObserve(self.streetField,text) filter:^BOOL(NSString *value) {
        return value.length > 0;
    }] subscribeNext:^(NSString *value) {
        if (self.addressBook == nil) {
            address.street = value;
        }else{
            self.addressBook.street = value;
        }
    }];
    
    [[RACObserve(self.detailField,text) filter:^BOOL(NSString *value) {
        return value.length > 0;
    }] subscribeNext:^(NSString *value) {
        if (self.addressBook == nil) {
            address.detail = value;
        }else{
            self.addressBook.detail = value;
        }
    }];
    
    self.saveButton.rac_command = [[RACCommand alloc] initWithEnabled:
                                   [RACSignal combineLatest:@[
                                                              self.nameField.rac_textSignal,
                                                              self.phoneField.rac_textSignal,
                                                              self.addressField.rac_textSignal,
                                                              self.streetField.rac_textSignal,
                                                              self.detailField.rac_textSignal
                                                     ]
                                                     reduce:^id(NSString *name,NSString *phone,NSString *addr,NSString *street,NSString *detail){
                                                         NSNumber *enabled = @(name.length > 0 && phone.length > 0 && addr.length > 0 && street.length > 0 && detail.length > 0);
                                                         self.saveButton.alpha = [enabled integerValue] + 0.5;
                                                         return enabled;
                                                     }]
                                                          signalBlock:^RACSignal *(id input) {
                                                              address.type = self.addressBookType;
                                                              address.accountId = 33;
                                                              return [[LinApiManager shareInstance] addAddressBook:address];
                                                    }];
    
    [self.saveButton.rac_command.executionSignals subscribeNext:^(RACSignal *signal) {
        [[signal filter:^BOOL(LDataResult *dataResult) {
            [MBProgressHUD showTextOnly:dataResult.msg];
            return dataResult.code == ResponseStatusOk;
        }] subscribeNext:^(id x) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }];
    
    
    RAC(self.rightItem,enabled) = [RACSignal
                combineLatest:@[
                    self.nameField.rac_textSignal,
                    self.phoneField.rac_textSignal,
                    self.addressField.rac_textSignal,
                    self.streetField.rac_textSignal,
                    self.detailField.rac_textSignal
                ] reduce:^id(NSString *name,NSString *phone,NSString *addr,NSString *street,NSString *detail){
                    NSNumber *enabled = @(name.length > 0 && phone.length > 0 && addr.length > 0 && street.length > 0 && detail.length > 0);
                    return enabled;
                }];
    
    self.setDefaultButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [[LinApiManager shareInstance] setDefaultAddressBook:self.addressBook.ID user:1];
    }];
    
    [self.setDefaultButton.rac_command.executionSignals subscribeNext:^(RACSignal *signal) {
        [[signal filter:^BOOL(LDataResult *dataResult) {
            [MBProgressHUD showTextOnly:dataResult.msg];
            return dataResult.code == ResponseStatusOk;
        }] subscribeNext:^(id x) {
            NSLog(@"gggg");
        }];
    }];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - Getter and Setter
- (UITableView*)tableView{
    if (_tableView == nil) {
        _tableView = [UITableView new];
    }
    return _tableView;
}

- (UITextField*)nameField{
    if (_nameField == nil) {
        _nameField = [UITextField new];
        _nameField.placeholder = @"发货人姓名";
        _nameField.font = FONT_S;
    }
    return _nameField;
}

- (UITextField*)phoneField{
    if (_phoneField == nil) {
        _phoneField = [UITextField new];
        _phoneField.placeholder = @"联系电话";
        _phoneField.font = FONT_S;
    }
    return _phoneField;
}

- (UITextField*)addressField{
    if (_addressField == nil) {
        _addressField = [UITextField new];
        _addressField.placeholder = @"省、市、区";
        _addressField.font = FONT_S;
        _addressField.inputView = self.addressPicker;
    }
    return _addressField;
}

- (UITextField*)streetField{
    if (_streetField == nil) {
        _streetField = [UITextField new];
        _streetField.placeholder = @"街道";
        _streetField.font = FONT_S;
    }
    return _streetField;
}

- (UITextField*)detailField{
    if (_detailField == nil) {
        _detailField = [UITextField new];
        _detailField.placeholder = @"详细地址";
        _detailField.font = FONT_S;
    }
    return _detailField;
}

- (UIBarButtonItem*)rightItem{
    if (_rightItem == nil) {
        _rightItem = [[UIBarButtonItem alloc] initWithTitle:@"修改" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarAction:)];
        _rightItem.title = @"修改";
    }
    return _rightItem;
}

- (UIButton*)saveButton{
    if (_saveButton == nil) {
        _saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saveButton setTitle:@"保存" forState:UIControlStateNormal];
        [_saveButton setBackgroundColor:BUTTON_BG];
    }
    return _saveButton;
}

- (LAddressPicker*)addressPicker{
    if (_addressPicker == nil) {
        _addressPicker = [[LAddressPicker alloc] initWithFrame:CGRectMake(0, 0, SCREEN.width, 240)];
        _addressPicker.delegate = self;
    }
    return _addressPicker;
}

- (UIButton*)setDefaultButton{
    if (_setDefaultButton == nil) {
        _setDefaultButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_setDefaultButton setTitle:@"设置成为默认地址" forState:UIControlStateNormal];
        [_setDefaultButton setBackgroundColor:BUTTON_BG];
    }
    return _setDefaultButton;
}

@end
