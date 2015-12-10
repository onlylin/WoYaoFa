//
//  LCountDownButton.m
//  WoYaoFa
//
//  Created by 林洁 on 15/12/10.
//  Copyright © 2015年 Lin. All rights reserved.
//

#import "LCountDownButton.h"

@implementation LCountDownButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)addTouchHandle:(HandleBlock)handleBlock{
    _handleBlock = [handleBlock copy];
    [self addTarget:self action:@selector(touched:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)touched:(LCountDownButton*)sender{
    if (_handleBlock) {
        _handleBlock(sender,sender.tag);
    }
}

- (void)startWithTimeInterval:(NSTimeInterval)timeInterval{
    __block int timeout = timeInterval; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0 ){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self setTitle:_didFinishedBlock(self,timeout) forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
                self.alpha = 1.0;
            });
        }else{
            //            int minutes = timeout / 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self setTitle:_didChangeBlock(self,timeout) forState:UIControlStateNormal];
                self.userInteractionEnabled = NO;
                self.alpha = 0.5;
                
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
}


#pragma mark - block
- (void)didChange:(DidChangeBlock)didChangeBlock{
    _didChangeBlock = [didChangeBlock copy];
}

- (void)didFinished:(DidFinishedBlock)didFinishedBlock{
    _didFinishedBlock = [didFinishedBlock copy];
}


@end
