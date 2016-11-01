//
//  PictureTaker.m
//  PicturePicker
//
//  Created by felix on 2016/11/1.
//  Copyright © 2016年 felix. All rights reserved.
//
#import <MobileCoreServices/MobileCoreServices.h>
#import "PictureTaker.h"

@interface PictureTaker ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic) UIImagePickerController *imagePicker;
@property (nonatomic) BackImage backImage;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation PictureTaker

//- (id)imagePickerController {
//    if (!_imagePickerController) {
//        _imagePickerController = [UIImagePickerController new];
//    }
//    return _imagePickerController;
//}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initVariables];
    
//    self.imagePickerController = [[UIImagePickerController alloc] init];
}

- (void)initVariables {
    
    
    _imagePicker = [[UIImagePickerController alloc] init];
    
    if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]) {
        NSLog(@"支持前置摄像头");
    }else{
        NSLog(@"不支持前置摄像头");
    }
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSLog(@"支持摄像机");
    }else{
        NSLog(@"不支持摄像机");
    }
    
    if ([UIImagePickerController isFlashAvailableForCameraDevice:UIImagePickerControllerCameraDeviceRear]) {
        NSLog(@"支持前置闪光");
    }else{
        NSLog(@"不支持前置闪光");
    }
    
//    设置属性应该是有先后顺序
    self.imagePicker = [UIImagePickerController new];
    self.imagePicker.delegate = self;
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    self.imagePicker.mediaTypes = @[(NSString *)kUTTypeVideo,(NSString*)kUTTypeMovie];
    self.imagePicker.videoQuality = UIImagePickerControllerQualityTypeIFrame1280x720;
    self.imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
 
    [self presentViewController:_imagePicker animated:true completion:nil];

}

#pragma mark --  UIImagePickerController

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
//    [self.imagePickerController dismissViewControllerAnimated:true completion:^{
//        if ([[NSThread currentThread] isMainThread]) {
//            self.imageView.image = [info objectForKey:UIImagePickerControllerEditedImage];
//        }else{
//            dispatch_async(dispatch_get_main_queue(), ^{
//                self.imageView.image = [info objectForKey:UIImagePickerControllerEditedImage];
//            });
//        }
//    }];
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:((NSString *)kUTTypeImage)]) {
        //图片保存和展示
        UIImage *image;
        if (picker.allowsEditing) {
            image = [info objectForKey:UIImagePickerControllerEditedImage]; //允许编辑，获取编辑过的图片
        }
        else{
            image = [info objectForKey:UIImagePickerControllerOriginalImage]; //不允许编辑，获取原图片
        }
        UIImageWriteToSavedPhotosAlbum(image,nil,nil, nil);
    }
    else if([type isEqualToString:(NSString *)kUTTypeVideo]){
        //视频保存后 播放视频
        NSURL *url = [info objectForKey:UIImagePickerControllerMediaURL];
        NSString *urlPath = [url path];
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(urlPath)) {
//            UISaveVideoAtPathToSavedPhotosAlbum(urlPath, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
        }
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self.imagePicker dismissViewControllerAnimated:true completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)onBackClicked:(id)sender {
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:true];
    }else{
        [self dismissViewControllerAnimated:true completion:nil];
    }
}

@end
