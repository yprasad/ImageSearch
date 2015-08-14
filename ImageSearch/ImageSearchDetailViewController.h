//
//  ImageSearchDetailViewController.h
//  ImageSearch
//
//  Created by Yash Prasad on 8/12/15.
//  Copyright (c) 2015 Yash Prasad. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ImageSearchPhoto;

@interface ImageSearchDetailViewController : UIViewController

@property (nonatomic, readwrite, strong) IBOutlet UIScrollView *scrollView;

- (instancetype)initWithPhoto:(ImageSearchPhoto *)photo;

@end
