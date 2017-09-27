//
//  AddMoney.h
//  SmartCard
//
//  Created by Arun Jaiswal on 30/05/17.
//  Copyright © 2017 Arun Jaiswal. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface AddMoney : UIViewController
{
    __weak IBOutlet UITextField *addmoney;
    __weak IBOutlet UILabel *currentBalance;
    NSMutableData *_responseData;
    NSUserDefaults *ud;
    
}
- (IBAction)AddMoneyButtonAction:(id)sender;
@end
