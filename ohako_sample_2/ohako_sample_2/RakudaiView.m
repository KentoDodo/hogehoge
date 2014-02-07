//
//  RakudaiView.m
//  ohako_sample_2
//
//  Created by Dodo Kento on 2014/02/07.
//  Copyright (c) 2014年 Dodo Kento. All rights reserved.
//

#import "RakudaiView.h"

@implementation RakudaiView

@synthesize label,pv;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


- (void)awakeFromNib{
    NSLog(@"awakeFromNib");
}


-(void)didMoveToSuperview {
    NSLog(@"didMoveToSuperview");
}

// 0-100
-(void)setValue:(int)value {
    label.text=[NSString stringWithFormat:@"%d",value];
    pv.progress=value/100.0;
}

@end
