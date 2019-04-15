//
//  RLMObject+RlmDic.h
//  finalProjectMovies
//
//  Created by youssef ali on 4/7/19.
//  Copyright © 2019 youssef ali. All rights reserved.
//

#import "RLMObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface RLMObject (NSDictionary)
- (NSDictionary*) dictionaryRepresentation;
-(void)doMigration;
@end

NS_ASSUME_NONNULL_END
