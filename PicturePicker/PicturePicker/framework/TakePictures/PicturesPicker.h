//
//  TakePictures.h
//  PicturePicker
//
//  Created by felix on 2016/10/24.
//  Copyright © 2016年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FrameworkDefinition.h"
#import <AssetsLibrary/AssetsLibrary.h>

@protocol TakePicturesDelegate
@end


@interface PicturesPicker : UIImagePickerController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

typedef void (^BackInfo)(NSDictionary<NSString *,id> * info);
typedef void (^BackInfo)(NSDictionary<NSString *,id> * info);


- (void)showImagePickerFromViewController:(UIViewController *)viewController ;
- (void)showImagePickerFromViewController:(UIViewController *)viewController CompleteWithInfo:(BackInfo)info ;
- (void)showImagePickerFromViewController:(UIViewController *)viewController CompleteWithAsset:(ALAssetsLibraryAssetForURLResultBlock) assetResultBlock ;

@end
