//
//  CustomTableCell.h
//  SmartCard
//
//  Created by Arun Jaiswal on 30/05/17.
//  Copyright © 2017 Arun Jaiswal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableCell : UITableViewCell

@property (weak)IBOutlet UILabel *source;
@property (weak)IBOutlet UILabel *destination;
@property (weak)IBOutlet UILabel *distance;
@property (weak)IBOutlet UILabel *date;

@end
