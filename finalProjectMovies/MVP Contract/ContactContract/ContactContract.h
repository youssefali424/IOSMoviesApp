//
//  ContactContract.h
//  MVPDemoObjective-C
//
//  Created by Mohamed Saeed on 3/23/19.
//  Copyright © 2019 ITI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../Base Contract/BaseContract.h"
#import "../../POJO/Movie.h"
#import "../../POJO/Favourite.h"

@protocol IContactView <IBaseView>
@optional
-(void) renderContactWithObject : (NSArray *) movies;
-(void) resetViewArray;
-(void) addCurrentMovie : (Movie*) movie;
-(void) setFavBtn;
-(void) onSuccessTrailers :(NSArray*) trailer;
-(void) onSuccessReviews :(NSArray*) reviews;
@end

@protocol IFavContactView <IBaseView>

-(void) renderFavContactWithObject : (RLMResults<Favourite *> *) FavMovies;

@end
@protocol IVideoContactView
    
-(void) renderVideoContactWithObject :(NSString*)key;
    
@end


@protocol IContactPresenter <NSObject>

-(void) getContact:(int) page;
-(void) onSuccess : (NSArray*) movies;
-(void) onFail : (NSString*) errorMessage;
-(void) setSearchTypeWithIndex:(NSUInteger)index;
-(void) checkNetwork;
-(void) saveMovie:(Movie*)movie;
-(void) getCurrentMovie;
-(void) gotCurrentMovie:(Movie*)movie;
-(void) addFavourite:(Movie*)movie;
-(void) checkFav:(NSInteger)movieId;
-(void) setFavBtn;
-(void) removeFavourites;
-(void) removeFavourite:(NSInteger)movieId;
-(void) onSuccessTrailers :(NSArray*) trailer;
-(void) onSuccessReviews :(NSArray*) reviews;
-(void) getDetail:(NSInteger) movId;
    -(void) saveKey:(NSString*)key;
@end
@protocol IFavContactPresenter <NSObject>
-(void) getContact;
-(void) onSuccess : (RLMResults<Favourite *> *) FavMovies;
-(void) saveMovie:(Movie*)movie;
-(void) removeFavourites;
@end
@protocol IVideoContactPresenter <NSObject>
    -(void) getContact:(id<IVideoContactView>)sourceView;
    -(void) onKeyRetrieve:(NSString*)key;
@end
@protocol IFavConatctManager <NSObject>
-(void) getFavMovies : (id<IFavContactPresenter>) contactPresenter;
-(void) saveMovie:(Movie*)movie;
-(void) removeFavourites;
@end

@protocol IDetailConatctManager <NSObject>
-(void) getConatct : (id<IContactPresenter>) contactPresenter :(NSInteger)movID;
@end

@protocol IVideoConatctManager <NSObject>
-(void) getConatct : (id<IVideoContactPresenter>) contactPresenter ;
    @end

@protocol IConatctManager <NSObject>

-(void) getConatct : (id<IContactPresenter>) contactPresenter :(int) page :(NSString*)search;
-(Boolean) checkNetworkState;
-(void) saveMovie:(Movie*)movie;
-(void) getMovie;
-(void) removeFavourite:(NSInteger)movieId;
-(void) addFavourite:(Movie*)movie;
-(void) checkFav:(NSInteger)movieId;
-(void) removeFavourites;
-(void) saveKey:(NSString*)key;
@end
