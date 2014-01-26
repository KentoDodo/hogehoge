//
//  Connect.m
//  ohako_sample
//
//  Created by Dodo Kento on 2014/01/26.
//  Copyright (c) 2014年 Dodo Kento. All rights reserved.
//

#import "Connect.h"

@implementation Connect

+(NSString*)sendImage:(UIImage*)image
{
	NSData* imgData=[[NSData alloc] initWithData:UIImagePNGRepresentation([UIImage imageWithCGImage:[image CGImage]])];
    //	NSString *mail = @"test@gmail.com";
	
	NSURL *cgiUrl = [NSURL URLWithString:@"http://web.sfc.keio.ac.jp/~t12552kd/send_image.php"];
    //    NSURL *cgiUrl = [NSURL URLWithString:@"https://api.shakring.com/api/1.0/ja/image?token=CAACxIgOYrR8BAAT9xVTKqSE8oeFkEOHqRiJkJkR1OPH7Sve0KXZC4szzGGPk0gztCCM0DAYaQTu8D5ZCHAJoQux2SYWoXYAY3Pjgi5fRUl5vPhpCz7AV1Oglo6ZC9IJn5DnkTZADP7LHW7g5ziUnQted6DSQxccWFtMx4wC7GkOriLvJzACnZAqEiHNiL4ZCdCMjkPkUOAbgZDZD"];
	NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:cgiUrl];
	
	//adding header information:
	[postRequest setHTTPMethod:@"POST"];
	
	NSString *stringBoundary = @"0xKhTmLbOuNdArY";
	NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",stringBoundary];
	[postRequest addValue:contentType forHTTPHeaderField: @"Content-Type"];
	
	
	//setting up the body:
	NSMutableData *postBody = [NSMutableData data];
    // 名前
    [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n",stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"name"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[@"Jane" dataUsingEncoding:NSUTF8StringEncoding]];
    // メール
	[postBody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"mail"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[@"hogehoge@piyo.com" dataUsingEncoding:NSUTF8StringEncoding]];
    // 画像部分
	[postBody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    NSString *imageName=@"image";
    NSString *imageFileName=[NSString stringWithFormat:@"%@.png",[self createFileName]];
    NSString *conData=[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",imageName,imageFileName];
	[postBody appendData:[conData dataUsingEncoding:NSUTF8StringEncoding]];
	[postBody appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
	[postBody appendData:imgData];
	[postBody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
	[postRequest setHTTPBody:postBody];
    
    //    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    //    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate:self delegateQueue: [NSOperationQueue mainQueue]];
    //    NSURLSessionDataTask *dataTask=[defaultSession dataTaskWithRequest:postRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
    //        NSLog(@"data=%@",data);
    //    }];
    //    return nil;
    
    NSError *error=nil;
    NSData *response=[NSURLConnection sendSynchronousRequest:postRequest returningResponse:nil error:&error];
    if (error) {
        NSLog(@"error to send image.");
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Communication error" message:@"Communication error...\nYou can enable wifi function." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return nil;
    } else if (!response) {
        NSLog(@"failed to send image.");
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Communication error" message:@"Communication failed...\nYou can enable wifi function." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return nil;
    }
    if (!response) return nil;
    return [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
}

+(NSString*)createFileName {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY_MM_dd_HH:mm:ss"];
    NSDate* date = [NSDate date];
    return [formatter stringFromDate:date];
}

@end
