//
//  ContactService.m
//  MVPDemoObjective-C
//
//  Created by Mohamed Saeed on 3/23/19.
//  Copyright © 2019 ITI. All rights reserved.
//

#import "ContactService.h"
#import <OCMapper.h>
#import "../POJO/Movie.h"
#import <objc/runtime.h>
#import "RLMObject+RlmDic.h"
#import "../POJO/Favourite.h"
@implementation ContactService


-(void)getConatct:(id<IContactPresenter>)contactPresenter :(int) page :(NSString*)search{
//    RLMResults<Favourite *> *saved = [Movie allObjects];
//    RLMRealm *realm = [RLMRealm defaultRealm];
//
//    [realm transactionWithBlock:^{
//        for (NSInteger i = 0; i < [saved count]; i++) {
//            [realm deleteObject:saved[i]];
//
//        }
    
        // [realm addObject:self->_movies[indexPath.row]];
//    }];
    
    _contactPresenter = contactPresenter;
    
    NSString *url=[NSString stringWithFormat:@"https://api.themoviedb.org/3/discover/movie?sort_by=%@&api_key=3ff21da85f3e64c5e2464208e40b892e&page=%d",search,page];
    
    [NetworkManager connectGetToURL:url serviceName:@"ContactService" serviceProtocol:self];
}


-(void)handleSuccessWithJSONData:(id)jsonData :(NSString *)serviceName{
    
    
    if ([serviceName isEqualToString:@"ContactService"]) {
        
        NSDictionary *dict = (NSDictionary*)jsonData;
        InCodeMappingProvider *inCodeMappingProvider=[[InCodeMappingProvider alloc] init];
        [inCodeMappingProvider mapFromDictionaryKey:@"id" toPropertyKey:@"movId" forClass:[Movie class]];
        [[ObjectMapper sharedInstance] setMappingProvider:inCodeMappingProvider];
        //NSArray *contactsArray = [dict objectForKey:@"contacts"];
        NSArray *movies = [Movie objectFromDictionary:[dict objectForKey:@"results"]];
        
        
        
        [_contactPresenter onSuccess:movies];
        
        
    }
    
    
}


-(void)handleFailWithErrorMessage:(NSString *)errorMessage{
    
    
    [_contactPresenter onFail:errorMessage];
    
}
-(Boolean) checkNetworkState{
    return [NetworkManager checkNetworkState];
}
-(void) saveMovie:(Movie*)movie{
//    NSDictionary* dic=[self dictionaryWithPropertiesOfObject:movie];
    
    
    NSDictionary* dic=[movie dictionaryRepresentation];
    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"currentMovie"];
    
}
- (void)saveKey:(NSString *)key{
    
     [[NSUserDefaults standardUserDefaults] setObject:key forKey:@"VideoKey"];
    
}
-(void) getMovie{
    NSDictionary *retrievedDictionary = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"currentMovie"];
    Movie *movie=[Movie objectFromDictionary:retrievedDictionary];
    [_contactPresenter gotCurrentMovie:movie];
}
-(void) removeFavourite:(NSInteger)movieId{
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"movID = %ld" ,movieId];
    RLMResults<Favourite *> *saved = [Favourite objectsWithPredicate:pred];
    RLMRealm *realm = [RLMRealm defaultRealm];
    if(saved.count!=0){
    [realm transactionWithBlock:^{
        [realm deleteObject:[saved firstObject]];
       // [realm addObject:self->_movies[indexPath.row]];
    }];
    
    }
    //RLMResults<Movie *> *saved = [Movie objectsWhere:@"movie.id = 'tan' AND name BEGINSWITH 'B'"];
}
-(void) removeFavourites{
    
    RLMResults<Favourite *> *saved = [Favourite allObjects];
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm transactionWithBlock:^{
        for(Favourite *fav in saved)
        [realm deleteObject:fav];
        // [realm addObject:self->_movies[indexPath.row]];
    }];
    
    
    //RLMResults<Movie *> *saved = [Movie objectsWhere:@"movie.id = 'tan' AND name BEGINSWITH 'B'"];
}
-(void) checkFav:(NSInteger)movieId{
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"movID = %ld",(long)movieId];
    RLMResults<Favourite *> *saved = [Favourite objectsWithPredicate:pred];
    if([saved count]!=0){
        [_contactPresenter setFavBtn];
    }
}
-(void) addFavourite:(Movie*)movie
{
    RLMRealm *realm = [RLMRealm defaultRealm];
    Favourite *fav=[Favourite new];
    fav.movie=movie;
    fav.movID=movie.movId;
    [realm transactionWithBlock:^{
        
        [realm addObject:fav];
    }];
    
}
- (NSDictionary *) dictionaryWithPropertiesOfObject:(id)obj
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([obj class], &count);
    
    for (int i = 0; i < count; i++) {
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
        [dict setObject:[obj valueForKey:key] forKey:key];
    }
    
    free(properties);
    
    return [NSDictionary dictionaryWithDictionary:dict];
}
@end
