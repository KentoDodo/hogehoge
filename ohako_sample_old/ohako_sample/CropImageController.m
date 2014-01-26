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
    UIView *contentview;
    UIImageView *imageview;
    
    CGRect crop_rect;
}

@end

@implementation CropImageController

@synthesize image;

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
    
    scrollview=[[UIScrollView alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height-64)];
    scrollview.minimumZoomScale=(image.size.width/image.size.height<crop_w/crop_h)?crop_w/image.size.width:crop_h/image.size.height;
    scrollview.maximumZoomScale=1.0;
    scrollview.delegate=self;
    scrollview.backgroundColor=[UIColor clearColor];
    [self.view addSubview:scrollview];
    
    crop_rect=CGRectMake((scrollview.frame.size.width-crop_w)/2,(scrollview.frame.size.height-crop_h)/2,crop_w,crop_h);
    
    [self.view addSubview:[self get_semiAlphaView:CGRectMake(0,0,self.view.frame.size.width,crop_rect.origin.y)]];
    [self.view addSubview:[self get_semiAlphaView:CGRectMake(0,crop_rect.origin.y+crop_rect.size.height,self.view.frame.size.width,self.view.frame.size.height-(crop_rect.origin.y+crop_rect.size.height))]];
    [self.view addSubview:[self get_semiAlphaView:CGRectMake(0,crop_rect.origin.y,crop_rect.origin.x,crop_rect.size.height)]];
    [self.view addSubview:[self get_semiAlphaView:CGRectMake(crop_rect.origin.x+crop_rect.size.width,crop_rect.origin.y,self.view.frame.size.width-(crop_rect.origin.x+crop_rect.size.width),crop_rect.size.height)]];
    
    contentview=[[UIView alloc] initWithFrame:CGRectMake(0,0,crop_rect.origin.x*2+image.size.width,crop_rect.origin.y*2+image.size.height)];
    contentview.backgroundColor=[UIColor clearColor];
    scrollview.contentSize=contentview.frame.size;
    [scrollview addSubview:contentview];
    
    imageview=[[UIImageView alloc] initWithImage:image];
    imageview.frame=CGRectMake(crop_rect.origin.x,crop_rect.origin.y,image.size.width,image.size.height);
    [contentview addSubview:imageview];
    
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
    NSLog(@"(x,y,w,h)=(%d,%d,%d,%d)",(int)((scrollview.contentOffset.x)/scale),(int)((scrollview.contentOffset.y)/scale),(int)(crop_w/scale),(int)(crop_h/scale));
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(UIView*)get_semiAlphaView:(CGRect)frame {
    UIView *view=[[UIView alloc] initWithFrame:frame];
    view.backgroundColor=[UIColor blackColor];
    view.alpha=0.5;
    return view;
}

-(UIView*)viewForZoomingInScrollView:(UIScrollView*)scrollView {
    return contentview;
}

+(UIImage*)getResizedImage:(UIImage*)image rect:(CGRect)rect {
	if (UIGraphicsBeginImageContextWithOptions != NULL) {
		UIGraphicsBeginImageContextWithOptions(CGSizeMake(rect.size.width,rect.size.height),NO,[[UIScreen mainScreen] scale]);
	} else {
		UIGraphicsBeginImageContext(CGSizeMake(rect.size.width,rect.size.height));
	}
    
	CGContextRef context=UIGraphicsGetCurrentContext();
	CGContextSetInterpolationQuality(context,kCGInterpolationHigh);
	[image drawInRect:rect];
    
	UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    
	UIGraphicsEndImageContext();
    
	return resizedImage;
}

@end
