//
//  ViewController.m
//  ohako_sample_2
//
//  Created by Dodo Kento on 2014/02/07.
//  Copyright (c) 2014年 Dodo Kento. All rights reserved.
//

#import "ViewController.h"
#import "RakudaiView.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController () {
    IBOutlet UILabel *label;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    label.text=[NSString stringWithFormat:@"現在の落第者数は%d人です",24];
//    label.layer.masksToBounds=YES;
//    label.layer.borderWidth=1;
    label.layer.borderColor=[[UIColor blackColor] CGColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)exit:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"source=%@,destionation=%@",[segue sourceViewController],[segue destinationViewController]);
}

@end
