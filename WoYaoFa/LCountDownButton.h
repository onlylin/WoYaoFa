//
//  LCountDownButton.h
//  WoYaoFa
//
//  Created by 林洁 on 15/12/10.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LCountDownButton;

typedef NSString* (^DidChangeBlock)(LCountDownButton *countDownButton, NSTimeInterval timeInterval);
typedef NSString* (^DidFinishedBlock)(LCountDownButton *countDownButton, NSTimeInterval timeInterval);

typedef void (^HandleBlock)(LCountDownButton *countDownButton, NSInteger tag);

@interface LCountDownButton : UIButton{
    DidChangeBlock _didChangeBlock;
    DidFinishedBlock _didFinishedBlock;
    HandleBlock _handleBlock;
}

- (void)addTouchHandle:(HandleBlock)handleBlock;
- (void)didChange:(DidChangeBlock)didChangeBlock;
- (void)didFinished:(DidFinishedBlock)didFinishedBlock;

- (void)startWithTimeInterval:(NSTimeInterval)timeInterval;

@end
