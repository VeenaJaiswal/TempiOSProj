//
//  LoginViewController.h
//  SmartCard
//
//  Created by Arun Jaiswal on 29/05/17.
//  Copyright © 2017 Arun Jaiswal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
{
    __weak IBOutlet UITextField *username;
    __weak IBOutlet UITextField *password;
    __weak IBOutlet UILabel *failuretextfield;
    NSMutableData *_responseData;
    NSUserDefaults *userDefaultData;
}
- (IBAction)LoginButtonAction:(id)sender;

@end
