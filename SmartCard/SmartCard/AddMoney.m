//
//  AddMoney.m
//  SmartCard
//
//  Created by Arun Jaiswal on 30/05/17.
//  Copyright © 2017 Arun Jaiswal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddMoney.h"
#import "Constant.h"

@implementation AddMoney: UIViewController

-(void)viewWillAppear:(BOOL)animated
{
    ud = [NSUserDefaults standardUserDefaults];
    currentBalance.text = [ud stringForKey:@"balance"];
}

- (IBAction)AddMoneyButtonAction:(id)sender {
    
    NSMutableDictionary *formDataDic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[ud stringForKey:@"username"],@"username",addmoney.text,@"amount", nil];
    NSData *postData = [NSJSONSerialization dataWithJSONObject:formDataDic
                                                       options:NSJSONReadingAllowFragments
                                                         error:nil];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,ADD_MONEY]]];
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
    
    NSDictionary *jsonDict = [[NSJSONSerialization JSONObjectWithData:_responseData options:kNilOptions error:nil] objectAtIndex:0];
    [ud setObject:[jsonDict objectForKey:@"balance"] forKey:@"balance"];
    [ud synchronize];
    currentBalance.text = [ud stringForKey:@"balance"];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
}

@end
