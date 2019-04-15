//
//  DetailService.m
//  finalProjectMovies
//
//  Created by youssef ali on 4/12/19.
//  Copyright © 2019 youssef ali. All rights reserved.
//

#import "DetailService.h"
#import <OCMapper.h>
#import "../POJO/MovieTrailer.h"
#import "../POJO/MovieReview.h"

static NSString  * const trailerService=@"Trailer";
static NSString  * const reviewService=@"Reviews";
@implementation DetailService


- (void)handleFailWithErrorMessage:(NSString *)errorMessage {
    NSLog(@"%@", errorMessage);
}

- (void)handleSuccessWithJSONData:(id)jsonData :(NSString *)serviceName {
    NSDictionary *dict = (NSDictionary*)jsonData;
    if(serviceName==trailerService){
        
        //NSArray *contactsArray = [dict objectForKey:@"contacts"];
        NSArray *trailers = [MovieTrailerResult objectFromDictionary:[dict objectForKey:@"results" ]];
        
        
        [_contactPresenter onSuccessTrailers:trailers];
        
        
    }
    else if(serviceName==reviewService){
        NSArray *reviews = [MovieReviewResult objectFromDictionary:[dict objectForKey:@"results" ] ];
        
        
        [_contactPresenter onSuccessReviews : reviews];
    }
}

- (void)getConatct:(id<IContactPresenter>)contactPresenter :(NSInteger)movID{
    _contactPresenter=contactPresenter;
    NSString *urlTrailer=[NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/%ld/videos?api_key=3ff21da85f3e64c5e2464208e40b892e&language=en-US",movID];
    
    NSString *url=[NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/%ld/reviews?api_key=3ff21da85f3e64c5e2464208e40b892e&language=en-US&page=1",movID];
    [NetworkManager connectGetToURL:urlTrailer serviceName:@"Trailer" serviceProtocol:self];
    [NetworkManager connectGetToURL:url serviceName:@"Reviews" serviceProtocol:self];
}

@end
