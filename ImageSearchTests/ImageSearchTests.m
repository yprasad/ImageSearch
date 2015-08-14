//
//  ImageSearchTests.m
//  ImageSearchTests
//
//  Created by Yash Prasad on 8/5/15.
//  Copyright (c) 2015 Yash Prasad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "ImageSearchSearchController.h"
#import "ImageSearchPhoto.h"

@interface ImageSearchTests : XCTestCase
{
  ImageSearchSearchController *_searchController;
}

@end

@implementation ImageSearchTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
  _searchController = [[ImageSearchSearchController alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  _searchController = nil;
    [super tearDown];
}

- (void)testSuccess {
  __block NSArray *photos = nil;
  
  XCTestExpectation *expectation = [self expectationWithDescription:@"Search comes back successfully with images"];
  
  [_searchController searchGoogleImagesWithString:@"Michael Jordan" page:1 successCallback:^(NSArray *results) {
    XCTAssert(YES, @"Success callback passed");
   [expectation fulfill];
    photos = results;
  } failureCallback:nil noMoreImagesCallback:nil];
  
  for (ImageSearchPhoto *photo in photos) {
    XCTestExpectation *thumbnailURLExpectation = [self expectationWithDescription:@"valid thumbnail URL"];
    XCTestExpectation *thumbnailSizeExpectation = [self expectationWithDescription:@"valid thumbnail size"];
    XCTestExpectation *urlExpectation = [self expectationWithDescription:@"valid URL"];
    XCTestExpectation *sizeExpectation = [self expectationWithDescription:@"valid size"];
    
    if ([[photo thumbnailURLString] length] > 0) {
      XCTAssert(YES, @"Received photo with valid thumbnail URL");
      [thumbnailURLExpectation fulfill];
    }
    
    if (!(CGSizeEqualToSize(photo.thumbnailSize, CGSizeZero))) {
      XCTAssert(YES, @"Received photo with valid thumbnail size");
      [thumbnailSizeExpectation fulfill];
    }
    
    if ([[photo urlString] length] > 0) {
      XCTAssert(YES, @"Received photo with valid URL");
      [urlExpectation fulfill];
    }
    
    if (!(CGSizeEqualToSize(photo.size, CGSizeZero))) {
      XCTAssert(YES, @"Received photo with valid thumbnail size");
      [sizeExpectation fulfill];
    }
  }
  
  [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

- (void)testNoMoreImages {
  XCTestExpectation *expectation = [self expectationWithDescription:@"Search comes back with no more images"];
  
  [_searchController searchGoogleImagesWithString:@"Michael Jordan" page:8 successCallback:nil failureCallback:nil noMoreImagesCallback:^{
    XCTAssert(YES, @"No more images callback passed");
    [expectation fulfill];
  }];
  
  [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

@end
