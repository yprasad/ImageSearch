//
//  ImageSearchPhoto.h
//  ImageSearch
//
//  Created by Yash Prasad on 8/5/15.
//  Copyright (c) 2015 Yash Prasad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageSearchPhoto : NSObject

@property (nonatomic, readwrite, strong) NSString *thumbnailURLString;
@property (nonatomic, readwrite, assign) CGSize thumbnailSize;
@property (nonatomic, readwrite, strong) NSString *urlString;
@property (nonatomic, readwrite, assign) CGSize size;

@end
