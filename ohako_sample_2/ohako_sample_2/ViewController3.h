//
//  ViewController3.h
//  ohako_sample_2
//
//  Created by Dodo Kento on 2014/02/07.
//  Copyright (c) 2014年 Dodo Kento. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController3 : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate> {
    NSString *name;
}

@property (nonatomic,retain) NSString *name;

@end
