//
//  VideoPresenter.m
//  finalProjectMovies
//
//  Created by youssef ali on 4/13/19.
//  Copyright © 2019 youssef ali. All rights reserved.
//

#import "VideoPresenter.h"

#import "../../ServiceLayer/VideoService.h"
#import "../../MVP Contract/ContactContract/ContactContract.h"
@implementation VideoPresenter

    
- (void)getContact :(id<IVideoContactView>)sourceView{
    _myView=sourceView;
    VideoService *service=[VideoService new];
    [service getConatct:self];
    
}
    
- (void)onKeyRetrieve:(NSString *)key {
    [_myView renderVideoContactWithObject:key];
}
    
    @end
