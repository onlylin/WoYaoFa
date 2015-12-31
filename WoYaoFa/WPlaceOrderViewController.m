//
//  WPlaceOrderViewController.m
//  WoYaoFa
//
//  Created by 林洁 on 15/12/15.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "WPlaceOrderViewController.h"
#import "WPlaceOrderView.h"
#import "UITextView+placeholder.h"
#import "WSelectAddressViewController.h"
#import "MLSelectPhotoAssets.h"
#import "MLSelectPhotoPickerViewController.h"
#import "MLPhotoBrowserViewController.h"
#import "MLPhotoBrowserAssets.h"
#import "HZActionSheet.h"
#import "LinApiManager+Order.h"

static NSString *WNotificationImageAdd = @"imageAdd";

@interface WPlaceOrderViewController ()<HZActionSheetDelegate,MLPhotoBrowserViewControllerDataSource,MLPhotoBrowserViewControllerDelegate>{
    WAddressBook *shipperAddress;
    WAddressBook *receiverAddress;
    UITableViewCell *selectCell;
}

@end

@implementation WPlaceOrderViewController
@synthesize lineId;

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.navigationController.navigationBar.translucent = NO;
    }
    
    self.navigationItem.title = @"立即下单";
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.saveButton];
    [self.view addSubview:self.textField];
    
    [self addRACSignal];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_offset(0);
    }];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = VIEW_BG;
    
    [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(0);
        make.left.mas_offset(0);
        make.right.mas_offset(0);
        make.height.mas_equalTo(40);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 2) {
        return 2;
    }
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Identifier = @"Cell";
    UITableViewCell *cell = nil;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.section) {
        case 0:
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            WPlaceOrderView *placeOrderView = [[WPlaceOrderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN.width - 20, 90)];
            placeOrderView.model = nil;
            [cell addSubview:placeOrderView];
            break;
        }
        case 1:
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN.width, 90)];
            label.text = @"点击添加收货方";
            label.textColor = [UIColor hex:@"#747273"];
            label.textAlignment = NSTextAlignmentCenter;
            [cell addSubview:label];
            break;
        }
        case 2:
        {
            if (indexPath.row == 0) {
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 80, 20)];
                label.text = @"货物信息:";
                label.font = [UIFont systemFontOfSize:17.0f];
                [cell addSubview:label];
                [cell addSubview:self.textView];
                [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(label.mas_right);
                    make.top.mas_offset(1);
                    make.right.bottom.mas_offset(0);
                }];
            }else{
                [cell addSubview:self.imageView];
                [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_offset(15);
                    make.centerY.equalTo(cell);
                }];
                
                self.imageView.userInteractionEnabled = YES;
                
                [self.imageView bk_whenTapped:^{
                    selectCell = cell;
                    //注册添加图片后显示以及更新UI的通知
                    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:WNotificationImageAdd object:nil] subscribeNext:^(id x) {
                        [self reloadImageViews];
                    }];
                    HZActionSheet *actionSheet = [[HZActionSheet alloc] initWithTitle:@"头像选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonIndexSet:nil otherButtonTitles:@[@"拍照",@"相册"]];
                    actionSheet.tag = 0;
                    [actionSheet showInView:self.view];
                }];
            }
            
            break;
        }
        case 3:
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [cell addSubview:self.timeLabel];
            [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(cell.height);
                make.left.mas_offset(15);
            }];
            [cell addSubview:self.time];
            [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(cell.height);
                make.left.equalTo(self.timeLabel.mas_right).offset(0);
            }];
            cell.detailTextLabel.text = @"点击修改";
            cell.detailTextLabel.textColor = [UIColor hex:@"#2eadfe"];
            break;
        }
            
        default:
            break;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        case 1:
            return 90;
        case 2:
        {
            if (indexPath.row == 0) {
                return 90;
            }
            return 90;
        }
        case 3:
            return 44;
    }
    return 90;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            [[[NSNotificationCenter defaultCenter] rac_addObserverForName:WNotificationSelectAddress object:nil] subscribeNext:^(NSNotification *notification) {
                WAddressBook *addressBook = notification.object;
                if (addressBook.type == AddressBookTypeShipper) {
                    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                    for (UIView *view in cell.subviews) {
                        if ([view isKindOfClass:[WPlaceOrderView class]]) {
                            WPlaceOrderView *placeOrderView = (WPlaceOrderView*)view;
                            placeOrderView.model = addressBook;
                            shipperAddress = addressBook;
                            self.order.beginName = addressBook.name;
                            self.order.beginPhone = addressBook.phone;
                            self.order.beginAddress = [NSString stringWithFormat:@"%@,%@,%@,%@,%@",addressBook.province,addressBook.city,addressBook.district,addressBook.street,addressBook.detail];
                        }
                    }
                }
            }];
            WSelectAddressViewController *viewController = [[WSelectAddressViewController alloc] init];
            viewController.addressBookType = 1;
            [self.navigationController pushViewController:viewController animated:YES];
            break;
        }
        case 1:
        {
            [[[NSNotificationCenter defaultCenter] rac_addObserverForName:WNotificationSelectAddress object:nil] subscribeNext:^(NSNotification *notification) {
                WAddressBook *addressBook = notification.object;
                if (addressBook.type == AddressBookTypeReceiver) {
                    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                    WPlaceOrderView *placeOrderView = [[WPlaceOrderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN.width - 20, 90)];
                    placeOrderView.model = addressBook;
                    self.order.endName = addressBook.name;
                    self.order.endPhone = addressBook.phone;
                    self.order.endAddress = [NSString stringWithFormat:@"%@,%@,%@,%@,%@",addressBook.province,addressBook.city,addressBook.district,addressBook.street,addressBook.detail];
                    [cell addSubview:placeOrderView];
                }
            }];
            WSelectAddressViewController *viewController = [[WSelectAddressViewController alloc] init];
            viewController.addressBookType = 0;
            [self.navigationController pushViewController:viewController animated:YES];
            break;
        }
        case 3:
        {
            [self.textField becomeFirstResponder];
            break;
        }
        default:
            break;
    }
}

#pragma mark - UITextView Delegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text{
    // Any new character added is passed in as the "text" parameter
    if ([text isEqualToString:@"\n"]) {
        // Be sure to test for equality using the "isEqualToString" message
        [textView resignFirstResponder];
        
        // Return FALSE so that the final '\n' character doesn't get added
        return FALSE;
    }
    // For any other character return TRUE so that the text gets added to the view
    return TRUE;
}

#pragma mark - UIDateView Delegate
- (void)selected:(NSDate *)date{
    self.order.dueTime = [date timeIntervalSince1970] * 1000;
    self.time.text = [[YLMoment momentWithDate:date] format:@"yyyy-MM-dd HH:mm:ss"];
    [self deSelected];
}

- (void)deSelected{
    [self.textField resignFirstResponder];
}

#pragma mark - HZActionSheet Delegate
- (void)actionSheet:(HZActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex != 2) {
        if (buttonIndex == 0) {
            //相机
            
        }else if (buttonIndex == 1){
            //相册
            MLSelectPhotoPickerViewController *pickerView = [[MLSelectPhotoPickerViewController alloc] init];
            pickerView.status = PickerViewShowStatusCameraRoll;
            pickerView.minCount = 4;
            [pickerView show];
            __weak typeof(self) weakSelf = self;
            pickerView.callBack = ^(NSArray *assets){
                for (int i = 0; i < [assets count]; i++) {
                    UIImageView *commentImageView = [UIImageView new];
                    MLSelectPhotoAssets *photoAssets = assets[i];
                    commentImageView.image = photoAssets.originImage;
                    [weakSelf.images addObject:commentImageView];
                }
                //发送更新UI通知
                [[NSNotificationCenter defaultCenter] postNotificationName:WNotificationImageAdd object:nil];
            };
        }
    }
}

#pragma mark - MLPhotoBrowserViewControllerDataSource
- (NSInteger)photoBrowser:(MLPhotoBrowserViewController *)photoBrowser numberOfItemsInSection:(NSUInteger)section{
    return self.images.count;
}

- (MLPhotoBrowserPhoto*)photoBrowser:(MLPhotoBrowserViewController *)photoBrowser photoAtIndexPath:(NSIndexPath *)indexPath{
    MLPhotoBrowserPhoto *photo = [[MLPhotoBrowserPhoto alloc] init];
    UIImageView *photoImageView = [self.images objectAtIndex:indexPath.row];
    photo.photoObj = photoImageView.image;
    return photo;
}


- (void)photoBrowser:(MLPhotoBrowserViewController *)photoBrowser removePhotoAtIndexPath:(NSIndexPath *)indexPath{
    UIImageView *deletedImageView = [self.images objectAtIndex:indexPath.row];
    [deletedImageView removeFromSuperview];
    [self.images removeObject:deletedImageView];
    [self reloadImageViews];
}

#pragma mark - Event Method
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.textView resignFirstResponder];
}

#pragma mark - Private Method
- (void)addRACSignal{
    [self.textView.rac_textSignal subscribeNext:^(NSString *value) {
        self.order.detail = value;
        NSNumber *enabled = @(self.order.beginName.length > 0 && self.order.beginPhone.length > 0 && self.self.order.beginAddress.length > 0 && self.order.endName.length > 0 && self.order.endPhone.length > 0 && self.order.endAddress.length > 0 && self.order.detail.length > 0);
        self.saveButton.userInteractionEnabled = [enabled boolValue];
        self.saveButton.alpha = 0.5 + [enabled integerValue];
    }];
    
    self.saveButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        self.order.accountId = 33;
        self.order.lineId = lineId;
        return [[LinApiManager shareInstance] addOrder:self.order];
    }];
    
    [self.saveButton.rac_command.executionSignals subscribeNext:^(RACSignal *signal) {
       [[signal filter:^BOOL(LDataResult *dataResult) {
           [MBProgressHUD showTextOnly:dataResult.msg];
           return dataResult.code == ResponseStatusOk;
       }] subscribeNext:^(LDataResult *dataResult) {
           NSInteger orderId = [dataResult.datas integerValue];
           [self sendUploadImages:orderId];
           [self.navigationController popViewControllerAnimated:YES];
       }];
    }];
}

-(void)reloadImageViews{
    for (UIImageView *view in self.images) {
        [view removeFromSuperview];
    }
    for (int i = 0; i < [self.images count]; i++) {
        UIImageView *commentImageView = self.images[i];
        commentImageView.tag = i;
        [selectCell addSubview:commentImageView];
        [commentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(80, 80));
            make.left.mas_offset(15 + i * 80 + i* 10);
            make.centerY.equalTo(selectCell);
        }];
        commentImageView.userInteractionEnabled = YES;
        //为已经选择的图片添加点击事件
        [commentImageView bk_whenTapped:^{
            MLPhotoBrowserViewController *photoBrower = [[MLPhotoBrowserViewController alloc] init];
            photoBrower.status = UIViewAnimationAnimationStatusFade;
            photoBrower.editing = YES;
            photoBrower.delegate = self;
            photoBrower.dataSource = self;
            photoBrower.currentIndexPath = [NSIndexPath indexPathForItem:commentImageView.tag inSection:0];
            [photoBrower show];
        }];
    }
    if ([self.images count] == 4) {
        [self.imageView setHidden:YES];
    }else{
        [self.imageView setHidden:NO];
        NSInteger count = [self.images count];
        [self.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(80, 80));
            make.left.mas_offset(15 + count * 80 + count* 10);
            make.centerY.equalTo(selectCell);
        }];
    }
}

- (void)sendUploadImages:(NSInteger)orderId{
    NSMutableArray *imageArray = [NSMutableArray array];
    for (UIImageView *view in self.images) {
        [imageArray addObject:view.image];
    }
    RACSignal *signal = [[LinApiManager shareInstance] uploadImages:imageArray ordre:orderId];
    [[signal filter:^BOOL(LDataResult *dataResult) {
        [MBProgressHUD showTextOnly:dataResult.msg];
        return dataResult.code = ResponseStatusOk;
    }] subscribeNext:^(id x) {
        
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
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (UIButton*)saveButton{
    if (_saveButton == nil) {
        _saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saveButton setTitle:@"确认下单" forState:UIControlStateNormal];
        [_saveButton setBackgroundColor:BUTTON_BG];
    }
    return _saveButton;
}

- (UITextView*)textView{
    if (_textView == nil) {
        _textView = [UITextView new];
        _textView.placeholder = @"请输入货物规格及数量";
        _textView.font = [UIFont systemFontOfSize:16.0f];
        _textView.delegate = self;
    }
    return _textView;
}

- (UIImageView*)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logistics_add_images"]];
    }
    return _imageView;
}

- (UILabel*)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [UILabel new];
        _timeLabel.text = @"预约时间:";
        _timeLabel.textColor = [UIColor hex:@"#747273"];
    }
    return _timeLabel;
}

- (UILabel*)time{
    if (_time == nil) {
        _time = [UILabel new];
        _time.textColor = [UIColor hex:@"#2eadfe"];
        _time.text = @"现在";
    }
    return _time;
}

- (WOrder*)order{
    if (_order == nil) {
        _order = [[WOrder alloc] init];
    }
    return _order;
}


- (UIDateView*)datePicker{
    if (_datePicker == nil) {
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中
        NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
        _datePicker = [[UIDateView alloc] initWithTimeZone:timeZone locale:locale mode:UIDatePickerModeDateAndTime maxDate:[NSDate date]];
        _datePicker.delegate = self;
    }
    return _datePicker;
}

- (UITextField*)textField{
    if (_textField == nil) {
        _textField = [UITextField new];
        _textField.inputView = self.datePicker;
    }
    return _textField;
}

- (NSMutableArray*)images{
    if (_images == nil) {
        _images = [NSMutableArray array];
    }
    return _images;
}

@end
