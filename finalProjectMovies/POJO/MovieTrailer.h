//
//  MovieTrailer.h
//  finalProjectMovies
//
//  Created by youssef ali on 4/12/19.
//  Copyright © 2019 youssef ali. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MovieTrailer;
@class MovieTrailerResult;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Object interfaces

@interface MovieTrailer : NSObject
@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, copy)   NSArray<MovieTrailerResult *> *results;
@end

@interface MovieTrailerResult : NSObject
@property (nonatomic, copy)   NSString *identifier;
@property (nonatomic, copy)   NSString *iso639_1;
@property (nonatomic, copy)   NSString *iso3166_1;
@property (nonatomic, copy)   NSString *key;
@property (nonatomic, copy)   NSString *name;
@property (nonatomic, copy)   NSString *site;
@property (nonatomic, assign) NSInteger size;
@property (nonatomic, copy)   NSString *type;
@end

NS_ASSUME_NONNULL_END
