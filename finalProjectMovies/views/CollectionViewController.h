//
//  CollectionViewController.h
//  finalProjectMovies
//
//  Created by youssef ali on 3/26/19.
//  Copyright © 2019 youssef ali. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../MVP Contract/ContactContract/ContactContract.h"

NS_ASSUME_NONNULL_BEGIN

@interface CollectionViewController : UICollectionViewController<IContactView,UICollectionViewDelegateFlowLayout>
@property NSArray *movies;
@end

NS_ASSUME_NONNULL_END
