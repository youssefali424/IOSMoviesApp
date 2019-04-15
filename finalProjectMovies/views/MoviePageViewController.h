//
//  MoviePageViewController.h
//  finalProjectMovies
//
//  Created by youssef ali on 4/7/19.
//  Copyright © 2019 youssef ali. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../Presnters/ContactPresnter/ContactPresenter.h"
#import "../MVP Contract/ContactContract/ContactContract.h"
NS_ASSUME_NONNULL_BEGIN

@interface MoviePageViewController : UIViewController<IContactView,UITableViewDelegate,UITableViewDataSource>
@property ContactPresenter* contactPresenter;
@end

NS_ASSUME_NONNULL_END
