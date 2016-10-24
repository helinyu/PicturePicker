//
//  ViewController.m
//  PicturePicker
//
//  Created by felix on 2016/10/17.
//  Copyright © 2016年 felix. All rights reserved.

#import "ViewController.h"
#import "DisplayPictures.h"
#import "PicturesDisplayStyleService.h"
#import "TakePictures.h"

#define Dismiss_Back [self dismissViewControllerAnimated:true completion:nil];

@interface ViewController ()<UIActionSheetDelegate>
{
    PicturesDisplayStyle _displayStyle;
}
@property (weak, nonatomic) IBOutlet UISegmentedControl *changeCondition;
@property (weak, nonatomic) IBOutlet UILabel *NumberOfColumns;
@property (weak, nonatomic) IBOutlet UITextField *inputTextfield;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initVariables];
    
}

- (void)initVariables {
    _displayStyle = PicturesDisplayStyleDefaultOrNot;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
 显示全部的图片
 */
- (IBAction)onDisplayPhotoLibraryClicked:(id)sender {
    
    if (_displayStyle == PicturesDisplayStyleOutSide) {
        
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:@"取消"destructiveButtonTitle:nil otherButtonTitles:@"相机",@"相册", nil];
                [actionSheet showInView:self.view];
        return;
    }
    
    [self transToDisplayViewController];
}

- (void)transToDisplayViewController {
    
    DisplayPictures * dpViewController = [[UIStoryboard storyboardWithName:@"Picture" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([DisplayPictures class])];
    dpViewController.numberOfcolumn = [self.inputTextfield.text integerValue];
    [dpViewController showPhotoLibraryPhtosFrom:self withPicturesDisplayStyle:_displayStyle Complete:^(NSMutableArray<ALAsset *> *result) {
        NSLog(@"alasset is : %@",result);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([self.inputTextfield respondsToSelector:@selector(resignFirstResponder)]) {
                [self.inputTextfield resignFirstResponder];
            }
        });
    }];
}

- (IBAction)onChangeDisPlayCellConditionClicked:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl*)sender;
    NSLog(@"index is : %ld",(long)segmentedControl.selectedSegmentIndex);
    _displayStyle = segmentedControl.selectedSegmentIndex;
}

#pragma mark -- UIActionSheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 8_3)  {
//    NSLog(@"index is ; %d",buttonIndex);
}

- (void)actionSheetCancel:(UIActionSheet *)actionSheet {
    NSLog(@"取消");
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex  // after animation
{
    NSLog(@"button Index is : %ld",(long)buttonIndex);
    
    if(buttonIndex == 0) {
//        拍照
    [[TakePictures new] showImagePickerFromViewController:self CompleteWithInfo:^(NSDictionary<NSString *,id> *info) {
        NSLog(@"%@",info);
    }];
        
    }else {
        [self transToDisplayViewController];
    }

}

@end
