//
//  TalkBackViewController.h
//  SmartCard
//
//  Created by Arun Jaiswal on 30/05/17.
//  Copyright © 2017 Arun Jaiswal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TalkBackViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray * tableData;
    NSMutableDictionary *talkBackDictionary;
    NSMutableData *_responseData;
    __weak IBOutlet UITextView *TalkBacktextField;
    __weak IBOutlet UITableView *talkBacktableView;
    
    NSMutableArray *msgSentArray;
    NSMutableArray *msgReplyArray;
    NSUserDefaults *userdefault;
    
}
- (IBAction)TalkBackSentButtonAction:(id)sender;

@end
