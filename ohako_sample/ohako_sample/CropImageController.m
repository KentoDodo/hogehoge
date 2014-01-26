//
//  CropImageController.m
//  ohako_sample
//
//  Created by Dodo Kento on 2014/01/26.
//  Copyright (c) 2014年 Dodo Kento. All rights reserved.
//

#import "CropImageController.h"
#import <QuartzCore/QuartzCore.h>

const int crop_w=300;
const int crop_h=420;

@interface CropImageController () {
    UIScrollView *scrollview;
    UIImageView *imageview;
    
    UIView *cropview;
    CGRect crop_rect;
}

@end

@implementation CropImageController

@synthesize CropImageControllerDelegate,image;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout=UIRectEdgeNone;
    
    self.view.backgroundColor=[UIColor blackColor];
    
    crop_rect=CGRectMake((self.view.frame.size.width-crop_w)/2,(self.view.frame.size.height-64-crop_h)/2,crop_w,crop_h);
    
    scrollview=[[UIScrollView alloc] initWithFrame:crop_rect];
    scrollview.minimumZoomScale=scrollview.frame.size.width/image.size.width;
    scrollview.maximumZoomScale=1.0;
    scrollview.contentSize=image.size;
    scrollview.delegate=self;
    scrollview.backgroundColor=[UIColor blackColor];
    scrollview.layer.masksToBounds=NO;
    [self.view addSubview:scrollview];
    
    [self.view addSubview:[self get_semiAlphaView:CGRectMake(0,0,self.view.frame.size.width,crop_rect.origin.y)]];
    [self.view addSubview:[self get_semiAlphaView:CGRectMake(0,crop_rect.origin.y+crop_rect.size.height,self.view.frame.size.width,self.view.frame.size.height-(crop_rect.origin.y+crop_rect.size.height))]];
    [self.view addSubview:[self get_semiAlphaView:CGRectMake(0,crop_rect.origin.y,crop_rect.origin.x,crop_rect.size.height)]];
    [self.view addSubview:[self get_semiAlphaView:CGRectMake(crop_rect.origin.x+crop_rect.size.width,crop_rect.origin.y,self.view.frame.size.width-(crop_rect.origin.x+crop_rect.size.width),crop_rect.size.height)]];
    
    imageview=[[UIImageView alloc] initWithImage:image];
    imageview.frame=CGRectMake(0,0,image.size.width,image.size.height);
    [scrollview addSubview:imageview];
    
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(end)];
    self.navigationItem.rightBarButtonItem=rightButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)end {
    CGFloat scale=scrollview.zoomScale;
    CGRect rect=CGRectMake((int)((scrollview.contentOffset.x)/scale),(int)((scrollview.contentOffset.y)/scale),(int)(crop_w/scale),(int)(crop_h/scale));
    NSLog(@"(x,y,w,h)=(%d,%d,%d,%d)",(int)(rect.origin.x),(int)(rect.origin.y),(int)(rect.size.width),(int)(rect.size.height));
    [CropImageControllerDelegate set_cropImage:[CropImageController getCutResizedImage:image rect:rect] originalImage:image];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(UIView*)get_semiAlphaView:(CGRect)frame {
    UIView *view=[[UIView alloc] initWithFrame:frame];
    view.backgroundColor=[UIColor blackColor];
    view.alpha=0.5;
    return view;
}

-(UIView*)viewForZoomingInScrollView:(UIScrollView*)scrollView {
    return imageview;
}

+(UIImage*)getCutResizedImage:(UIImage*)image rect:(CGRect)rect {
    UIImage *trim_image;
    UIGraphicsBeginImageContext(rect.size);
    [image drawAtPoint:CGPointMake(-rect.origin.x,-rect.origin.y)];
    trim_image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return trim_image;
}

@end
