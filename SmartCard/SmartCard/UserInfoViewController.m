//
//  UserInfoViewController.m
//  SmartCard
//
//  Created by Arun Jaiswal on 29/05/17.
//  Copyright © 2017 Arun Jaiswal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoViewController.h"
#import "Constant.h"

@implementation UserInfoViewController: UIViewController

//-(void)viewDidLoad
//{
//    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//    cardno.text =[ud stringForKey:@"cardno"];
//    balance.text =[ud stringForKey:@"balance"];
//    username.text = [NSString stringWithFormat:@"%@ %@", [ud stringForKey:@"fname"], [ud stringForKey:@"lname"]];
//}

-(void)viewWillAppear:(BOOL)animated
{
    loadView = 0;
    userdefault = [NSUserDefaults standardUserDefaults];
    cardno.text =[userdefault stringForKey:@"cardno"];
    balance.text =[userdefault stringForKey:@"balance"];
    username.text = [NSString stringWithFormat:@"%@ %@", [userdefault stringForKey:@"fname"], [userdefault stringForKey:@"lname"]];
 
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",BASE_URL,GET_BALANCE,[userdefault stringForKey:@"cardno"]]]];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

- (IBAction)AddMoneyButtonAction:(id)sender {
    loadView = 0;
}

- (IBAction)TravelHistoryButtonAction:(id)sender {
    loadView = 1;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSLog(@"%@",[NSString stringWithFormat:@"%@%@cardno=%@",BASE_URL,TRIP_DETAIL,[userdefault stringForKey:@"cardno"]]);
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@cardno=%@",BASE_URL,TRIP_DETAIL,[userdefault stringForKey:@"cardno"]]]];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

- (IBAction)TravelCardSimulation:(id)sender {
    loadView = 2;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",TALK_BACK]]];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [NSURLConnection connectionWithRequest:request delegate:self];
    
}

- (IBAction)SignOut:(id)sender {
    loadView = 3;
}

-(void)travelHistoryView{
    
    [self performSegueWithIdentifier:@"travelhistory" sender:self];
}

-(void)talkBackView{
    [self performSegueWithIdentifier:@"talkback" sender:self];
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
    NSError *error;
    NSArray *json = [NSJSONSerialization JSONObjectWithData:_responseData options:kNilOptions error:&error];
    if (json.count>0 && loadView == 1) {
        [userdefault setObject:json forKey:@"travelhistorydata"];
        [self travelHistoryView];
    }
    else if (loadView == 0)
    {
        NSLog(@"Getting Balance :: %@",[json valueForKey:@"balance"]);
        [userdefault setObject:[NSString stringWithFormat:@"%@",[[json objectAtIndex:0] valueForKey:@"balance"]] forKey:@"balance"];
        balance.text = [NSString stringWithFormat:@"%@",[[json objectAtIndex:0] valueForKey:@"balance"]];
        [userdefault synchronize];
    }
    else if(loadView == 2)
    {
        [userdefault setObject:[NSString stringWithFormat:@"%@",[json objectAtIndex:0]] forKey:@"welcomemsg"];
        [userdefault synchronize];
        [self talkBackView];
    }

    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
}


@end
