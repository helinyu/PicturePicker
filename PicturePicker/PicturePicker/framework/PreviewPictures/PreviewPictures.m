//
//  PreviewPictures.m
//  PicturePicker
//
//  Created by felix on 2016/10/19.
//  Copyright © 2016年 felix. All rights reserved.
//

#import "PreviewPictures.h"

@interface PreviewPictureCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeightContraint;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *customContentView;

@end

@implementation PreviewPictureCell

@end

@interface PreviewPictures ()
{
    NSMutableArray<ALAsset *>* _datasources;
    ALAssetsGroup * _assetsGroup;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation PreviewPictures

- (void)passValueToDatasource:(NSMutableArray<ALAsset*> *)datasource {
    _datasources = [NSMutableArray<ALAsset *> new];
    for (ALAsset *asset in datasource ) {
        [_datasources addObject:asset];
    }
#pragma mark -- 为什么这个方法不可以用
//    [_datasources arrayByAddingObjectsFromArray:datasource];
}

- (void)passValueToGroupDatasource:(ALAssetsGroup *)datasource {
    _assetsGroup = datasource;
}

- (void)passValueToDatasource:(NSMutableArray<ALAsset*> *)assests withGroupDataSource:(ALAssetsGroup *)assetsGroup{
    [self passValueToGroupDatasource:assetsGroup];
    [self passValueToDatasource:assests];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initVariables];

}

- (void) initVariables {
    self.automaticallyAdjustsScrollViewInsets = false;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -- uicollectionView datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _datasources.count;
}
    
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PreviewPictureCell *pictureCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([PreviewPictureCell class]) forIndexPath:indexPath];
    
    
    CGFloat cellFrameWith = self.collectionView.frame.size.width;
    CGFloat cellFrameHeight = self.collectionView.frame.size.width;
    CGFloat cellWith = cellFrameWith;
    CGFloat cellHeight = cellFrameHeight;
    ALAssetRepresentation *itemRepresentation = [_datasources[indexPath.row] defaultRepresentation];
    if (itemRepresentation.dimensions.width > cellFrameWith ) {
        cellHeight = cellFrameHeight * itemRepresentation.dimensions.height / itemRepresentation.dimensions.width;
        if (cellHeight <= cellFrameHeight) {
            cellHeight = cellFrameHeight;
        }
    }
    pictureCell.contentViewHeightContraint.constant = cellHeight;
//    self.collectionView.bounds = CGRectMake(0, 0, cellWith, cellHeight);
    pictureCell.imageView.image =[UIImage imageWithCGImage:[[_datasources[indexPath.row] defaultRepresentation] fullResolutionImage]];
    
    return pictureCell;
}

#pragma mark -- uicollecitonViewDelegateLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    先计算大小
    
    ALAsset *assetItem = _datasources[indexPath.row];
//    NSLog(@"%@",[assetItem valueForProperty:ALAssetPropertyType]); //获取到资源的类型
//    NSLog(@"%@",[assetItem valueForProperty:ALAssetPropertyLocation]); //获取到资源的类型
//    NSLog(@"%@",[assetItem valueForProperty:ALAssetPropertyDuration]); //获取到资源的类型
//    NSLog(@"%@",[assetItem valueForProperty:ALAssetPropertyOrientation]); //获取到资源的类型
//    NSLog(@"%@",[assetItem valueForProperty:ALAssetPropertyDate]); //获取到资源的类型
//    NSLog(@"%@",[assetItem valueForProperty:ALAssetPropertyRepresentations]); //获取到资源的类型
//    NSLog(@"%@",[assetItem valueForProperty:ALAssetPropertyURLs]); //获取到资源的类型
//    NSLog(@"%@",[assetItem valueForProperty:ALAssetPropertyAssetURL]); //获取到资源的类型
//    1）通过SDWebImage里面的内容进通过url获取图片
//    2）通过陈述的方式 ALAssetRepresentation
    ALAssetRepresentation *itemRepresentation = [assetItem defaultRepresentation];
//    NSLog(@"%@",itemRepresentation.UTI);
//    NSLog(@"%lld",itemRepresentation.size);
//    NSLog(@"%lld",itemRepresentation.dimensions);
//    NSLog(@"%@",itemRepresentation.fullResolutionImage);
//    NSLog(@"%@",itemRepresentation.fullScreenImage);
//    NSLog(@"%@",itemRepresentation.url);
//    NSLog(@"%@",itemRepresentation.metadata);
//    NSLog(@"%f",itemRepresentation.scale);
//    NSLog(@"%@",itemRepresentation.filename);
//    NSLog(@"%ld",(long)itemRepresentation.orientation);
//    CGFloat cellFrameWith = self.collectionView.frame.size.width;
//    CGFloat cellFrameHeight = self.collectionView.frame.size.width;
//    CGFloat cellWith = cellFrameWith;
//    CGFloat cellHeight = cellFrameHeight;
//    if (itemRepresentation.dimensions.width > cellFrameWith ) {
//        cellHeight = cellFrameHeight * itemRepresentation.dimensions.height / itemRepresentation.dimensions.width;
//        if (cellHeight <= cellFrameHeight) {
//            cellHeight = cellFrameHeight;
//        }
//    }
    return self.collectionView.bounds.size;
//    return CGSizeMake(cellWith, cellHeight);
}

@end
