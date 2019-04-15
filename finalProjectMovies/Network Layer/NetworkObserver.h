//
//  NetworkObserver.h
//  MVPDemoObjective-C
//
//  Created by Mohamed Saeed on 3/23/19.
//  Copyright © 2019 ITI. All rights reserved.
//

#import <Foundation/Foundation.h>



@protocol NetworkObserver <NSObject>

-(void) handleSuccessWithJSONData : (id) jsonData : (NSString*) serviceName;
-(void) handleFailWithErrorMessage : (NSString*) errorMessage;

@end


