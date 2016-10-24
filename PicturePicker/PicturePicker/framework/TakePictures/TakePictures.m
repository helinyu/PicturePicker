//
//  TakePictures.m
//  PicturePicker
//
//  Created by felix on 2016/10/24.
//  Copyright © 2016年 felix. All rights reserved.
//

#import "TakePictures.h"
#import "CreateServiceObjectFactory.h"

@interface TakePictures ()<UIAlertViewDelegate>

@property (nonatomic) BackInfo backInfo;
@property (nonatomic) ALAssetsLibraryAssetForURLResultBlock assetResultBlock;
@property (nonatomic) ALAssetsLibraryGroupResultBlock groupResultBlock;
@property (nonatomic) ALAssetsLibraryAccessFailureBlock failureBlock;
@property (nonatomic) ALAssetsLibraryWriteImageCompletionBlock imageCompletionBlock;
@property (nonatomic) ALAssetsLibraryWriteVideoCompletionBlock vedioCompletionBlock;

@end

@implementation TakePictures

- (void)viewDidLoad {
    [super viewDidLoad ];
    self.delegate = self;
}

- (void)showImagePickerFromViewController:(UIViewController *)viewController {
    if (![TakePictures isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSLog(@"没有相应的设备功能");
        return;
    }
    
    self.allowsEditing = true;
    self.modalPresentationStyle = UIModalPresentationFullScreen;
    self.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    self.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    [viewController presentViewController:self animated:true completion:nil];
}

- (void)showImagePickerFromViewController:(UIViewController *)viewController CompleteWithInfo:(BackInfo)info {
    [self showImagePickerFromViewController:viewController];
    _backInfo = info;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)showImagePickerFromViewController:(UIViewController *)viewController CompleteWithAsset:(ALAssetsLibraryAssetForURLResultBlock) assetResultBlock{
    [self showImagePickerFromViewController:viewController];
    _assetResultBlock = assetResultBlock;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    Dismiss_Back
    _backInfo(info);
    
    UIImage *image = [info objectForKey:self.allowsEditing ? UIImagePickerControllerEditedImage : UIImagePickerControllerOriginalImage];
    
    [[OBTAIN_SERVICE(ALAssetLibraryService) defaultALAssetLibrary] writeImageToSavedPhotosAlbum:(__bridge CGImageRef)(image) orientation:(ALAssetOrientation)image.imageOrientation completionBlock:^(NSURL *assetURL, NSError *error) {
            if (error == nil) {
                [[OBTAIN_SERVICE(ALAssetLibraryService) defaultALAssetLibrary] assetForURL:assetURL resultBlock:^(ALAsset *asset) {
                    _assetResultBlock(asset);
                } failureBlock:^(NSError *error) {
                    NSLog(@"出错啦，请重新拍照");
                    _assetResultBlock(nil);
                }];
            }
            else {
                NSLog(@"出错啦，请重新拍照");
                [self checkPhotosAuthorizationStatus];
                _assetResultBlock(nil);
            }
    }];
}

- (void)checkPhotosAuthorizationStatus {

    if([ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusDenied) {
        
        [self showAuthorityAlertWithTitle:@"无法查看照片! o(>﹏<)o\n 请在系统\"设置－隐私－照片\"选项中打开闺蜜圈的相册权限"];
        return;
    }
}

- (void)showAuthorityAlertWithTitle:(NSString *)title{
    
   UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去设置", nil];
    alertView.delegate = self;
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 9_0) {
    if(buttonIndex == 0){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    Dismiss_Back
    _backInfo(nil);
}

#pragma mark -- UINavigationViewControllerDelegate


@end
