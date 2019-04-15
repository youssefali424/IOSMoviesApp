//
//  FavService.m
//  finalProjectMovies
//
//  Created by youssef ali on 4/10/19.
//  Copyright © 2019 youssef ali. All rights reserved.
//

#import "FavService.h"
#import <Realm.h>
#import "../POJO/Favourite.h"
#import "../POJO/Movie.h"
#import "RLMObject+RlmDic.h"

@implementation FavService

- (void)getFavMovies : (id<IFavContactPresenter>) contactPresenter{
    
    
    RLMResults<Favourite *> *saved = [Favourite allObjects];
    [contactPresenter onSuccess:saved];
}
-(void) saveMovie:(Movie*)movie{
    //    NSDictionary* dic=[self dictionaryWithPropertiesOfObject:movie];
    
    
    NSDictionary* dic=[movie dictionaryRepresentation];
    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"currentMovie"];
    
    NSLog(@"%@", dic);
}
-(void) removeFavourites{
    
    RLMResults<Favourite *> *saved = [Favourite allObjects];
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm transactionWithBlock:^{
        for(Favourite *fav in saved)
            [realm deleteObject:fav];
    }];
    
    
}
@end
