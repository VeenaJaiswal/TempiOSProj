//
//  UserInfoViewController.h
//  SmartCard
//
//  Created by Arun Jaiswal on 29/05/17.
//  Copyright © 2017 Arun Jaiswal. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface UserInfoViewController : UIViewController
{
    __weak IBOutlet UILabel *cardno;
    __weak IBOutlet UILabel *balance;
    __weak IBOutlet UILabel *username;
    NSMutableData * _responseData;
    int loadView;
    NSUserDefaults *userdefault;
}

- (IBAction)AddMoneyButtonAction:(id)sender;
- (IBAction)TravelHistoryButtonAction:(id)sender;
- (IBAction)TravelCardSimulation:(id)sender;
- (IBAction)SignOut:(id)sender;

@end
