//
//  InputFromUser.m
//  butterfly
//
//  Created by Aviel on 10/9/20.
//  Copyright © 2020 Aviel. All rights reserved.
//

#import "InputFromUser.h"


@implementation InputFromUser


- (void) getUserInput : (UIViewController*)viewController onDone:(void(^)(NSString* , NSString* , NSString*))completion
{

//    NSString* message = @"Feel free to send here whatever crosses your mind.The information that is sent remains secret without leaving a trail.We take serious consideration and won't take any reckless desicions.Good luck!";

    NSString* message = NSLocalizedString(@"butterfly_host_report_meesage", @"the report message");
    _alertController = [UIAlertController alertControllerWithTitle: NSLocalizedString(@"butterfly_host_contact", @"report title")
                                                                              message: message
                                                               preferredStyle:UIAlertControllerStyleAlert
                                           ];

    [_alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = NSLocalizedString(@"butterfly_host_way_to_contact", @"way to contact hint");
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];
    [_alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = NSLocalizedString(@"butterfly_host_fake_place", @"fake place hint");
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];
    [_alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = NSLocalizedString(@"butterfly_host_comments", @"comments hint");
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];
    //when OK buuton pressed
    
    [_alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"butterfly_host_send", @"send btn text") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSArray * textfields = _alertController.textFields;
        UITextField * wayContactField = textfields[0];
        UITextField * fakePlaceField = textfields[1];
        UITextField * commentsField = textfields[2];
        
         completion(wayContactField.text,fakePlaceField.text,commentsField.text);

    }]];
    [_alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"butterfly_host_cancel", @"cancel btn text") style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
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
