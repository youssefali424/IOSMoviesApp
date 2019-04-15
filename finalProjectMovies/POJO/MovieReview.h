//
//  MovieReview.h
//  finalProjectMovies
//
//  Created by youssef ali on 4/12/19.
//  Copyright © 2019 youssef ali. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MovieReview;
@class MovieReviewResult;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Object interfaces

@interface MovieReview : NSObject
@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, copy)   NSArray<MovieReviewResult *> *results;
@property (nonatomic, assign) NSInteger totalPages;
@property (nonatomic, assign) NSInteger totalResults;
@end

@interface MovieReviewResult : NSObject
@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *url;
@end

NS_ASSUME_NONNULL_END

