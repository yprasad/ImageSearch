//
//  ImageSearchSearchController.m
//  ImageSearch
//
//  Created by Yash Prasad on 8/5/15.
//  Copyright (c) 2015 Yash Prasad. All rights reserved.
//

#import "ImageSearchSearchController.h"
#import "ImageSearchPhoto.h"
#import <UIKit/UIKit.h>

#define kNumberPerPage 8

@interface ImageSearchSearchController ()
{
  dispatch_queue_t _workerQueue;
}
@end

@implementation NSString (Additions)
- (NSString *)URLStringByAppendingQueryString:(NSString *)queryString {
  if (![queryString length]) {
    return self;
  }
  return [NSString stringWithFormat:@"%@%@%@", self,
          [self rangeOfString:@"?"].length > 0 ? @"&" : @"?", queryString];
}
@end

@interface ImageSearchSearchController ()
{
  NSMutableArray *_searchResults;
}
@end


@implementation ImageSearchSearchController

- (instancetype)init
{
  if (self = [super init]) {
    _workerQueue = dispatch_queue_create( "fetch_images", NULL );
  }
  
  return self;
}

- (void)searchGoogleImagesWithString:(NSString *)searchString page:(NSUInteger)pageNumber
                     successCallback:(SearchControllerSuccessCallback)successCallback
                     failureCallback:(SearchControllerFailureCallback)failureCallback
                noMoreImagesCallback:(SearchControllerNoMoreImagesCallback)noMoreImagesCallback
{
  NSString *searchURLString = [NSString stringWithFormat:@"https://ajax.googleapis.com/ajax/services/search/images"];

  searchURLString = [searchURLString URLStringByAppendingQueryString:[[NSString stringWithFormat:@"q=%@", searchString] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
  searchURLString = [searchURLString URLStringByAppendingQueryString:[[NSString stringWithFormat:@"v=1.0"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
  searchURLString = [searchURLString URLStringByAppendingQueryString:[[NSString stringWithFormat:@"as_filetype=jpg"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
  searchURLString = [searchURLString URLStringByAppendingQueryString:[[NSString stringWithFormat:@"rsz=%d", kNumberPerPage] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
  searchURLString = [searchURLString URLStringByAppendingQueryString:[[NSString stringWithFormat:@"start=%lu", pageNumber * kNumberPerPage] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
  NSURL *searchURL = [NSURL URLWithString:searchURLString];
  
  dispatch_async(_workerQueue, ^{
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:searchURL] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
      if (error) {
        dispatch_async(dispatch_get_main_queue(), ^{
          failureCallback(error);
        });
      } else {
        NSError *localError = nil;
        NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&localError];
        if (localError != nil) {
          dispatch_async(dispatch_get_main_queue(), ^{
            failureCallback(localError);
          });
        } else {
          NSMutableArray *photosArray = [NSMutableArray new];
          id results = [parsedObject valueForKeyPath:@"responseData.results"];
          if ([results isKindOfClass:[NSArray class]]) {
            for (NSDictionary *photoResult in results) {
              ImageSearchPhoto *photo = [ImageSearchPhoto new];
              photo.thumbnailURLString = [photoResult valueForKeyPath:@"tbUrl"];
              photo.urlString = [photoResult valueForKeyPath:@"url"];
              photo.thumbnailSize = CGSizeMake([[photoResult valueForKeyPath:@"tbWidth"] integerValue], [[photoResult valueForKeyPath:@"tbHeight"] integerValue]);
              
              [photosArray addObject:photo];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
              successCallback(photosArray);
            });
          } else{
            dispatch_async(dispatch_get_main_queue(), ^{
              noMoreImagesCallback();
            });
          }
        }
      }
    }];
  });
}

@end
