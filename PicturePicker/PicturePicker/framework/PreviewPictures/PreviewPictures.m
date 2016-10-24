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
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewToTopConstraint;

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
    
    self.navigationItem.title = @"图片预览";
    
    UIBarButtonItem *nowDisplayItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(displayCount:)];
    self.navigationItem.rightBarButtonItem = nowDisplayItem;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_clickedIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:false];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

#pragma mark -- uibarbutton 

- (void)displayCount:(UIBarButtonItem *)item {
    NSLog(@"display count");
}

#pragma mark -- uicollectionView datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _datasources.count;
}
    
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PreviewPictureCell *pictureCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([PreviewPictureCell class]) forIndexPath:indexPath];
    
    
    CGFloat cellFrameWith = self.collectionView.frame.size.width;
    CGFloat cellFrameHeight = self.collectionView.frame.size.height;
    CGFloat cellHeight = cellFrameHeight;
    ALAssetRepresentation *itemRepresentation = [_datasources[indexPath.row] defaultRepresentation];
    if (itemRepresentation.dimensions.width > cellFrameWith ) {
        cellHeight = cellFrameHeight * itemRepresentation.dimensions.height / itemRepresentation.dimensions.width;
    }else{
       cellHeight = CGRectGetHeight(pictureCell.bounds);
    }
    
    if (cellHeight < cellFrameHeight) {
        pictureCell.contentViewToTopConstraint.constant = (cellFrameHeight - cellHeight ) / 2;
    }else{
        pictureCell.contentViewToTopConstraint.constant = 0;
    }

    pictureCell.contentViewHeightContraint.constant = cellHeight;
    pictureCell.imageView.image =[UIImage imageWithCGImage:[[_datasources[indexPath.row] defaultRepresentation] fullResolutionImage]];
    
    return pictureCell;
}

#pragma mark -- uicollecitonViewDelegateLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.collectionView.bounds.size;
//    注意理解collectionView的bounds概念（边沿：即为看到的边沿）
}

#pragma mark -- UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(8_0) {
    self.navigationItem.rightBarButtonItem.title = [NSString stringWithFormat:@"%ld/%lu",indexPath.row + 1,(unsigned long)_datasources.count ];
}


@end
