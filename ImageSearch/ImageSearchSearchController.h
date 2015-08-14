//
//  ImageSearchSearchController.h
//  ImageSearch
//
//  Created by Yash Prasad on 8/5/15.
//  Copyright (c) 2015 Yash Prasad. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *kSearchNotificationName = @"kSearchNotificationName";
static NSString *kSearchNotificationSearchStringKey = @"kSearchNotificationSearchStringKey";
static NSString *kSearchNotificationDateKey = @"kSearchNotificationDateKey";

@protocol ImageSearchSearchControllerDelegate;

@interface ImageSearchSearchController : NSObject

@property (nonatomic, readwrite, weak) id<ImageSearchSearchControllerDelegate> delegate;

- (void)searchGoogleImagesWithString:(NSString *)searchString page:(NSUInteger)pageNumber;

@end

@protocol ImageSearchSearchControllerDelegate <NSObject>

- (void)imageSearchSearchController:(ImageSearchSearchController *)controller didFinishWithResults:(NSArray *)results;
- (void)imageSearchSearchControllerNoMoreImages:(ImageSearchSearchController *)controller;
- (void)imageSearchSearchController:(ImageSearchSearchController *)controller didFailWithError:(NSError *)error;
- (void)imageSearchSearchControllerWillBeginSearch:(ImageSearchSearchController *)controller;


@end