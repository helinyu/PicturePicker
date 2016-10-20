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
    [[OBTAIN_SERVICE(ALAssetLibraryService) defaultALAssetLibrary] enumerateGroupsWithTypes:ALAssetsGroupAlbum usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        resultBlock(group);
        
    } failureBlock:^(NSError *error) {
        resultBlock(nil);
    }];
}

+ (void)requestAllPhotoFromAlbumWithALAssets:(ALAssetsResultsBlock)resultBlock {
    
}

@end
