//
//  ImageSearchHistoryController.h
//  ImageSearch
//
//  Created by Yash Prasad on 8/10/15.
//  Copyright (c) 2015 Yash Prasad. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ImageSearchHistoryControllerDelegate;

@interface ImageSearchHistoryController : NSObject

@property (nonatomic, readonly, strong) NSMutableArray *searchHistory;
@property (nonatomic, readwrite, weak) id<ImageSearchHistoryControllerDelegate> delegate;

+ (id)sharedManager;
- (void)clearHistory;

@end

@protocol ImageSearchHistoryControllerDelegate <NSObject>

- (void)imageSearchHistoryControllerDidUpdate:(ImageSearchHistoryController *)controller;

@end
