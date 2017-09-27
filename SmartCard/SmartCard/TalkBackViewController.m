//
//  TalkBackViewController.m
//  SmartCard
//
//  Created by Arun Jaiswal on 30/05/17.
//  Copyright © 2017 Arun Jaiswal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TalkBackViewController.h"
#import "TalkBackCustomCell.h"
#import "Constant.h"


@implementation TalkBackViewController: UIViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    talkBackDictionary = [NSMutableDictionary new];
    tableData = [NSMutableArray new];
    [talkBackDictionary setValue:@"Hello I am Watson to Smart Travel. How may I help ?" forKey:@"reply"];
    [tableData addObject:talkBackDictionary];
    
    userdefault = [NSUserDefaults standardUserDefaults];
    msgSentArray = [NSMutableArray new];
    msgReplyArray = [NSMutableArray new];
    [msgReplyArray addObject:[userdefault objectForKey:@"welcomemsg"]];
    
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"TalkBackCustomCell";
    
    TalkBackCustomCell *cell = (TalkBackCustomCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TalkBackCustomCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    if (TalkBacktextField.text.length>0) {
        cell.sentmsg.text = [[tableData objectAtIndex:indexPath.row] objectForKey:@"sent"];
    }
    
    cell.replymsg.text = [[tableData objectAtIndex:indexPath.row] objectForKey:@"reply"];
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 116;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

-(void)reloadTableViewdata
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [talkBacktableView reloadData];
    });

}

- (IBAction)TalkBackSentButtonAction:(id)sender {
    [talkBackDictionary setValue:TalkBacktextField.text forKey:@"sent"];
    
    NSMutableDictionary *formDataDic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:TalkBacktextField.text,@"text",nil];
    NSData *postData = [NSJSONSerialization dataWithJSONObject:formDataDic
                                                       options:NSJSONReadingAllowFragments
                                                         error:nil];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",TALK_BACK]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    _responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    return nil;
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSString* respsoneString = [NSString stringWithUTF8String:[_responseData bytes]];
    [talkBackDictionary setObject:TalkBacktextField.text forKey:@"sent"];
    
    NSDictionary *tempDict = [[NSDictionary alloc]initWithObjectsAndKeys:TalkBacktextField.text,@"sent",respsoneString,@"reply", nil];
    
    [tableData addObject:tempDict];
    [self reloadTableViewdata];
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
}


@end
