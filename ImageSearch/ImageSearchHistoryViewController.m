//
//  ImageSearchHistoryViewController.m
//  ImageSearch
//
//  Created by Yash Prasad on 8/5/15.
//  Copyright (c) 2015 Yash Prasad. All rights reserved.
//

#import "ImageSearchHistoryViewController.h"
#import "ImageSearchSearchResultsViewController.h"
#import "ImageSearchHistoryController.h"
#import "ImageSearchSearchController.h"

static NSString * const historyReuseIdentifier = @"HistoryCell";

@interface ImageSearchHistoryViewController () <ImageSearchHistoryControllerDelegate>

@end

@implementation ImageSearchHistoryViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.title = NSLocalizedString(@"Search History", @"Title for the search history pane");
  [[ImageSearchHistoryController sharedManager] setDelegate:self];
  
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Clear", @"Clear history button") style:UIBarButtonItemStylePlain target:self action:@selector(clearHistory)];
  [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [[self searchHistory] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:historyReuseIdentifier];
  
  NSDictionary *searchDataAtRow = [[self searchHistory] objectAtIndex:indexPath.row];
  
  cell.textLabel.text = [searchDataAtRow objectForKey:kSearchNotificationSearchStringKey];
  NSDate *now = [searchDataAtRow objectForKey:kSearchNotificationDateKey];
  NSDateFormatter *dateFormat = [NSDateFormatter new];
  [dateFormat setDateFormat:@"MM/dd/yyyy hh:mma"];
  NSString *dateString = [dateFormat stringFromDate:now];
  cell.detailTextLabel.text = dateString;
  
  return cell;
}

- (NSArray *)searchHistory {
  return [[ImageSearchHistoryController sharedManager] searchHistory];
}

- (void)clearHistory
{
  [[ImageSearchHistoryController sharedManager] clearHistory];
  [self.tableView reloadData];
}

#pragma mark ImageSearchHistoryControllerDelegate
- (void)imageSearchHistoryControllerDidUpdate:(ImageSearchHistoryController *)controller
{
  [self.tableView reloadData];
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSDictionary *searchDataAtRow = [[self searchHistory] objectAtIndex:indexPath.row];
  [_delegate historyViewController:self didSelectSearchWithString:[searchDataAtRow objectForKey:kSearchNotificationSearchStringKey]];
}

@end
