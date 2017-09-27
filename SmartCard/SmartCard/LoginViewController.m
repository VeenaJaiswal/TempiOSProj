//
//  LoginViewController.m
//  SmartCard
//
//  Created by Arun Jaiswal on 29/05/17.
//  Copyright © 2017 Arun Jaiswal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constant.h"
#import "LoginViewController.h"

@implementation LoginViewController: UIViewController

- (IBAction)LoginButtonAction:(id)sender {
    
    userDefaultData = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *formDataDic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:username.text,@"username",password.text,@"password", nil];
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:formDataDic
                                                       options:NSJSONReadingAllowFragments
                                                         error:nil];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,LOGIN]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    [NSURLConnection connectionWithRequest:request delegate:self];

}

-(void)callSegie{
    UIViewController * viewController =[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"userinformation"];
    
    if ([self presentedViewController]) {
        [[self presentedViewController] dismissViewControllerAnimated:NO completion:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:viewController animated:YES completion:nil];
            });
        }];
    } else {
        [self performSegueWithIdentifier:@"userinfo" sender:self];
        
    }
    
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

    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:_responseData options:kNilOptions error:nil];
    [userDefaultData setObject:[jsonDict objectForKey:@"balance"] forKey:@"balance"];
    [userDefaultData setObject:[jsonDict objectForKey:@"cardno"] forKey:@"cardno"];
    [userDefaultData setObject:[jsonDict objectForKey:@"fname"] forKey:@"fname"];
    [userDefaultData setObject:[jsonDict objectForKey:@"lname"] forKey:@"lname"];
    [userDefaultData setObject:[jsonDict objectForKey:@"username"] forKey:@"username"];
    [userDefaultData synchronize];
    if (![respsoneString isEqualToString:@"Failure"]) {
        failuretextfield.text = @"";
        [self callSegie];
    }
    else
        failuretextfield.text = @"Invalid Username or Password";
        
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
}

@end
