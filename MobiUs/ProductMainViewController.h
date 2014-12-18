//
//  ProductMainViewController.h
//  MobiUs
//
//  Created by Myles Caley on 12/17/14.
//  Copyright (c) 2014 FirstBuild. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductCollectionViewController.h"

@interface ProductMainViewController : UIViewController <ProductCollectionViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *noProductsView;
@property (strong, nonatomic) IBOutlet UIView *productsCollectionView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;
@property (strong, nonatomic) IBOutlet UIButton *buttonAddProduct;
@property (strong, nonatomic) IBOutlet UIImageView *teardropImage;

@end
