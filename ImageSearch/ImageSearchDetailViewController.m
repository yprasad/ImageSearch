//
//  ImageSearchDetailViewController.m
//  ImageSearch
//
//  Created by Yash Prasad on 8/12/15.
//  Copyright (c) 2015 Yash Prasad. All rights reserved.
//

#import "ImageSearchDetailViewController.h"
#import "AsyncImageView.h"
#import "ImageSearchPhoto.h"

@interface ImageSearchDetailViewController () <UIScrollViewDelegate>
@property (nonatomic, readwrite, strong) AsyncImageView *imageView;
@property (nonatomic, readwrite, strong) ImageSearchPhoto *photo;
@end

@implementation ImageSearchDetailViewController

- (instancetype)initWithPhoto:(ImageSearchPhoto *)photo
{
  self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil];
  
  if (self != nil) {
    _photo = photo;
    _imageView = [[AsyncImageView alloc] initWithFrame:CGRectZero];
    _imageView.showActivityIndicator = YES;
    _imageView.activityIndicatorStyle = UIActivityIndicatorViewStyleWhiteLarge;
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
  }
  
  return self;
}

- (void)viewDidLoad
{
  _scrollView.frame = self.view.bounds;
  _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  _scrollView.backgroundColor = [UIColor blackColor];
  _scrollView.minimumZoomScale=0.5;
  _scrollView.maximumZoomScale=6.0;
  
  [_scrollView addSubview:_imageView];
}

- (void)viewDidAppear:(BOOL)animated
{
  _imageView.frame = _scrollView.bounds;
  _imageView.imageURL = [NSURL URLWithString:_photo.urlString];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
  [coordinator animateAlongsideTransition:^(id <UIViewControllerTransitionCoordinatorContext>context) {
    _scrollView.frame = self.view.bounds;
  } completion:^(id <UIViewControllerTransitionCoordinatorContext>context){
    
  }];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
  return _imageView;
}

@end
