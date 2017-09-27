//
//  TravelHistoryViewController.m
//  SmartCard
//
//  Created by Arun Jaiswal on 30/05/17.
//  Copyright © 2017 Arun Jaiswal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TravelHistoryViewController.h"
#import "CustomTableCell.h"


@implementation TravelHistoryViewController: UIViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    userDefault = [NSUserDefaults standardUserDefaults];
    tableData = [userDefault objectForKey:@"travelhistorydata"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"CustomTableCell";
    
    CustomTableCell *cell = (CustomTableCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.source.text = [[tableData objectAtIndex:indexPath.row] objectForKey:@"startpt"];
    cell.destination.text = [[tableData objectAtIndex:indexPath.row] objectForKey:@"endpt"];
    cell.distance.text = [NSString stringWithFormat:@"%@ KM",[[tableData objectAtIndex:indexPath.row] objectForKey:@"distance"]] ;
    cell.date.text = [[tableData objectAtIndex:indexPath.row] objectForKey:@"date"];
    
    return cell;

}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}



@end
