//
//  BaseContract.h
//  MVPDemoObjective-C
//
//  Created by Mohamed Saeed on 3/23/19.
//  Copyright © 2019 ITI. All rights reserved.
//

#import <Foundation/Foundation.h>



@protocol IBaseView <NSObject>

-(void) showLoading;
-(void) hideLoading;
-(void) showErrorMessage : (NSString*) errorMessage;

@end


