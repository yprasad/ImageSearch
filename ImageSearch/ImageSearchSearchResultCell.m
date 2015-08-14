//
//  ImageSearchSearchResultCell.m
//  ImageSearch
//
//  Created by Yash Prasad on 8/10/15.
//  Copyright (c) 2015 Yash Prasad. All rights reserved.
//

#import "ImageSearchSearchResultCell.h"
#import "AsyncImageView.h"

@interface ImageSearchSearchResultCell ()
@property (nonatomic, readwrite, strong) AsyncImageView *asyncImageView;
@end

@implementation ImageSearchSearchResultCell

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  
  if (self != nil) {
    self.asyncImageView = [[AsyncImageView alloc] initWithFrame:CGRectZero];
    self.asyncImageView.showActivityIndicator = YES;
    self.asyncImageView.activityIndicatorStyle = UIActivityIndicatorViewStyleWhiteLarge;
    self.asyncImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.asyncImageView.crossfadeDuration = 0.0;
    [self.contentView addSubview:_asyncImageView];
  }
  
  return self;
}

- (void)drawRect:(CGRect)rect
{
  [super drawRect:rect];
  
  _asyncImageView.frame = self.contentView.bounds;
}

@end
