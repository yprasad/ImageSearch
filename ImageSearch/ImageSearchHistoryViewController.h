//
//  ImageSearchHistoryViewController.h
//  ImageSearch
//
//  Created by Yash Prasad on 8/5/15.
//  Copyright (c) 2015 Yash Prasad. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ImageSearchHistoryViewControllerDelegate;

@interface ImageSearchHistoryViewController : UITableViewController

@property (nonatomic, readwrite, weak) id<ImageSearchHistoryViewControllerDelegate> delegate;

@end

@protocol ImageSearchHistoryViewControllerDelegate <NSObject>

- (void)historyViewController:(ImageSearchHistoryViewController *)controller didSelectSearchWithString:(NSString *)searchString;

@end