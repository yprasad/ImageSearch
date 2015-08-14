//
//  ImageSearchSearchViewController.m
//  ImageSearch
//
//  Created by Yash Prasad on 8/5/15.
//  Copyright (c) 2015 Yash Prasad. All rights reserved.
//

#import "ImageSearchSearchViewController.h"
#import "ImageSearchSearchResultsViewController.h"
#import "ImageSearchSearchController.h"

@interface ImageSearchSearchViewController () <UITextFieldDelegate>

@end

@implementation ImageSearchSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  [self setTitle:NSLocalizedString(@"Google Image Search", @"Title of the main search window")];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)searchButtonTapped:(id)sender {
  [self performSearchWithString:_searchField.text animated:YES];
}

- (void)performSearchWithString:(NSString *)searchString animated:(BOOL)animated
{
  [self.navigationController popToRootViewControllerAnimated:NO];
  UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

  [[NSNotificationCenter defaultCenter] postNotificationName:kSearchNotificationName
                                                      object:self
                                                    userInfo:@{kSearchNotificationSearchStringKey: searchString,
                                                               kSearchNotificationDateKey: [NSDate date]}];
  
  ImageSearchSearchResultsViewController *resultsViewController = [storyboard instantiateViewControllerWithIdentifier:@"ResultsViewController"];
  [resultsViewController searchWithString:searchString];
  
  [self.navigationController pushViewController:resultsViewController animated:animated];
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
  [self performSearchWithString:textField.text animated:YES];
  return YES;
}


@end
