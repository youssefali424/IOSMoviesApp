//
//  Movie.h
//  MVPDemoObjective-C
//
//  Created by youssef ali on 3/25/19.
//  Copyright © 2019 ITI. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <Realm.h>

@class Movie;
@class MovieGenre;
@class MovieProductionCompany;
@class MovieProductionCountry;
@class MovieSpokenLanguage;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Object interfaces


@interface MovieGenre : RLMObject
@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, copy)   NSString *name;
@end
RLM_ARRAY_TYPE(MovieGenre)

@interface MovieProductionCompany : RLMObject
@property (nonatomic, assign)         NSInteger identifier;
@property (nonatomic, nullable, copy) NSString *logoPath;
@property (nonatomic, copy)           NSString *name;
@property (nonatomic, copy)           NSString *originCountry;
@end
RLM_ARRAY_TYPE(MovieProductionCompany)
@interface MovieProductionCountry : RLMObject
@property (nonatomic, copy) NSString *iso3166_1;
@property (nonatomic, copy) NSString *name;
@end
RLM_ARRAY_TYPE(MovieProductionCountry)
@interface MovieSpokenLanguage : RLMObject
@property (nonatomic, copy) NSString *iso639_1;
@property (nonatomic, copy) NSString *name;
@end
RLM_ARRAY_TYPE(MovieSpokenLanguage)

@interface Movie : RLMObject
    @property (nonatomic, assign)         BOOL isAdult;
    @property (nonatomic, assign)         BOOL isFavourite;
    @property (nonatomic, copy)           NSString *backdropPath;
    @property (nonatomic, nullable, copy) NSString *belongsToCollection;
    @property (nonatomic, assign)         NSInteger budget;
    @property          RLMArray<MovieGenre *><MovieGenre> *genres;
    @property (nonatomic, copy)           NSString *homepage;
    @property (nonatomic, assign)         NSInteger identifier;
    @property (nonatomic, copy)           NSString *imdbID;
    @property (nonatomic, copy)           NSString *originalLanguage;
    @property (nonatomic, copy)           NSString *originalTitle;
    @property (nonatomic, copy)           NSString *overview;
    @property (nonatomic, assign)         double popularity;
    @property (nonatomic, copy)           NSString *posterPath;
    @property        RLMArray<MovieProductionCompany *><MovieProductionCompany> *productionCompanies;
    @property        RLMArray<MovieProductionCountry *><MovieProductionCountry> *productionCountries;
    @property (nonatomic, copy)           NSString *releaseDate;
    @property (nonatomic, assign)         NSInteger revenue;
    @property (nonatomic, assign)         NSInteger movId;
    @property (nonatomic, assign)         NSInteger runtime;
    @property       RLMArray<MovieSpokenLanguage *><MovieSpokenLanguage> *spokenLanguages;
    @property (nonatomic, copy)           NSString *status;
    @property (nonatomic, copy)           NSString *tagline;
    @property (nonatomic, copy)           NSString *title;
    @property (nonatomic, assign)         BOOL isVideo;
    @property (nonatomic, assign)         double voteAverage;
    @property (nonatomic, assign)         NSInteger voteCount;

    @end
RLM_ARRAY_TYPE(Movie)
NS_ASSUME_NONNULL_END
