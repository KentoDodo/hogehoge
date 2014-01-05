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
    NSLog(@"!!!!!");
    iv.image=image;
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)targetImage:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)context{
    NSLog(@"?????");
}

@end
