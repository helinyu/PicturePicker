//
//  PictureDatasources.m
//  PicturePicker
//
//  Created by felix on 2016/10/18.
//  Copyright © 2016年 felix. All rights reserved.
//

#import "PictureDatasources.h"

@implementation PictureDatasources

+ (void)requestAllPhotoFromAlbumWithALAssetsGroup:(ALAssetsGroupResultsBlock)resultBlock {
    
//    这里选择相册，还有其他的选项看看是怎么样进行选择
//    这里可以使用预编译的宏定义来进行处理
    if ([Helper isGreaterOrEqualToIOS9]) {
        PHFetchOptions *option = [PHFetchOptions new];
        option.includeAssetSourceTypes = PHAssetSourceTypeUserLibrary;
        option.includeHiddenAssets = true;
        option.includeAllBurstAssets = true;
        option.wantsIncrementalChangeDetails = true;
        PHFetchResult<PHAsset *> * result = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:option];
        NSLog(@"resutl : %@",result);
        [result enumerateObjectsUsingBlock:^(PHAsset * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"result is : %@",obj);
            NSLog(@"idx : %lu",(unsigned long)idx);
//            NSLog(@"stop : %d",stop);
        }];
       
    }else{
//        [[OBTAIN_SERVICE(ALAssetLibraryService) defaultALAssetLibrary] enumerateGroupsWithTypes:ALAssetsGroupAlbum usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        [[OBTAIN_SERVICE(ALAssetLibraryService) defaultALAssetLibrary] enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
            resultBlock(group);
            
        } failureBlock:^(NSError *error) {
            resultBlock(nil);
        }];
    }
}

+ (void)requestAllPhotoFromAlbumWithALAssets:(ALAssetsResultsBlock)resultBlock {
    
}

@end
