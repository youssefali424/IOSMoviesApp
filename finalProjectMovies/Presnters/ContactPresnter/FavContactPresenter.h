//
//  FavContactPresenter.h
//  finalProjectMovies
//
//  Created by youssef ali on 4/10/19.
//  Copyright © 2019 youssef ali. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../../MVP Contract/ContactContract/ContactContract.h"
NS_ASSUME_NONNULL_BEGIN

@interface FavContactPresenter : NSObject<IFavContactPresenter>
@property id<IFavContactView> contactView;


-(instancetype) initWithContactView : (id<IFavContactView>) contactView;
@end

NS_ASSUME_NONNULL_END
