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


typedef void (^SearchControllerSuccessCallback)(NSArray *results);
typedef void (^SearchControllerFailureCallback)(NSError *error);
typedef void (^SearchControllerNoMoreImagesCallback)();

@interface ImageSearchSearchController : NSObject

- (void)searchGoogleImagesWithString:(NSString *)searchString page:(NSUInteger)pageNumber
                     successCallback:(SearchControllerSuccessCallback)successCallback
                     failureCallback:(SearchControllerFailureCallback)failureCallback
                noMoreImagesCallback:(SearchControllerNoMoreImagesCallback)noMoreImagesCallback;

@end