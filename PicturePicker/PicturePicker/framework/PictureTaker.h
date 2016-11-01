//
//  PictureTaker.h
//  PicturePicker
//
//  Created by felix on 2016/11/1.
//  Copyright © 2016年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@interface PictureTaker : UIViewController

typedef void (^PicturesPHFetchResult)(PHFetchResult<PHAsset *> * result);
typedef void (^BackImage)(UIImage * image);


@end
