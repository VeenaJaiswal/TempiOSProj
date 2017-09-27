//
//  TravelHistoryViewController.h
//  SmartCard
//
//  Created by Arun Jaiswal on 30/05/17.
//  Copyright © 2017 Arun Jaiswal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TravelHistoryViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSArray * tableData;
    NSUserDefaults *userDefault;
}

@end
