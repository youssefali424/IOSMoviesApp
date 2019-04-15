//
//  DetailService.h
//  finalProjectMovies
//
//  Created by youssef ali on 4/12/19.
//  Copyright © 2019 youssef ali. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkObserver.h"
#import "ServiceProtocol.h"
#import "../MVP Contract/ContactContract/ContactContract.h"
#import "NetworkManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailService : NSObject <NetworkObserver , ServiceProtocol , IDetailConatctManager>

@property id<IContactPresenter> contactPresenter;
@end

NS_ASSUME_NONNULL_END
