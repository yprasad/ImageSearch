//
//  ImageSearchSearchViewController.h
//  ImageSearch
//
//  Created by Yash Prasad on 8/5/15.
//  Copyright (c) 2015 Yash Prasad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageSearchSearchViewController : UIViewController

@property (nonatomic, readwrite, strong) IBOutlet UIButton *searchButton;
@property (nonatomic, readwrite, strong) IBOutlet UITextField *searchField;

- (void)performSearchWithString:(NSString *)searchString animated:(BOOL)animated;

@end
