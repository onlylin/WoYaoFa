//
//  WCommentViewController.m
//  WoYaoFa
//
//  Created by 林洁 on 15/12/18.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "WCommentViewController.h"
#import "UITextView+placeholder.h"
#import "LinApiManager+Comment.h"
#import "MLSelectPhotoAssets.h"
#import "MLSelectPhotoPickerViewController.h"
#import "MLPhotoBrowserViewController.h"
#import "MLPhotoBrowserAssets.h"
#import "HZActionSheet.h"

static NSString *WNotificationImageAdd = @"imageAdd";

@interface WCommentViewController ()<HZActionSheetDelegate,MLPhotoBrowserViewControllerDataSource,MLPhotoBrowserViewControllerDelegate>{
    UITableViewCell *selectCell;
}

@end

@implementation WCommentViewController
@synthesize orderId;

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.navigationController.navigationBar.translucent = NO;
    }
    
    self.navigationItem.title = @"评价";
    
    self.view.backgroundColor = VIEW_BG;
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.comintButton];
    
    [self addRACSignal];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.comintButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.bottom.mas_offset(0);
        make.height.mas_equalTo(40);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_offset(0);
    }];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = VIEW_BG;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
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
            [cell addSubview:self.ratingLabel];
            [self.ratingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(20);
                make.centerY.equalTo(cell);
                make.left.mas_offset(15);
            }];
            [cell addSubview:self.ratingView];
            [self.ratingView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(180, 20));
                make.centerY.equalTo(cell);
                make.left.equalTo(self.ratingLabel.mas_right).offset(1);
            }];
            break;
        }
        case 1:
        {
            if (indexPath.row == 0) {
                [cell addSubview:self.textLabel];
                [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(20);
                    make.top.mas_offset(10);
                    make.left.mas_offset(15);
                }];
                [cell addSubview:self.textView];
                [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.textLabel.mas_right).offset(0);
                    make.right.mas_offset(0);
                    make.top.mas_offset(2);
                    make.bottom.mas_offset(0);
                }];
            }else{
                [cell addSubview:self.imageView];
                [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.size.mas_equalTo(CGSizeMake(80, 80));
                    make.left.mas_offset(15);
                    make.centerY.mas_equalTo(cell);
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
            
        default:
            break;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return 150;
        }
        return 90;
    }
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
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



#pragma mark - Private Method
- (void)addRACSignal{
    self.comintButton.rac_command = [[RACCommand alloc]
                initWithEnabled:[RACSignal
                        combineLatest:@[
                            self.textView.rac_textSignal,
                            RACObserve(self.ratingView, value)
                        ] reduce:^id(NSString *text,NSNumber *star){
                            NSNumber *enabled = @(text.length > 0 && [star integerValue] > 0);
                            self.comintButton.alpha = 0.5 + [enabled integerValue];
                            return enabled;
                        }]
                signalBlock:^RACSignal *(id input) {
                    self.comment.lineId = 29;
                    self.comment.accountId = 33;
                    self.comment.content = self.textView.text;
                    self.comment.score = self.ratingView.value;
                    return [[LinApiManager shareInstance] addComment:self.comment order:orderId];
                }];
    
    [self.comintButton.rac_command.executionSignals subscribeNext:^(RACSignal *signal) {
        [[signal filter:^BOOL(LDataResult *dataResult) {
            [MBProgressHUD showTextOnly:dataResult.msg];
            return dataResult.code == ResponseStatusOk;
        }] subscribeNext:^(LDataResult *dataResult) {
            NSInteger commentId = [dataResult.datas integerValue];
            [self sendUploadImages:commentId];
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }];
}

- (void)sendUploadImages:(NSInteger)commentId{
    NSMutableArray *imageArrays = [NSMutableArray array];
    for (UIImageView *view in self.images) {
        [imageArrays addObject:view.image];
    }
    RACSignal *signal = [[LinApiManager shareInstance] uploadImages:imageArrays comment:commentId];
    [[signal filter:^BOOL(LDataResult *dataResult) {
        [MBProgressHUD showTextOnly:dataResult.msg];
        return dataResult.code == ResponseStatusOk;
    }] subscribeNext:^(id x) {

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

- (UIButton*)comintButton{
    if (_comintButton == nil) {
        _comintButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_comintButton setTitle:@"发表评价" forState:UIControlStateNormal];
        [_comintButton setBackgroundColor:BUTTON_BG];
    }
    return _comintButton;
}

- (HCSStarRatingView*)ratingView{
    if (_ratingView == nil) {
        _ratingView = [HCSStarRatingView new];
        _ratingView.maximumValue = 5;
        _ratingView.minimumValue = 1;
        _ratingView.value = 0;
        _ratingView.tintColor = [UIColor hex:@"#ff7c34"];
    }
    return _ratingView;
}

- (UILabel*)ratingLabel{
    if (_ratingLabel == nil) {
        _ratingLabel = [UILabel new];
        _ratingLabel.text = @"评价分数 : ";
    }
    return _ratingLabel;
}

- (UILabel*)textLabel{
    if (_textLabel == nil) {
        _textLabel = [UILabel new];
        _textLabel.text = @"评价内容 : ";
    }
    return _textLabel;
}

- (UITextView*)textView{
    if (_textView == nil) {
        _textView = [UITextView new];
        _textView.placeholder = @"这一刻的想法......";
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

- (WComment*)comment{
    if (_comment == nil) {
        _comment = [[WComment alloc] init];
    }
    return _comment;
}

- (NSMutableArray*)images{
    if (_images == nil) {
        _images = [NSMutableArray array];
    }
    return _images;
}

@end
