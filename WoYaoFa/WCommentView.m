//
//  WCommentView.m
//  WoYaoFa
//
//  Created by 林洁 on 15/12/28.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "WCommentView.h"

@implementation WCommentView


- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.logoView];
        [self addSubview:self.nameLabel];
        [self addSubview:self.levelLabel];
        [self addSubview:self.ratingLabel];
        [self addSubview:self.ratingView];
        [self addSubview:self.lineView];
        [self addSubview:self.textView];
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self addRACSignal];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [self.logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.left.mas_offset(15);
        make.top.mas_offset(15);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.logoView.mas_right).offset(10);
        make.centerY.mas_equalTo(self.logoView);
    }];
    
    [self.levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel.mas_right).offset(5);
        make.top.mas_equalTo(self.nameLabel);
    }];
    
    [self.ratingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.top.mas_equalTo(self.nameLabel);
    }];
    
    [self.ratingView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80,20));
        make.centerY.mas_equalTo(self.ratingLabel);
        make.right.mas_equalTo(self.ratingLabel.mas_left).offset(-5);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.logoView.mas_bottom).offset(15);
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.height.mas_equalTo(1);
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineView.mas_bottom).offset(5);
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.height.mas_equalTo(50);
    }];
    
    UIImageView *imageView = [UIImageView new];
    imageView.backgroundColor = [UIColor blueColor];
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.left.mas_offset(15);
        make.top.mas_equalTo(self.textView.mas_bottom).offset(10);
    }];
}

#pragma mark - RACSignal
- (void)addRACSignal{
    [RACObserve(self, model) subscribeNext:^(WComment *object) {
        self.nameLabel.text = object.user.name;
        self.ratingView.value = object.score;
        self.ratingLabel.text = [NSString stringWithFormat:@"%.1f分",self.ratingView.value];
        self.textView.text = object.content;
    }];
}

#pragma mark - Getter and Setter
- (UIImageView*)logoView{
    if (_logoView == nil) {
        _logoView = [UIImageView new];
        _logoView.backgroundColor = [UIColor redColor];
    }
    return _logoView;
}

- (UILabel*)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [UILabel new];
    }
    return _nameLabel;
}

- (UILabel*)levelLabel{
    if (_levelLabel == nil) {
        _levelLabel = [UILabel new];
        _levelLabel.textColor = [UIColor hex:@"#ff7c34"];
    }
    return _levelLabel;
}

- (HCSStarRatingView*)ratingView{
    if (_ratingView == nil) {
        _ratingView = [[HCSStarRatingView alloc] initWithFrame:CGRectMake(0, 0, 100, 25)];
        _ratingView.maximumValue = 5;
        _ratingView.minimumValue = 1;
        _ratingView.value = 0;
        _ratingView.enabled = NO;
        _ratingView.tintColor = [UIColor hex:@"#ff7c34"];
    }
    return _ratingView;
}

- (UILabel*)ratingLabel{
    if (_ratingLabel == nil) {
        _ratingLabel = [UILabel new];
        _ratingLabel.textColor = [UIColor hex:@"#ff7c34"];
    }
    return _ratingLabel;
}

- (UIView*)lineView{
    if (_lineView == nil) {
        _lineView = [UIView new];
        _lineView.backgroundColor = VIEW_BG;
    }
    return _lineView;
}

- (UITextView*)textView{
    if (_textView == nil) {
        _textView = [UITextView new];
        _textView.userInteractionEnabled = NO;
    }
    return _textView;
}

@end
