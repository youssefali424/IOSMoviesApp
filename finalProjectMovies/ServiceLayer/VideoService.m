//
//  VideoService.m
//  finalProjectMovies
//
//  Created by youssef ali on 4/13/19.
//  Copyright © 2019 youssef ali. All rights reserved.
//

#import "VideoService.h"

@implementation VideoService

- (void)getConatct:(id<IVideoContactPresenter>)contactPresenter {
    NSString *key = [[NSUserDefaults standardUserDefaults] stringForKey:@"VideoKey"];
    [contactPresenter onKeyRetrieve:key];
    
}
    
    @end
