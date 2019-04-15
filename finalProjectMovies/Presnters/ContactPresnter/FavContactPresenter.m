//
//  FavContactPresenter.m
//  finalProjectMovies
//
//  Created by youssef ali on 4/10/19.
//  Copyright © 2019 youssef ali. All rights reserved.
//

#import "FavContactPresenter.h"
#import "../../ServiceLayer/FavService.h"

@implementation FavContactPresenter
-(instancetype)initWithContactView:(id<IFavContactView>)contactView{
    
    
    self = [super init];
    
    if (self) {
        
        _contactView = contactView;
        
    }
    
    
    return self;
    
}
- (void)getContact {
    FavService *contactService = [FavService new];
    [contactService getFavMovies:self];
}
-(void) saveMovie:(Movie*)movie{
    FavService *contactService = [FavService new];
    [contactService saveMovie:movie];
}
-(void) removeFavourites{
    FavService *contactService = [FavService new];
    [contactService setContactPresenter:self];
    [contactService removeFavourites];
}
- (void)onSuccess:(RLMResults<Favourite *> *)FavMovies {
    [_contactView renderFavContactWithObject:FavMovies];
}

@end
