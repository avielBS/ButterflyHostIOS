//
//  InputFromUser.m
//  first
//
//  Created by Aviel on 10/9/20.
//  Copyright © 2020 Aviel. All rights reserved.
//

#import "InputFromUser.h"


@implementation InputFromUser



//- (void)takeTextFromUserWithTitle:(NSString *)title body:(NSString *)body andPlaceHolder:(NSString *)placeHolder cancelTitle:(NSString *) cancelTitle onDone:(void (^)(NSString *))completion {
//    if (!completion) return;
//
//    if (![title length]) {
//        title = @"More details";
//    }
//
//    if (![body length]) {
//        body = @"Fill in the details";
//    }
//
//    if (![placeHolder length]) {
//        placeHolder = @"your insights...";
//    }
//
//    if (![cancelTitle length]) {
//        cancelTitle = @"Cancel...";
//    }
//
//    UIAlertController* alertController = [UIAlertController alertControllerWithTitle: title message: body preferredStyle: UIAlertControllerStyleAlert];
//
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle: cancelTitle style: UIAlertActionStyleCancel handler: nil];
//    [alertController addAction: cancelAction];
//
//    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
//        textField.placeholder = placeHolder;
//    }];
//
//    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
//        textField.placeholder = @"second holder";
//    }];
//
//    __weak UIAlertController *weakAlertController = alertController;
//    [alertController addAction: [UIAlertAction actionWithTitle: @"Send..." style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        //[[CrashOps shared] logError: @{@"type":@"issue"}];
//        NSString *userInput = [[[weakAlertController textFields] firstObject] text];
//
//        if (![userInput length]) {
//            userInput = @"";
//        }
//
//        completion(userInput);
//    }]];
//
//    UIViewController *topViewController = [self mostTopViewController: [[[UIApplication sharedApplication] keyWindow] rootViewController]];
//    [topViewController presentViewController: alertController animated: YES completion:^{
//        // ok...
//    }];
//}
//
//-(UIViewController *) mostTopViewController: (UIViewController *) ofViewController {
//    UIViewController *presentedViewController = [ofViewController presentedViewController];
//    if (presentedViewController == nil) {
//        return ofViewController;
//    }
//
//    return [self mostTopViewController: presentedViewController];
//}


- (void) getUserInput : (UIViewController*)viewController onDone:(void(^)(NSString* , NSString* , NSString*))completion
{

    
    //
//    [self takeTextFromUserWithTitle:@"one" body:@"two"  andPlaceHolder:@"three"  cancelTitle:@"four"  onDone:^(NSString* response) {
//        NSLog(@"%@", response);
//    }];
    //
    
    
    
    
//    [self takeTextFromUserWithTitle @"one" body:@"two" andPlaceHolder:@"three" cancelTitle:@"cancle" onDone:{
//
//    }];
    
    NSString* message = @"1.How and When can we contact you?\n2.Do you want contact from fake place?\n3.comments";

    
    _alertController = [UIAlertController alertControllerWithTitle: @"Contact"
                                                                              message: message
                                                               preferredStyle:UIAlertControllerStyleAlert
                                           ];


    [_alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"e.g. Phone , Email ... before 12 AM";
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];
    [_alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"e.g. laundromat";
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];
    [_alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"do not call after 5 PM";
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];
    //when OK buuton pressed
    
    [_alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSArray * textfields = _alertController.textFields;
        UITextField * wayContactField = textfields[0];
        UITextField * fakePlaceField = textfields[1];
        UITextField * commentsField = textfields[2];
        
  //      NSString * data = [NSString stringWithFormat: @"name : %@ password: %@",namefield.text,passwordfiled.text];
         completion(wayContactField.text,fakePlaceField.text,commentsField.text);

    }]];
    [_alertController addAction:[UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [_alertController dismissViewControllerAnimated:true completion:nil];
    }]];
    
    
    _alertController.actions[0].enabled = false;
    
    [_alertController.textFields[0] addTarget:self
                                      action:@selector(wayToContactFieldChanged) forControlEvents:UIControlEventEditingChanged];
    
    [viewController presentViewController:_alertController animated:YES completion:^{
        _alertController.view.superview.userInteractionEnabled = YES;
        [_alertController.view.superview addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(whenTappedOutside)]];
    }];


}

-(void) wayToContactFieldChanged
{
    if ([_alertController.textFields[0] hasText]) {
        _alertController.actions[0].enabled = YES;
    }
    else
        _alertController.actions[0].enabled = NO;

}

-(void) whenTappedOutside
{
    NSLog(@"whenTappedOutside");
    [_alertController dismissViewControllerAnimated:true completion:nil];}


@end
