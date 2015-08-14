//
//  ImageSearchDetailViewController.m
//  ImageSearch
//
//  Created by Yash Prasad on 8/12/15.
//  Copyright (c) 2015 Yash Prasad. All rights reserved.
//

#import "ImageSearchDetailViewController.h"
#import "AsyncImageView.h"

@interface ImageSearchDetailViewController ()
@property (nonatomic, readwrite, strong) AsyncImageView *imageView;
@property (nonatomic, readwrite, strong) NSURL *url;
@end

@implementation ImageSearchDetailViewController

- (instancetype)initWithImageURL:(NSURL *)URL
{
  self = [super initWithNibName:nil bundle:nil];
  
  if (self != nil) {
    _url = URL;
    
    _imageView = [[AsyncImageView alloc] initWithFrame:CGRectZero];
    _imageView.showActivityIndicator = YES;
    _imageView.activityIndicatorStyle = UIActivityIndicatorViewStyleWhiteLarge;
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
  }
  
  return self;
}

- (void)viewDidLoad
{
  self.view.backgroundColor = [UIColor blackColor];
  _imageView.frame = self.view.bounds;
  [self.view addSubview:_imageView];
}

- (void)viewDidAppear:(BOOL)animated
{
  _imageView.imageURL = _url;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
  [coordinator animateAlongsideTransition:^(id <UIViewControllerTransitionCoordinatorContext>context) {
    _imageView.frame = self.view.bounds;
  } completion:^(id <UIViewControllerTransitionCoordinatorContext>context){
    
  }];
}

@end
