//
//  ToastMessage.m
//  butterfly
//
//  Created by Aviel on 11/11/20.
//  Copyright © 2020 Aviel. All rights reserved.
//

#import "ToastMessage.h"

@implementation ToastMessage

-(void) removeSelf {
    [UIView animateWithDuration: 0.5 animations:^{
        self.alpha = 0;
        self.transform = CGAffineTransformMakeScale(0.8, 1);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (self.callback) {
            self.callback();
        }
    }];
}

/// This method is FOR DEBUG PURPOSES only and it won't be able to run in release builds.
+(void) show: (NSString *) messageText delayInSeconds:(NSTimeInterval) delay onDone:(void (^)(void)) callback {
    
    if (!NSThread.isMainThread) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [ToastMessage show: messageText delayInSeconds: delay onDone: callback];
        }];
        
        return;
    }
    
    UIWindow *appWindow = UIApplication.sharedApplication.keyWindow;
    if (!appWindow) {
        if (callback) {
            callback();
        }
        
        return;
    }
    
    // Personally we sould prefer to use autolayout (constraints) but we rather not too, because we never can predeict wich kind of project will run this SDK, and the results are satisfying FOR DEBUG PURPOSES.
    CGFloat width = UIScreen.mainScreen.bounds.size.width;
    CGFloat height = UIScreen.mainScreen.bounds.size.height;
    ToastMessage *toastMessage = [[ToastMessage alloc] initWithFrame: (CGRectMake(width * 0.1, height * 0.8	, width * 0.8, height * 0.1))];
    toastMessage.delay = delay;
    toastMessage.messageLabel = [[UILabel alloc] initWithFrame: (CGRectMake(width * 0.15, 0, width * 0.5, height * 0.1))];
    toastMessage.messageLabel.textAlignment = NSTextAlignmentCenter;
    toastMessage.messageLabel.text = messageText;
    toastMessage.messageLabel.textColor = [UIColor whiteColor];
    toastMessage.messageLabel.numberOfLines = 0;
    toastMessage.layer.cornerRadius = 30;
    toastMessage.layer.masksToBounds = YES;
    
    [toastMessage addSubview: toastMessage.messageLabel];
    toastMessage.userInteractionEnabled = NO;
    toastMessage.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent: 0.8];
    
    toastMessage.callback = callback;
    
    toastMessage.alpha = 0;
    [appWindow addSubview: toastMessage];
    toastMessage.transform = CGAffineTransformMakeScale(0.1, 0.1);
    
    [UIView animateWithDuration: 0.3 animations:^{
        toastMessage.alpha = 1;
        toastMessage.transform = CGAffineTransformMakeScale(1, 1);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [toastMessage removeSelf];
    });
    
    //        toastMessage.translatesAutoresizingMaskIntoConstraints = false
    //        let bottomConstraint = NSLayoutConstraint(item: toastMessage, attribute: .bottom, relatedBy: .equal, toItem: toastMessage.superview, attribute: .bottom, multiplier: 1, constant: -30.0)
    //        let leftConstraint = NSLayoutConstraint(item: toastMessage, attribute: .left, relatedBy: .equal, toItem: toastMessage.superview, attribute: .left, multiplier: 1, constant: 10.0)
    //        let rightConstraint = NSLayoutConstraint(item: toastMessage, attribute: .right, relatedBy: .equal, toItem: toastMessage.superview, attribute: .right, multiplier: 1, constant: -10.0)
    //        appWindow/* which is: toastMessage.superview */.addConstraints([bottomConstraint, leftConstraint, rightConstraint])
    //
    //        let heightConstraint = NSLayoutConstraint(item: toastMessage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 0.3 * max(appWindow.frame.height, appWindow.frame.width))
    //        toastMessage.addConstraint(heightConstraint)
    
}

@end
