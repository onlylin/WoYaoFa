//
//  WLineAndCompanyViewController.m
//  WoYaoFa
//
//  Created by 林洁 on 15/12/15.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "WLineAndCompanyViewController.h"
#import "LinApiManager+LineAndCompany.h"
#import "WCompanyView.h"
#import "WLineView.h"
#import "WCompany.h"

#define END_ADDRESS @"目的地"
#define BEGIN_BUTTON 0
#define END_BUTTON 1

@interface WLineAndCompanyViewController (){
    UIButton *selectButton;
}

@end

@implementation WLineAndCompanyViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.navigationController.navigationBar.translucent = NO;
    }
    
    [self.view addSubview:self.navView];
    [self.view addSubview:self.tableView];
    [self.navView addSubview:self.beginButton];
    [self.navView addSubview:self.endButton];
    [self.navView addSubview:self.distanceButton];
    [self.navView addSubview:self.imageView];
    [self.imageView addSubview:self.arrowView];
    
    [self.view addSubview:self.textField];
    
    [self addRACSignal];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN.width, 44));
        make.top.mas_offset(0);
    }];
    self.navView.backgroundColor = [UIColor whiteColor];
    
    [self.endButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.navView);
    }];
    
    [self.beginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(20);
        make.centerY.mas_equalTo(self.navView);
    }];
    
    [self.distanceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-20);
        make.centerY.mas_equalTo(self.navView);
    }];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.navView.mas_height);
        make.left.mas_equalTo(self.beginButton.mas_right);
        make.right.mas_equalTo(self.endButton.mas_left);
    }];
    
    [self.arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.imageView);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navView.mas_bottom).offset(0);
        make.left.bottom.right.mas_offset(0);
    }];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = VIEW_BG;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.viewModels = nil;
        self.endButton.titleLabel.text = END_ADDRESS;
        [self.endButton setTitle:END_ADDRESS forState:UIControlStateNormal];
    }];
}

- (void)viewDidAppear:(BOOL)animated{
    [self getCompanies];
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
    return [self.viewModels count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Identifier = @"Cell";
    UITableViewCell *cell = nil;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    [cell addSubview:[self.viewModels objectAtIndex:indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}

#pragma mark - LAddressPicker Delegate
- (void)selectedProvince:(NSString *)province city:(NSString *)city district:(NSString *)district{
    selectButton.titleLabel.text = district;
    [selectButton setTitle:district forState:UIControlStateNormal];
    [self deSelected];
}

- (void)deSelected{
    [self.textField resignFirstResponder];
}

#pragma mark - Private Method
- (void)addRACSignal{
    [RACObserve(self,viewModels) subscribeNext:^(id x) {
        [self.tableView reloadData];
    }];
    
    self.beginButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        selectButton = self.beginButton;
        [self.textField becomeFirstResponder];
        return [RACSignal empty];
    }];
    
    self.endButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        selectButton = self.endButton;
        [self.textField becomeFirstResponder];
        return [RACSignal empty];
    }];
    
    [RACObserve(self.endButton.titleLabel,text) subscribeNext:^(NSString *value) {
        self.viewModels = nil;
        if ([value isEqualToString:END_ADDRESS]) {
            [self getCompanies];
        }else{
            [self getLines];
        }
    }];
}

- (void)getCompanies{
    RACSignal *signal = [[LinApiManager shareInstance] getCompaniesByDistance:1000 lat:@"123" lng:@"123"];
    [[[signal filter:^BOOL(LDataResult *dataResult) {
        [MBProgressHUD showTextOnly:dataResult.msg];
        return dataResult.code == ResponseStatusOk && dataResult.datas != nil;
    }] map:^id(LDataResult *dataResult) {
        return [WCompany mj_objectArrayWithKeyValuesArray:dataResult.datas];
    }] subscribeNext:^(NSArray *array) {
        NSMutableArray *datas = self.viewModels;
        for (WCompany *company in array) {
            WCompanyView *companyView = [[WCompanyView alloc] initWithFrame:CGRectMake(0, 0, SCREEN.width, 130) viewModel:company];
            [datas addObject:companyView];
        }
        self.viewModels = datas;
    } completed:^{
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)getLines{
    RACSignal *signal = [[LinApiManager shareInstance] getLineByDistance:1000 lat:@"123" lng:@"123" begin:@"河北,邯郸,复兴区" end:@"河北,邯郸,复兴区"];
    [[[signal filter:^BOOL(LDataResult *dataResult) {
        [MBProgressHUD showTextOnly:dataResult.msg];
        return dataResult.code == ResponseStatusOk && dataResult.datas != nil;
    }] map:^id(LDataResult *dataResult) {
        return [WLine mj_objectArrayWithKeyValuesArray:dataResult.datas];
    }] subscribeNext:^(NSArray *array) {
        NSMutableArray *datas = self.viewModels;
        for (WLine *line in array) {
            WLineView *lineView = [[WLineView alloc] initWithFrame:CGRectMake(0, 0, SCREEN.width, 130) viewModel:line];
            [datas addObject:lineView];
        }
        self.viewModels = datas;
    } completed:^{
        [self.tableView.mj_header endRefreshing];
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

- (NSMutableArray*)viewModels{
    if (_viewModels == nil) {
        _viewModels = [[NSMutableArray alloc] init];
    }
    return _viewModels;
}

- (UIView*)navView{
    if (_navView == nil) {
        _navView = [UIView new];
    }
    return _navView;
}

- (UIButton*)beginButton{
    if (_beginButton == nil) {
        _beginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _beginButton.tintColor = [UIColor blackColor];
        [_beginButton setTitle:@"始发地" forState:UIControlStateNormal];
        _beginButton.tag = BEGIN_BUTTON;
    }
    return _beginButton;
}

-(UIButton*)endButton{
    if (_endButton == nil) {
        _endButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _endButton.tintColor = [UIColor blackColor];
        [_endButton setTitle:END_ADDRESS forState:UIControlStateNormal];
        _endButton.tag = END_BUTTON;
    }
    return _endButton;
}

- (UIButton*)distanceButton{
    if (_distanceButton == nil) {
        _distanceButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _distanceButton.tintColor = [UIColor blackColor];
        [_distanceButton setTitle:@"距离最近" forState:UIControlStateNormal];
    }
    return _distanceButton;
}

- (UIImageView*)arrowView{
    if (_arrowView == nil) {
        _arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrive_icon"]];
    }
    return _arrowView;
}

- (UIView*)imageView{
    if (_imageView == nil) {
        _imageView = [UIView new];
    }
    return _imageView;
}

- (LAddressPicker*)addressPicker{
    if (_addressPicker == nil) {
        _addressPicker = [[LAddressPicker alloc] initWithFrame:CGRectMake(0, 0, SCREEN.width, 240)];
        _addressPicker.delegate = self;
    }
    return _addressPicker;
}

- (UITextField*)textField{
    if (_textField == nil) {
        _textField = [UITextField new];
        _textField.inputView = self.addressPicker;
    }
    return _textField;
}

@end
