//
//  RakudaiView.h
//  ohako_sample_2
//
//  Created by Dodo Kento on 2014/02/07.
//  Copyright (c) 2014年 Dodo Kento. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RakudaiView : UIView {
    IBOutlet UILabel *label;
    IBOutlet UIProgressView *pv;
}

@property (nonatomic,retain) IBOutlet UILabel *label;
@property (nonatomic,retain) IBOutlet UIProgressView *pv;

-(void)setValue:(int)value;

@end
