//
//  WAddressBookViewController.m
//  WoYaoFa
//
//  Created by 林洁 on 15/12/7.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "WAddressBookViewController.h"
#import "LinApiManager+AddressBook.h"
#import "WAddressBookView.h"
#import "WAddressBookAddViewController.h"

@interface WAddressBookViewController (){
    NSInteger currentPage;
}

@end

@implementation WAddressBookViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.navigationController.navigationBar.translucent = NO;
    }
    self.navigationItem.titleView = self.segment;
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.addButton];
    
    [self addRACSignal];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.bottom.mas_offset(-40);
    }];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = VIEW_BG;
    
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(0);
        make.left.right.mas_offset(0);
        make.height.mas_equalTo(40);
    }];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        currentPage = 1;
        [self.viewModels removeAllObjects];
        [self.tableView reloadData];
        [self getAddressBooks:self.segment.selectedSegmentIndex];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        currentPage++;
        [self getAddressBooks:self.segment.selectedSegmentIndex];
    }];
}

- (void)viewDidAppear:(BOOL)animated{
    currentPage = 1;
    self.segment.selectedSegmentIndex = 0;
    [self setHidesBottomBarWhenPushed:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.viewModels count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Identifier = @"Cell";
    UITableViewCell *cell = nil;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    [cell addSubview:[self.viewModels objectAtIndex:indexPath.section]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 112;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WAddressBookView *view = [self.viewModels objectAtIndex:indexPath.section];
    WAddressBookAddViewController *viewController = [[WAddressBookAddViewController alloc] init];
    viewController.addressBook = [view model];
    viewController.addressBookType = self.segment.selectedSegmentIndex;
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - Private Method
- (void)getAddressBooks:(AddressBookType)type{
    RACSignal *signal = [[LinApiManager shareInstance] getAddressBooks:1 addressType:type pageIndex:currentPage pageSize:1];
    [[[signal filter:^BOOL(LDataResult *dataResult) {
        [MBProgressHUD showTextOnly:dataResult.msg];
        return dataResult.code == 2000 && dataResult.msg != nil;
    }] map:^id(LDataResult *dataResult) {
        return [LPageResult mj_objectWithKeyValues:dataResult.datas];
    }] subscribeNext:^(LPageResult *pageResult) {
        NSMutableArray *array = [WAddressBook mj_objectArrayWithKeyValuesArray:pageResult.results];
        for (WAddressBook *addressBook in array) {
            WAddressBookView *addressBookView = [[WAddressBookView alloc] initWithFrame:CGRectMake(0, 0, SCREEN.width, 112)];
            addressBookView.model = addressBook;
            [self.viewModels addObject:addressBookView];
        }
    } completed:^{
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
    }];
}

- (void)addRACSignal{
    [[RACObserve(self.segment, selectedSegmentIndex) filter:^BOOL(NSNumber *index) {
        return [index integerValue] >= 0;
    }] subscribeNext:^(NSNumber *index) {
        self.viewModels = nil;
        AddressBookType type = [index integerValue];
        if (type == AddressBookTypeShipper) {
            [self.addButton setTitle:@"添加发货人地址" forState:UIControlStateNormal];
        }else if(type == AddressBookTypeReceiver){
            [self.addButton setTitle:@"添加收货人地址" forState:UIControlStateNormal];
        }
        [self getAddressBooks:type];
    }];
    
    [RACObserve(self, viewModels) subscribeNext:^(id x) {
        [self.tableView reloadData];
    }];
    
    self.addButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        WAddressBookAddViewController *viewController = [[WAddressBookAddViewController alloc] init];
        viewController.addressBookType = self.segment.selectedSegmentIndex;
        [self.navigationController pushViewController:viewController animated:YES];
        return [RACSignal empty];
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
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN.width, 0.1)];
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN.width, 0.1)];
    }
    return _tableView;
}

- (NSMutableArray*)viewModels{
    if (_viewModels ==  nil) {
        _viewModels = [[NSMutableArray alloc] init];
    }
    return _viewModels;
}

- (UIButton*)addButton{
    if (_addButton == nil) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addButton setTitle:@"添加发货人地址" forState:UIControlStateNormal];
        [_addButton setBackgroundColor:BUTTON_BG];
    }
    return _addButton;
}

- (UISegmentedControl*)segment{
    if (_segment == nil) {
        _segment = [[UISegmentedControl alloc] initWithItems:@[@"收货人",@"发货人"]];
        _segment.size = CGSizeMake(120, 25);
    }
    return _segment;
}

@end
