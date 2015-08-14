//
//  ImageSearchHistoryController.m
//  ImageSearch
//
//  Created by Yash Prasad on 8/10/15.
//  Copyright (c) 2015 Yash Prasad. All rights reserved.
//

#import "ImageSearchHistoryController.h"
#import "ImageSearchSearchController.h"

@interface ImageSearchHistoryController ()
@property (nonatomic, readwrite, strong) NSMutableArray *searchHistory;
@end

@implementation ImageSearchHistoryController

+ (id)sharedManager {
  static ImageSearchHistoryController *sharedMyManager = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedMyManager = [[self alloc] init];
  });
  return sharedMyManager;
}

- (id)init {
  if (self = [super init]) {
    _searchHistory = [NSMutableArray new];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationOfSearch:) name:kSearchNotificationName object:nil];
  }
  return self;
}

- (void)notificationOfSearch:(NSNotification *)notification {
  [_searchHistory addObject:[notification userInfo]];
  [_delegate imageSearchHistoryControllerDidUpdate:self];
}

@end
