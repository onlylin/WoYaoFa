//
//  WCollectionsViewController.m
//  WoYaoFa
//
//  Created by 林洁 on 15/12/29.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "WCollectionsViewController.h"
#import "WPlaceOrderViewController.h"
#import "CollectionView.h"
#import "CollectionLineView.h"

@interface WCollectionsViewController ()<CollectionDelegate>

@end

@implementation WCollectionsViewController
@synthesize type;

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
    [self addRACSignal];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_offset(0);
    }];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = VIEW_BG;
}

- (void)viewDidAppear:(BOOL)animated{
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIView *view = [self.viewModels objectAtIndex:indexPath.section];
    view.tag = indexPath.section;
    [cell addSubview:view];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180;
}

#pragma mark - Collection Delegate
- (void)cancel:(UIView *)view collection:(WCollection *)collection{
    RACSignal *signal = [[LinApiManager shareInstance] cancelCollection:collection.ID];
    [[signal filter:^BOOL(LDataResult *dataResult) {
        [MBProgressHUD showTextOnly:dataResult.msg];
        return dataResult.code == ResponseStatusOk;
    }] subscribeNext:^(id x) {
        [self.viewModels removeObjectAtIndex:view.tag];
        [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:view.tag] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
}

- (void)callPhone:(WCollection *)collection{
    NSString *phone = @"";
    if (collection.type == CollectionTypeCompany) {
        phone = collection.company.phone;
    }else{
        phone = collection.line.company.phone;
    }
    UIActionSheet *actionSheet = [[UIActionSheet alloc] bk_initWithTitle:nil];
    [actionSheet bk_addButtonWithTitle:phone handler:^{
        
    }];
    [actionSheet bk_setCancelButtonWithTitle:@"取消" handler:^{
        
    }];
    [actionSheet showInView:self.view];
}

- (void)order:(WLine *)line{
    WPlaceOrderViewController *viewControllers = [[WPlaceOrderViewController alloc] init];
    viewControllers.lineId = line.ID;
    [self.navigationController pushViewController:viewControllers animated:YES];
}

#pragma mark - Private Method
- (void)addRACSignal{
    [RACObserve(self, viewModels) subscribeNext:^(id x) {
        [self.tableView reloadData];
    }];
    
    [[RACObserve(self.segment, selectedSegmentIndex) filter:^BOOL(NSNumber *index) {
        return [index integerValue] >= 0;
    }] subscribeNext:^(NSNumber *index) {
        self.viewModels = nil;
        if ([index integerValue] == 1) {
            type = CollectionTypeCompany;
        }else{
            type = CollectionTypeLine;
        }
        [self getCollections];
    }];
}

- (void)getCollections{
    RACSignal *signal = [[LinApiManager shareInstance] getCollectionByAccountId:33 type:type];
    [[signal filter:^BOOL(LDataResult *dataResult) {
        [MBProgressHUD showTextOnly:dataResult.msg];
        return dataResult.code == ResponseStatusOk && dataResult.datas != nil;
    }] subscribeNext:^(LDataResult *dataResult) {
        NSArray *array = [WCollection mj_objectArrayWithKeyValuesArray:dataResult.datas];
        NSMutableArray *datas = self.viewModels;
        for (WCollection *collection in array) {
            if (type == CollectionTypeCompany) {
                CollectionView *collectionView = [[CollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN.width, 180)];
                collectionView.model = collection;
                collectionView.delegate = self;
                [datas addObject:collectionView];
            }else if (type == CollectionTypeLine){
                CollectionLineView *collectionLineView = [[CollectionLineView alloc] initWithFrame:CGRectMake(0, 0, SCREEN.width, 180)];
                collectionLineView.model = collection;
                collectionLineView.delegate = self;
                [datas addObject:collectionLineView];
            }
        }
        self.viewModels = datas;
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
    }
    return _tableView;
}


- (UISegmentedControl*)segment{
    if (_segment == nil) {
        _segment = [[UISegmentedControl alloc] initWithItems:@[@"物流线路", @"物流公司"]];
    }
    return _segment;
}

- (NSMutableArray*)viewModels{
    if (_viewModels == nil) {
        _viewModels = [NSMutableArray array];
    }
    return _viewModels;
}

@end
