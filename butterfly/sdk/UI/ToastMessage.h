//
//  ToastMessage.h
//  butterfly
//
//  Created by Aviel on 11/11/20.
//  Copyright © 2020 Aviel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^ToastCallback)(void);

@interface ToastMessage : UIView

+(void) show:(NSString *_Nonnull) messageText delayInSeconds:(NSTimeInterval) delay onDone:(nullable void (^)(void)) callback;

@property (nonatomic, strong) UILabel * _Nonnull messageLabel;
@property (nonatomic, assign) NSTimeInterval delay;
@property (nonatomic, assign) ToastCallback _Nullable callback;


@end
