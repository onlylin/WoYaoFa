//
//  WFeedbackViewController.m
//  WoYaoFa
//
//  Created by 林洁 on 15/12/20.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "WFeedbackViewController.h"
#import "UITextView+placeholder.h"
#import "LinApiManager+Feedback.h"

@interface WFeedbackViewController ()

@end

@implementation WFeedbackViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.navigationController.navigationBar.translucent = NO;
    }
    self.navigationItem.title = @"意见反馈";
    self.view.backgroundColor = VIEW_BG;
    [self.view addSubview:self.textView];
    [self.view addSubview:self.comintButton];
    
    [self addRACSignal];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_offset(0);
        make.height.mas_equalTo(200);
    }];
    
    [self.comintButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_equalTo(40);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


#pragma mark - Private Method
- (void)addRACSignal{
    self.comintButton.rac_command = [[RACCommand alloc]
                    initWithEnabled:[RACSignal
                            combineLatest:@[
                                self.textView.rac_textSignal
                            ]
                            reduce:^id(NSString *value){
                                NSNumber *enabled = @(value.length > 0);
                                self.comintButton.alpha = 0.5 + [enabled integerValue];
                                return enabled;
                            }]
                    signalBlock:^RACSignal *(id input) {
                        return [[LinApiManager shareInstance] addFeedback:self.textView.text account:33];
                    }];
    
    [self.comintButton.rac_command.executionSignals subscribeNext:^(RACSignal *signal) {
        [[signal filter:^BOOL(LDataResult *dataResult) {
            [MBProgressHUD showTextOnly:dataResult.msg];
            return dataResult.code == ResponseStatusOk;
        }] subscribeNext:^(id x) {
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
#pragma mark - Getter and Setter
- (UITextView*)textView{
    if (_textView == nil) {
        _textView = [UITextView new];
        _textView.placeholder = @"欢迎您对我们提供宝贵的意见！";
        _textView.font = [UIFont systemFontOfSize:16.0];
        _textView.delegate = self;
    }
    return _textView;
}

- (UIButton*)comintButton{
    if (_comintButton == nil) {
        _comintButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_comintButton setTitle:@"提交" forState:UIControlStateNormal];
        [_comintButton setBackgroundColor:BUTTON_BG];
    }
    return _comintButton;
}

@end
