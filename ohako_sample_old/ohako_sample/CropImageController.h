//
//  CropImageController.h
//  ohako_sample
//
//  Created by Dodo Kento on 2014/01/26.
//  Copyright (c) 2014年 Dodo Kento. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CropImageController : UIViewController<UIScrollViewDelegate> {
    UIImage* image;
}

@property (nonatomic,retain) UIImage *image;

@end
