//
//  NetworkManager.h
//  MVPDemoObjective-C
//
//  Created by Mohamed Saeed on 3/23/19.
//  Copyright © 2019 ITI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkObserver.h"
#import "ServiceProtocol.h"


@interface NetworkManager : NSObject{
    
    
    NSMutableData *myData;
    
}


+(void) connectGetToURL : (NSString*) url serviceName : (NSString*) serviceName serviceProtocol : (id<ServiceProtocol>) serviceProtocol;
+(Boolean) checkNetworkState;
@end


