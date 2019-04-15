//
//  VideoViewController.h
//  finalProjectMovies
//
//  Created by youssef ali on 4/13/19.
//  Copyright © 2019 youssef ali. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../MVP Contract/ContactContract/ContactContract.h"
NS_ASSUME_NONNULL_BEGIN

@interface VideoViewController : UIViewController<IVideoContactView>
    @property id<IVideoContactPresenter> presenter;
@end

NS_ASSUME_NONNULL_END
