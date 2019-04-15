//
//  ContactPresenter.m
//  MVPDemoObjective-C
//
//  Created by Mohamed Saeed on 3/23/19.
//  Copyright © 2019 ITI. All rights reserved.
//

#import "ContactPresenter.h"
#import "../../POJO/Movie.h"
#import "../../ServiceLayer/DetailService.h"
@implementation ContactPresenter


-(instancetype)initWithContactView:(id<IContactView>)contactView{
    
    
    self = [super init];
    
    if (self) {
        
        _contactView = contactView;
        _reset=false;
        _searchType=@"popularity.desc";
    }
    
    
    return self;
    
}

-(void)setSearchTypeWithIndex:(NSUInteger)index{
    switch(index){
        case 0:
            _searchType=@"popularity.desc";
            break;
        case 1:
            _searchType=@"release_date.desc";
            break;
        case 2:
            _searchType=@"vote_average.desc";
            break;
        default:
            break;
    }
    _reset=true;
    
}
-(void)getContact:(int) page{
    
    [_contactView showLoading];
    
    ContactService *contactService = [ContactService new];
    [contactService getConatct:self:page:_searchType];
    
}
-(void) addFavourite:(Movie*)movie{
    ContactService *contactService = [ContactService new];
    [contactService addFavourite:movie];
}
-(void) checkNetwork{
    ContactService *contactService = [ContactService new];
    _connected=[contactService checkNetworkState];
}
-(void) saveMovie:(Movie*)movie{
    ContactService *contactService = [ContactService new];
    [contactService saveMovie:movie];
}
-(void) getCurrentMovie{
    ContactService *contactService = [ContactService new];
    [contactService setContactPresenter:self];
    [contactService getMovie];
}
-(void) checkFav:(NSInteger)movieId{
    ContactService *contactService = [ContactService new];
    [contactService setContactPresenter:self];
    [contactService checkFav:movieId];
}
-(void) setFavBtn{
    [_contactView setFavBtn];
}
-(void) gotCurrentMovie:(Movie*)movie{
    [_contactView addCurrentMovie:movie];
}
-(void)onSuccess:(NSArray *)movies{
    if(_reset){
        [_contactView resetViewArray];
        _reset=false;
    }
    [_contactView renderContactWithObject:movies];
    [_contactView hideLoading];
    
}
- (void)saveKey:(NSString *)key{
    ContactService *contactService = [ContactService new];
    [contactService setContactPresenter:self];
    [contactService saveKey:key];
}

- (void)onFail:(NSString *)errorMessage{
    
    [_contactView showErrorMessage:errorMessage];
    [_contactView hideLoading];
}
-(void) removeFavourite:(NSInteger)movieId{
    ContactService *contactService = [ContactService new];
    [contactService setContactPresenter:self];
    [contactService removeFavourite:movieId];
}
-(void) removeFavourites{
    ContactService *contactService = [ContactService new];
    [contactService setContactPresenter:self];
    [contactService removeFavourites];
}
-(void) getDetail:(NSInteger) movId{
    DetailService *service=[DetailService new];
    [service getConatct:self :movId];
}
-(void) onSuccessTrailers :(NSArray*) trailer{
    [_contactView onSuccessTrailers:trailer];
}
-(void) onSuccessReviews :(NSArray*) reviews{
    [_contactView onSuccessReviews:reviews];
}
@end
