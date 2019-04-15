//
//  ContactPresenter.h
//  MVPDemoObjective-C
//
//  Created by Mohamed Saeed on 3/23/19.
//  Copyright © 2019 ITI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../../MVP Contract/ContactContract/ContactContract.h"
#import "ContactService.h"


@interface ContactPresenter : NSObject <IContactPresenter>

@property id<IContactView> contactView;
@property NSString* searchType;
@property Boolean connected;
@property Boolean reset;

-(instancetype) initWithContactView : (id<IContactView>) contactView;

@end


