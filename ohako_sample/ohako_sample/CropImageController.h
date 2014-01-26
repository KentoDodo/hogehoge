//
//  CropImageController.h
//  ohako_sample
//
//  Created by Dodo Kento on 2014/01/26.
//  Copyright (c) 2014年 Dodo Kento. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CropImageControllerDelegate
-(void)set_cropImage:(UIImage*)cropImage originalImage:(UIImage*)originalImage;
@end

@interface CropImageController : UIViewController<UIScrollViewDelegate> {
    UIImage* image;
}

@property (nonatomic,retain) id CropImageControllerDelegate;
@property (nonatomic,retain) UIImage *image;

@end
