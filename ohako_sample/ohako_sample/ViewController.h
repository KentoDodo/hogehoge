//
//  ViewController.h
//  ohako_sample
//
//  Created by Dodo Kento on 2014/01/05.
//  Copyright (c) 2014年 Dodo Kento. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CropImageController.h"

@interface ViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,CropImageControllerDelegate,NSURLSessionDelegate>

@end
