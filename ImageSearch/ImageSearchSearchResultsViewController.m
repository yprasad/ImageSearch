//
//  ImageSearchSearchResultsViewController.m
//  ImageSearch
//
//  Created by Yash Prasad on 8/5/15.
//  Copyright (c) 2015 Yash Prasad. All rights reserved.
//

#import "ImageSearchSearchResultsViewController.h"
#import "ImageSearchSearchController.h"
#import "AsyncImageView.h"
#import "ImageSearchPhoto.h"
#import "ImageSearchSearchResultCell.h"
#import "ImageSearchDetailViewController.h"

#define kCollectionViewDimension 100
#define kCollectionViewInset 20
#define kCollectionViewReloadTimeInSeconds 2

@interface ImageSearchSearchResultsViewController () <UICollectionViewDelegateFlowLayout>
{
  ImageSearchSearchController *_searchController;
  NSMutableArray *_searchResults;
  NSUInteger _page;
  NSString *_searchString;
  BOOL _noMoreImages;
  UIActivityIndicatorView *_activityIndicatorView;
  NSDate *_currentReloadDate;
  UIAlertController *_errorAlertController;
}
@end

@implementation ImageSearchSearchResultsViewController

static NSString * const reuseIdentifier = @"ImageSearchResultCell";

- (void)searchWithString:(NSString *)searchString
{
  [AsyncImageLoader sharedLoader].cache = [AsyncImageLoader defaultCache];
  [_searchResults removeAllObjects];
  
  if (_searchController == nil) {
    _searchController = [[ImageSearchSearchController alloc] init];
  }
  
  _noMoreImages = NO;
  _searchString = searchString;
  
  [self _searchWithString:searchString page:_page];
}

- (void)_searchWithString:(NSString *)searchString page:(NSUInteger)page
{
  [_searchController searchGoogleImagesWithString:searchString
                                             page:_page
                                  successCallback:^(NSArray *results) {
                                    [self _setShowActivityIndicatorView:NO];
                                    
                                    if (!_searchResults) {
                                      _searchResults = [NSMutableArray new];
                                    }

                                    [_searchResults addObjectsFromArray:results];
                                    [self.collectionView reloadData];
                                  }
                                  failureCallback:^(NSError *error) {
                                    NSLog(@"search failed with error %@", error);
                                    if (_errorAlertController == nil) {
                                      _errorAlertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Error", @"Title for error alert") message:[error localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
                                      UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"OK button") style:UIAlertActionStyleDefault handler:nil];
                                      [_errorAlertController addAction:defaultAction];
                                      [self presentViewController:_errorAlertController animated:YES completion:^{
                                        _errorAlertController = nil;
                                      }];
                                    }
                                  }
                                  noMoreImagesCallback:^{
                                    [self _setShowActivityIndicatorView:NO];
                                    
                                    _noMoreImages = YES;
                                  }];
}

- (void)_fetchMoreImages
{
  _page++;
  [self _searchWithString:_searchString page:_page];
}

- (void)_setShowActivityIndicatorView:(BOOL)showActivityIndicatorView
{
  if (showActivityIndicatorView && ![_activityIndicatorView superview]) {
    _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _activityIndicatorView.center = self.view.center;
    [self.view addSubview:_activityIndicatorView];
    [_activityIndicatorView startAnimating];
  } else if (!showActivityIndicatorView && [_activityIndicatorView superview]) {
    [_activityIndicatorView stopAnimating];
    [_activityIndicatorView removeFromSuperview];
  }
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.collectionView.contentInset = UIEdgeInsetsMake(kCollectionViewInset, kCollectionViewInset, kCollectionViewInset, kCollectionViewInset);
    [self setTitle:NSLocalizedString(@"Search Results", @"Title of search results page")];
    _page = 0;
    
    // Register cell classes
    [self.collectionView registerClass:[ImageSearchSearchResultCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  [self _setShowActivityIndicatorView:YES];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  if ([_searchResults count] > 0) {
    [self.collectionView reloadData];
    [self _setShowActivityIndicatorView:NO];
  }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  return CGSizeMake(kCollectionViewDimension, kCollectionViewDimension);
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return [_searchResults count] + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  ImageSearchSearchResultCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];

  if ([indexPath item] < [_searchResults count]) {
    ImageSearchPhoto *photo = [_searchResults objectAtIndex:indexPath.item];
    NSURL *photoURL = [NSURL URLWithString:photo.thumbnailURLString];
    cell.asyncImageView.image = nil;
    if (![cell.asyncImageView.imageURL isEqual:photoURL]) {
      if (indexPath.item == 4) {
        NSLog(@"cell = %@", cell);
      }
      cell.asyncImageView.imageURL = photoURL;
    }
  } else {
    if (!_noMoreImages) {
      // Fetch more images if there are any
      [self _fetchMoreImages];
    }
  }
  
  return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/


// Uncomment this method to specify if the specified item should be selected
//- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    return YES;
//}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
  ImageSearchPhoto *photo = [_searchResults objectAtIndex:indexPath.item];
  ImageSearchDetailViewController *detailViewController = [[ImageSearchDetailViewController alloc] initWithImageURL:[NSURL URLWithString:photo.urlString]];
  
  [self.navigationController pushViewController:detailViewController animated:YES];
}



// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}

@end
