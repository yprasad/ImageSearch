//
//  ImageSearchTabBarController.m
//  ImageSearch
//
//  Created by Yash Prasad on 8/5/15.
//  Copyright (c) 2015 Yash Prasad. All rights reserved.
//

#import "ImageSearchTabBarController.h"
#import "ImageSearchHistoryController.h"
#import "ImageSearchHistoryViewController.h"
#import "ImageSearchSearchViewController.h"

#define kSearchViewControllerIndex 0
#define kHistoryViewControllerIndex 1

@interface ImageSearchTabBarController () <ImageSearchHistoryViewControllerDelegate>
@property (nonatomic, readwrite, weak) ImageSearchSearchViewController *searchViewController;
@property (nonatomic, readwrite, weak) ImageSearchHistoryViewController *historyViewController;
@end

@implementation ImageSearchTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    // Do any additional setup after loading the view.
  _searchViewController = (ImageSearchSearchViewController *)[[[self viewControllers] objectAtIndex:kSearchViewControllerIndex] topViewController];
  _historyViewController = (ImageSearchHistoryViewController *)[[[self viewControllers] objectAtIndex:kHistoryViewControllerIndex] topViewController];
  _historyViewController.delegate = self;
  
    // Set up history controller so it observes any searches
  [ImageSearchHistoryController sharedManager];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ImageSearchHistoryViewControllerDelegate

- (void)historyViewController:(ImageSearchHistoryViewController *)controller didSelectSearchWithString:(NSString *)searchString
{
  [self setSelectedIndex:kSearchViewControllerIndex];
  [_searchViewController performSearchWithString:searchString animated:NO];
}

@end
