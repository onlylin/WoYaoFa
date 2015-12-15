//
//  WEditNameViewController.m
//  WoYaoFa
//
//  Created by 林洁 on 15/12/14.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "WEditNameViewController.h"
#import "LinApiManager+Setting.h"

@interface WEditNameViewController ()

@end

@implementation WEditNameViewController
@synthesize userId;

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.navigationController.navigationBar.translucent = NO;
    }
    
    self.navigationItem.title = @"修改昵称";
    self.view.backgroundColor = VIEW_BG;
    
    self.navigationItem.rightBarButtonItem = self.rightButtonItem;
    [self.view addSubview:self.textField];
    
    [self addRACSignal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Private Method
- (void)addRACSignal{
    self.rightButtonItem.rac_command = [[RACCommand alloc]
                            initWithEnabled:[RACSignal
                                             combineLatest:@[
                                                self.textField.rac_textSignal
                                             ]
                                             reduce:^id(NSString *value){
                                                 NSNumber *enabled = @(value.length > 0);
                                                 return enabled;
                                             }]
                             signalBlock:^RACSignal *(id input) {
                                 WUser *modifyUser = [[WUser alloc] init];
                                 modifyUser.ID = userId;
                                 modifyUser.name = self.textField.text;
                                 return [[LinApiManager shareInstance] modifyUser:modifyUser];
                             }];
    [self.rightButtonItem.rac_command.executionSignals subscribeNext:^(RACSignal *signal) {
       [[signal filter:^BOOL(LDataResult *dataResult) {
           [MBProgressHUD showTextOnly:dataResult.msg];
           return dataResult.code == ResponseStatusOk;
       }] subscribeNext:^(id x) {
           [[NSNotificationCenter defaultCenter] postNotificationName:WNotficationNikname object:self.textField.text];
           [self.navigationController popViewControllerAnimated:YES];
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

#pragma mark Getter and Setter
- (UITextField*)textField{
    if (_textField == nil) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 44)];
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, SCREEN.width, 44)];
        _textField.placeholder = @"昵称";
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.leftView = view;
        _textField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _textField;
}


- (UIBarButtonItem*)rightButtonItem{
    if (_rightButtonItem == nil) {
        _rightButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:nil action:nil];
    }
    return _rightButtonItem;
}

@end
