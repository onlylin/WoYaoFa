//
//  CollectionView.h
//  WoYaoFa
//
//  Created by 林洁 on 15/12/29.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WCollection.h"
#import "CollectionDelegate.h"


@interface CollectionView : UIView

@property (nonatomic, strong) id<CollectionDelegate> delegate;

@property (nonatomic, strong) UIImageView *logoView;

@property (nonatomic, strong) UILabel *companyName;

@property (nonatomic, strong) UIImageView *CACIIcon;

@property (nonatomic, strong) UIImageView *QCIcon;

@property (nonatomic, strong) UILabel *lineLabel;

@property (nonatomic, strong) UILabel *markLabel;

@property (nonatomic, strong) UILabel *distanceLabel;

@property (nonatomic, strong) UILabel *volumeLabel;

@property (nonatomic, strong) WCollection *model;

@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, strong) UIButton *otherButton;

@property (nonatomic, strong) UIView *lineView;

- (id)initWithFrame:(CGRect)frame;

@end
