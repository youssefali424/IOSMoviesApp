//
//  VideoPresenter.h
//  finalProjectMovies
//
//  Created by youssef ali on 4/13/19.
//  Copyright © 2019 youssef ali. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../../MVP Contract/ContactContract/ContactContract.h"
NS_ASSUME_NONNULL_BEGIN

@interface VideoPresenter : NSObject<IVideoContactPresenter>
    @property id<IVideoContactView> myView;
@end

NS_ASSUME_NONNULL_END
