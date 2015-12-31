//
//  WCommentListViewController.m
//  WoYaoFa
//
//  Created by 林洁 on 15/12/28.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "WCommentListViewController.h"
#import "LinApiManager+Comment.h"

#define FONT_S [UIFont systemFontOfSize:15.0f]

@interface WCommentListViewController (){
    double total;
}

@end

@implementation WCommentListViewController
@synthesize lineId;

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = VIEW_BG;
    [self.view addSubview:self.navView];
    [self.view addSubview:self.tableView];
    [self.navView addSubview:self.ratingView];
    [self.navView addSubview:self.titleLabel];
    [self.navView addSubview:self.textLabel];
    total = 0;
    [self addRACSignal];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_offset(0);
        make.height.mas_equalTo(44);
    }];
    self.navView.backgroundColor = [UIColor whiteColor];
    
    [self.ratingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 25));
        make.center.equalTo(self.navView);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.ratingView);
        make.right.mas_equalTo(self.ratingView.mas_left).mas_offset(0);
    }];
    
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.ratingView);
        make.left.mas_equalTo(self.ratingView.mas_right).offset(5);
    }];
    self.textLabel.text = [NSString stringWithFormat:@"%.1f分",self.ratingView.value];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navView.mas_bottom).offset(5);
        make.left.right.bottom.mas_offset(0);
    }];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = VIEW_BG;
}

- (void)viewDidAppear:(BOOL)animated{
    [self getComments];
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell addSubview:[self.viewModels objectAtIndex:indexPath.section]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 220;
}

#pragma mark - Private Method
- (void)addRACSignal{
    [RACObserve(self, viewModels) subscribeNext:^(id x) {
        [self.tableView reloadData];
    }];
}

- (void)getComments{
    RACSignal *signal = [[LinApiManager shareInstance] getCommentsWithLineId:29 pageIndex:1 pageSize:10];
    [[[signal filter:^BOOL(LDataResult *dataResult) {
        [MBProgressHUD showTextOnly:dataResult.msg];
        return dataResult.code == ResponseStatusOk && dataResult.datas != nil;
    }] map:^id(LDataResult *dataResult) {
        return [LPageResult mj_objectWithKeyValues:dataResult.datas];
    }] subscribeNext:^(LPageResult *pageResult) {
        NSArray *array = [WComment mj_objectArrayWithKeyValuesArray:pageResult.results];
        NSMutableArray *datas = self.viewModels;
        for (WComment *comment in array) {
            WCommentView *commentView = [[WCommentView alloc] initWithFrame:CGRectMake(0, 0, SCREEN.width, 220)];
            commentView.model = comment;
            total += comment.score;
            [datas addObject:commentView];
        }
        self.viewModels = datas;
        self.ratingView.value = total / [self.viewModels count];
        self.textLabel.text = [NSString stringWithFormat:@"%.1f分",self.ratingView.value];
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
- (UIView*)navView{
    if (_navView == nil) {
        _navView = [UIView new];
    }
    return _navView;
}

- (HCSStarRatingView*)ratingView{
    if (_ratingView == nil) {
        _ratingView = [HCSStarRatingView new];
        _ratingView.maximumValue = 5;
        _ratingView.minimumValue = 1;
        _ratingView.value = 0;
        _ratingView.enabled = NO;
        _ratingView.tintColor = [UIColor hex:@"#ff7c34"];
    }
    return _ratingView;
}

- (UILabel*)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [UILabel new];
        _titleLabel.text = @"总评价 : ";
        _titleLabel.font = FONT_S;
    }
    return _titleLabel;
}

- (UILabel*)textLabel{
    if (_textLabel == nil) {
        _textLabel = [UILabel new];
        _textLabel.text = @"5分";
        _textLabel.font = FONT_S;
        _textLabel.textColor = [UIColor hex:@"#ff7c34"];
    }
    return _textLabel;
}

- (UITableView*)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    }
    return _tableView;
}

- (NSMutableArray*)viewModels{
    if (_viewModels == nil) {
        _viewModels = [NSMutableArray array];
    }
    return _viewModels;
}

@end
