//
//  WOrdersViewController.m
//  WoYaoFa
//
//  Created by 林洁 on 15/12/11.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "WOrdersViewController.h"
#import "LinApiManager+Order.h"
#import "WCommentViewController.h"
#import "WPaymentViewController.h"
#import "WOrderView.h"

@interface WOrdersViewController ()<WOrderViewDelegate>{
    NSArray *keys;
    NSDictionary *dictionary;
}

@end

@implementation WOrdersViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.navigationController.navigationBar.translucent = NO;
    }
    self.navigationItem.title = @"订单列表";
    keys = @[@"待受理",@"待发货",@"待收货",@"待评价",@"已完成"];
    dictionary = @{
                   @"已完成" : @(-1),
                   @"待受理" : @(0),
                   @"待发货" : @(1),
                   @"待收货" : @(2),
                   @"待评价" : @(4)
                   };
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.segment];
    self.segment.selectedSegmentIndex = 0;
    [self addRACSignal];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.segment.mas_bottom).offset(0);
        make.bottom.left.right.mas_offset(0);
    }];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = VIEW_BG;
}

- (void)viewDidAppear:(BOOL)animated{
    [self setHidesBottomBarWhenPushed:YES];
    __weak NSDictionary *weakDict = dictionary;
    __weak NSArray *weakKeys = keys;
    @weakify(self)
    [self.segment setIndexChangeBlock:^(NSInteger index) {
        @strongify(self)
        NSNumber *status = [weakDict objectForKey:weakKeys[index]];
        [self.viewModels removeAllObjects];
        [self getOrders:(OrderStatus)[status integerValue]];
    }];
}

- (void)viewWillDisappear:(BOOL)animated{
    [self setHidesBottomBarWhenPushed:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -UITableView Delegate
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 260;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}


- (void)clickLeftButton:(OrderStatus)orderStatus viewModel:(WOrderView *)viewModel{
    switch (orderStatus) {
        case OrderStatusReceived:
        {
            WPaymentViewController *viewController = [[WPaymentViewController alloc] init];
            [self.navigationController pushViewController:viewController animated:YES];
            break;
        }
            
        default:
            break;
    }
}

- (void)clickRight1Button:(OrderStatus)orderStatus viewModel:(WOrderView *)viewModel{
    switch (orderStatus) {
        case OrderStatusAccepted:
        case OrderStatusShipped:
        {
            //取消订单和申请取消订单事件
            RACSignal *signal = [[LinApiManager shareInstance] cancelOrder:viewModel.model.ID orderStatus:orderStatus];
            [[signal filter:^BOOL(LDataResult *dataResult) {
                [MBProgressHUD showTextOnly:dataResult.msg];
                return dataResult.code == ResponseStatusOk;
            }] subscribeNext:^(id x) {
                [self.viewModels removeObject:viewModel];
                [self.tableView reloadData];
            }];
            break;
        }
            
        default:
            break;
    }
}

- (void)clickRight2Button:(OrderStatus)orderStatus viewModel:(WOrderView *)viewModel{
    switch (orderStatus) {
        case OrderStatusShipped:
        case OrderStatusAccepted:
        {
            UIAlertView *alertView = [UIAlertView bk_showAlertViewWithTitle:nil message:@"提醒成功" cancelButtonTitle:@"确定" otherButtonTitles:nil handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                
            }];
            [alertView show];
            break;
        }
        case OrderStatusReceived:
        case OrderStatusConfirmed:
        {
            RACSignal *signal = [[LinApiManager shareInstance] confirmOrder:viewModel.model.ID];
            [[signal filter:^BOOL(LDataResult *dataResult) {
                [MBProgressHUD showTextOnly:dataResult.msg];
                return dataResult.code == ResponseStatusOk;
            }] subscribeNext:^(id x) {
                [self.viewModels removeAllObjects];
                [self getOrders:2];
            }];
            break;
        }
        case OrderStatusEvaluated:
        {
            WCommentViewController *viewContrller = [[WCommentViewController alloc] init];
            viewContrller.orderId = viewModel.model.ID;
            [self.navigationController pushViewController:viewContrller animated:YES];
            break;
        }
        default:
            break;
    }
}


#pragma mark - Private Method
- (void)addRACSignal{
    [RACObserve(self.segment, selectedSegmentIndex) subscribeNext:^(NSNumber *index) {
        NSNumber *status = [dictionary objectForKey:keys[[index integerValue]]];
        [self getOrders:(OrderStatus)[status integerValue]];
    } completed:^{
        
    }];
}

- (void)getOrders:(OrderStatus)status{
    RACSignal *signal = [[LinApiManager shareInstance] getOrders:33 orderStatus:status pageIndex:1 pageSize:10];
    [[[signal filter:^BOOL(LDataResult *dataResult) {
        [MBProgressHUD showTextOnly:dataResult.msg];
        return dataResult.code == ResponseStatusOk && dataResult.datas != nil;
    }] map:^id(LDataResult *dataResult) {
        return [LPageResult mj_objectWithKeyValues:dataResult.datas];
    }] subscribeNext:^(LPageResult *pageResult) {
        NSArray *array = [WOrder mj_objectArrayWithKeyValuesArray:pageResult.results];
        for (WOrder *order in array) {
            WOrderView *orderView = [[WOrderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN.width, 260)];
            orderView.model = order;
            orderView.delegate = self;
            [self.viewModels addObject:orderView];
        }
    } completed:^{
        [self.tableView reloadData];
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
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    }
    return _tableView;
}

- (HMSegmentedControl*)segment{
    if (_segment == nil) {
        _segment = [[HMSegmentedControl alloc] initWithSectionTitles:keys];
        [_segment setFrame:CGRectMake(0, 0, SCREEN.width, 48)];
        _segment.selectionIndicatorHeight = 4.0f;
        _segment.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor hex:@"#a2a2a2"],NSFontAttributeName : [UIFont systemFontOfSize:16.0f]};
        _segment.selectionIndicatorColor = [UIColor hex:@"#2e82fe"];
        _segment.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor hex:@"#2e82fe"]};
        _segment.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
        _segment.selectedSegmentIndex = HMSegmentedControlNoSegment;
        _segment.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    }
    return _segment;
}

- (NSMutableArray*)viewModels{
    if (_viewModels == nil) {
        _viewModels = [[NSMutableArray alloc] init];
    }
    return _viewModels;
}

@end
