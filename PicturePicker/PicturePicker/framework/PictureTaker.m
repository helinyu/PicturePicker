//
//  PictureTaker.m
//  PicturePicker
//
//  Created by felix on 2016/11/1.
//  Copyright © 2016年 felix. All rights reserved.
//

#import "PictureTaker.h"

@interface PictureTaker ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic) UIImagePickerController *imagePickerController;
@property (nonatomic) BackImage backImage;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation PictureTaker

- (id)imagePickerController {
    if (!_imagePickerController) {
        _imagePickerController = [UIImagePickerController new];
    }
    return _imagePickerController;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initVariables];
    
//    self.imagePickerController = [[UIImagePickerController alloc] init];
}

- (void)initVariables {
    
    //判断是否有资源可以支持
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSLog(@"支持相机");
    }else{
        NSLog(@"该设备没有支持相机");
    }

    self.imagePickerController.allowsEditing = true;
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]) {
        self.imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    }
    self.imagePickerController.delegate = self;
    [self presentViewController:self.imagePickerController animated:true completion:nil];
}


#pragma mark --  UIImagePickerController 

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [self.imagePickerController dismissViewControllerAnimated:true completion:^{
        if ([[NSThread currentThread] isMainThread]) {
            self.imageView.image = [info objectForKey:UIImagePickerControllerEditedImage];
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                self.imageView.image = [info objectForKey:UIImagePickerControllerEditedImage];
            });
        }
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self.imagePickerController dismissViewControllerAnimated:true completion:nil];
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
