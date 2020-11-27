//
//  ButterflyHostController.m
//  butterfly
//
//  Created by Aviel on 11/17/20.
//  Copyright © 2020 Aviel. All rights reserved.
//

#import "ButterflyHostController.h"

@implementation ButterflyHostController

-(void) OnGrabReportRequeste:(UIViewController*) viewController andKey:(NSString*)key
{
    self.viewController = viewController;
    self.key = key;
    
    InputFromUser *getUserInfo = [[InputFromUser alloc] init];
    
    
    [getUserInfo getUserInput : self.viewController onDone:^(NSString * wayContact,NSString* fakePlace,NSString* comments) {
        
        Report *report = [[Report alloc ] init ];
        report.wayContact = wayContact;
        report.fakePlace = fakePlace;
        report.comments = comments;
        [report printReport];
        
        NSLog(@"isNetwokArailable is : %d",[self isNetwokArailable]);
        [self get:@"https://us-central1-butterfly-host.cloudfunctions.net/getGeoLocation" relevantReport:report];
        
    }];
    
    
    
}

-(BOOL) isNetwokArailable
{
    Reachability *_reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus remoteHostStatus = [_reachability currentReachabilityStatus];
    NSString* msg = NSLocalizedString(@"network not avilable", @"network not avilable");
    if (remoteHostStatus == NotReachable) {
        // not reachable
        [ToastMessage show:msg delayInSeconds:3 onDone:nil];
        return NO;
    }
    else{
        return YES;
    }
}

-(void)get:(NSString*) url  relevantReport:(Report*)report
{
    NSMutableURLRequest *request = [NSMutableURLRequest new];
    
    [request setURL:[NSURL URLWithString:url]];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"GET"];
    
    NSString *contentType = [NSString stringWithFormat:@"application/json; charset=utf-8"];
    [request setValue: contentType forHTTPHeaderField:@"Content-Type"];
    [request setValue: @"gzip" forHTTPHeaderField: @"Accept-Encoding"];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config
                                                          delegate:nil
                                                     delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData * _Nullable data,
                                                                NSURLResponse * _Nullable response,
                                                                NSError * _Nullable error) {
                                                NSLog(@"Yay, done! Check for errors in response!");
                                                
                                                NSHTTPURLResponse *asHTTPResponse = (NSHTTPURLResponse *) response;
                                                NSLog(@"The response is: %@", asHTTPResponse);
                                                // set a breakpoint on the last NSLog and investigate the response in the debugger
                                                
                                                // if you get data, you can inspect that, too. If it's JSON, do one of these:
                                                NSDictionary *forJSONObject = [NSJSONSerialization JSONObjectWithData:data
                                                                                                              options:kNilOptions
                                                                                                                error:nil];
                                                
                                                report.country = forJSONObject[@"country"];
                                                [report printReport];
                                                
                                                NSLog(@"One of these might exist - object: %@ \n",forJSONObject[@"country"]);
                                                
                                                [self post:@"https://us-central1-butterfly-host.cloudfunctions.net/sendReport" relevantReport:report];
                                                
                                            }];
    
    
    [task resume];
    
}

-(void)post:(NSString*) url relevantReport:(Report*) report
{
    NSDictionary *jsonBodyDict = @{@"fakePlace":report.fakePlace,@"wayContact":report.wayContact,@"country":report.country,@"comments":report.comments};
    NSData *jsonBodyData = [NSJSONSerialization dataWithJSONObject:jsonBodyDict options:kNilOptions error:nil];
    
    NSMutableURLRequest *request = [NSMutableURLRequest new];
    request.HTTPMethod = @"POST";
    
    [request setURL:[NSURL URLWithString:url]];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:jsonBodyData];
    //adding the api key to header
    [request addValue:self.key forHTTPHeaderField:@"BUTTERFLY_HOST_API_KEY"];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config
                                                          delegate:nil
                                                     delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData * _Nullable data,
                                                                NSURLResponse * _Nullable response,
                                                                NSError * _Nullable error) {
                                                NSLog(@"Yay, done! Check for errors in response!");
                                                
                                                NSHTTPURLResponse *asHTTPResponse = (NSHTTPURLResponse *) response;
                                                NSLog(@"The response is: %@", asHTTPResponse);
                                                // set a breakpoint on the last NSLog and investigate the response in the debugger
                                                
                                                // if you get data, you can inspect that, too. If it's JSON, do one of these:
                                                NSDictionary *forJSONObject = [NSJSONSerialization JSONObjectWithData:data
                                                                                                              options:kNilOptions
                                                                                                                error:nil];
                                                
                                                NSLog(@"One of these might exist - object: %@ \n",forJSONObject);
                                                
                                                NSInteger statusCode = ((NSHTTPURLResponse*) response).statusCode;
                                                if (statusCode == 200) {
                                                    [ToastMessage show:@"success" delayInSeconds:3 onDone:nil];
                                                }
                                                else{
                                                    [ToastMessage show:@"failed" delayInSeconds:3 onDone:nil];
                                                }
                                                
                                            }];
    
    
    [task resume];
}

@end
