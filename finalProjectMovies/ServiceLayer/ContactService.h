//
//  ContactService.h
//  MVPDemoObjective-C
//
//  Created by Mohamed Saeed on 3/23/19.
//  Copyright © 2019 ITI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkObserver.h"
#import "ServiceProtocol.h"
#import "../MVP Contract/ContactContract/ContactContract.h"
#import "NetworkManager.h"



@interface ContactService : NSObject <NetworkObserver , ServiceProtocol , IConatctManager>

@property id<IContactPresenter> contactPresenter;



@end


