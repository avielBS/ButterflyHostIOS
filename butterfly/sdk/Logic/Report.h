//
//  Report.h
//  butterfly
//
//  Created by Aviel on 9/30/20.
//  Copyright © 2020 Aviel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Report : NSObject

@property (nonatomic,strong)  NSString *comments;
@property (nonatomic,strong)    NSString *wayContact;
@property (nonatomic,strong)    NSString *fakePlace;
@property (nonatomic,strong)    NSString *message;
@property (nonatomic,strong)      NSString *country;

- (void) printReport;

@end
