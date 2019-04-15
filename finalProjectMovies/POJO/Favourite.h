//
//  Favourite.h
//  finalProjectMovies
//
//  Created by youssef ali on 4/8/19.
//  Copyright © 2019 youssef ali. All rights reserved.
//

#import "RLMObject.h"
#import "Movie.h"
NS_ASSUME_NONNULL_BEGIN

@interface Favourite : RLMObject
@property NSInteger movID;
@property Movie* movie;
@end

NS_ASSUME_NONNULL_END
