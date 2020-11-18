//
//  ViewController.m
//  butterfly
//
//  Created by Aviel on 9/29/20.
//  Copyright © 2020 Aviel. All rights reserved.
//

#import "ViewController.h"


@implementation ViewController

NSString* key = @"key1";

int x = 1;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"loaded");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)printButton:(id)sender {
    NSLog(@"button pressed  %d",x);
    
    x++;
    ButterflyHostController* butterflyHost = [[ButterflyHostController alloc] init];
    [butterflyHost OnGrabReportRequeste:self andKey:@"key1"];
    
}
    @end
    
