//
//  ViewController.m
//  ohako_sample
//
//  Created by Dodo Kento on 2014/01/05.
//  Copyright (c) 2014年 Dodo Kento. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    UIImagePickerController *ipc;
    IBOutlet UIImageView *iv;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)push:(id)sender {
    ipc=[[UIImagePickerController alloc] init];
    ipc.delegate=self;
    ipc.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.allowsEditing=YES;
    [self presentViewController:ipc animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    iv.image=image;
    NSLog(@"%@",[ViewController sendImage:image]);
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)targetImage:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)context{
    NSLog(@"?????");
}

+(NSString*)sendImage:(UIImage*)image
{
	NSData* imgData=[[NSData alloc] initWithData:UIImagePNGRepresentation([UIImage imageWithCGImage:[image CGImage]])];
//	NSString *mail = @"test@gmail.com";
	
	NSURL *cgiUrl = [NSURL URLWithString:@"http://web.sfc.keio.ac.jp/~t12552kd/send_image.php"];
	NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:cgiUrl];
	
	//adding header information:
	[postRequest setHTTPMethod:@"POST"];
	
	NSString *stringBoundary = @"0xKhTmLbOuNdArY";
	NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",stringBoundary];
	[postRequest addValue:contentType forHTTPHeaderField: @"Content-Type"];
	
	
	//setting up the body:
	NSMutableData *postBody = [NSMutableData data];
	[postBody appendData:[[NSString stringWithFormat:@"--%@\r\n",stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
//	[postBody appendData:[@"Content-Disposition: form-data; name=\"email\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//	[postBody appendData:[mail dataUsingEncoding:NSUTF8StringEncoding]];
//	[postBody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    NSString *fileName=[NSString stringWithFormat:@"%@.png",[ViewController createFileName]];
    NSString *conData=[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",@"image",fileName];
	[postBody appendData:[conData dataUsingEncoding:NSUTF8StringEncoding]];
	[postBody appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
	[postBody appendData:imgData];
	[postBody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
	[postRequest setHTTPBody:postBody];
    
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
