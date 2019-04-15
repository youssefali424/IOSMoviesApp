//
//  FavouritesCollectionViewController.h
//  finalProjectMovies
//
//  Created by youssef ali on 4/7/19.
//  Copyright © 2019 youssef ali. All rights reserved.
//

#import "CollectionViewController.h"
#import "../POJO/Favourite.h"
NS_ASSUME_NONNULL_BEGIN

@interface FavouritesCollectionViewController : CollectionViewController<IFavContactView>

@property RLMResults<Favourite *> * FavMovies;

@end

NS_ASSUME_NONNULL_END
