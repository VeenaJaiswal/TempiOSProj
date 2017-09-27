//
//  RegistrationViewController.m
//  SmartCard
//
//  Created by Arun Jaiswal on 29/05/17.
//  Copyright © 2017 Arun Jaiswal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constant.h"

#import "RegistrationViewController.h"
#import "UserInfoViewController.h"

@implementation RegistrationViewController : UIViewController

- (IBAction)SignupButtonAction:(id)sender {
    
    NSMutableDictionary *formDataDic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:fname.text,@"fname",lname.text,@"lname",username.text,@"username",dob.text,@"bdate",email.text,@"email",mobileno.text,@"mobile",password.text,@"password", nil];

    NSData *postData = [NSJSONSerialization dataWithJSONObject:formDataDic
                                                           options:NSJSONReadingAllowFragments
                                                             error:nil];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,REGISTER]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    [NSURLConnection connectionWithRequest:request delegate:self];
    
}

-(void)callSegie{
    UIViewController * viewController =[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"homeidentifier"];
    
    if ([self presentedViewController]) {
        [[self presentedViewController] dismissViewControllerAnimated:NO completion:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:viewController animated:YES completion:nil];
            });
        }];
    } else {
        [self presentViewController:viewController animated:YES completion:nil];
        
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
    if ([respsoneString isEqualToString:@"success"]) {
        [self callSegie];
    }

}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
}

@end
