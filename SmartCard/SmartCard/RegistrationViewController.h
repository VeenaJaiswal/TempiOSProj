//
//  RegistrationViewController.h
//  SmartCard
//
//  Created by Arun Jaiswal on 29/05/17.
//  Copyright © 2017 Arun Jaiswal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistrationViewController : UIViewController <NSURLConnectionDelegate>
{
    __weak IBOutlet UITextField *fname;
    __weak IBOutlet UITextField *lname;
    __weak IBOutlet UITextField *username;
    __weak IBOutlet UITextField *dob;
    __weak IBOutlet UITextField *email;
    __weak IBOutlet UITextField *mobileno;
    __weak IBOutlet UITextField *password;
    __weak IBOutlet UITextField *cnfpassword;
    NSMutableData *_responseData;
    
}
- (IBAction)SignupButtonAction:(id)sender;


@end
