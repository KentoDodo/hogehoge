//
//  ViewController.m
//  ohako_sample
//
//  Created by Dodo Kento on 2014/01/05.
//  Copyright (c) 2014年 Dodo Kento. All rights reserved.
//

#import "ViewController.h"
#import "CropImageController.h"

@interface ViewController () {
    UIImagePickerController *ipc;
    UIImageView *iv;
    
    CropImageController *cropController;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    iv=[[UIImageView alloc] init];
    [self.view addSubview:iv];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    NSLog(@"%lu",(unsigned long)[navigationController.viewControllers indexOfObject:viewController]);
//    if ([navigationController.viewControllers indexOfObject:viewController]==2) {
//        NSArray *cropOverlayViews=[(UIView*)[[viewController.view subviews] objectAtIndex:1] subviews];
//        NSLog(@"views = %@",cropOverlayViews);
//        NSArray *viewsToRemove = cropOverlayViews;
//        [[viewsToRemove objectAtIndex:0] removeFromSuperview];
//    }
//}

-(IBAction)push:(id)sender {
    ipc=[[UIImagePickerController alloc] init];
    ipc.delegate=self;
    ipc.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.allowsEditing=NO;
    [self presentViewController:ipc animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary*)info {
    UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];
    
    cropController=[[CropImageController alloc] init];
    cropController.image=image;
    
    [picker pushViewController:cropController animated:YES];
}

-(void)targetImage:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)context{
    NSLog(@"?????");
}

@end
