//
//  RLMObject+RlmDic.m
//  finalProjectMovies
//
//  Created by youssef ali on 4/7/19.
//  Copyright © 2019 youssef ali. All rights reserved.
//

#import "RLMObject+RlmDic.h"
#import "RLMObject.h"
#import <Realm.h>

@implementation RLMObject (NSDictionary)
- (NSDictionary*) dictionaryRepresentation{
    NSMutableDictionary *headerDictionary = [NSMutableDictionary dictionary];
    RLMObjectSchema *schema = self.objectSchema;
    for (RLMProperty *property in schema.properties) {
        if([self[property.name] isKindOfClass:[RLMArray class]]){
            NSMutableArray *arrayObjects = [[NSMutableArray alloc] init];
            RLMArray *currentArray = self[property.name];
            NSInteger numElements = [currentArray count];
            for(int i = 0; i<numElements; i++){
                [arrayObjects addObject:[[currentArray objectAtIndex:i] dictionaryRepresentation]];
            }
            headerDictionary[property.name] = arrayObjects;
        }else if([self[property.name] isKindOfClass:[RLMObject class]]){
            
            RLMObject * currentElement = self[property.name];
            headerDictionary[property.name] = [currentElement dictionaryRepresentation];
        }else{
            headerDictionary[property.name] = self[property.name];
        }
        
    }
    return headerDictionary;
}
-(void)doMigration{
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    // Set the new schema version. This must be greater than the previously used
    // version (if you've never set a schema version before, the version is 0).
    config.schemaVersion = 1;
    
    // Set the block which will be called automatically when opening a Realm with a
    // schema version lower than the one set above
    config.migrationBlock = ^(RLMMigration *migration, uint64_t oldSchemaVersion) {
        // We haven’t migrated anything yet, so oldSchemaVersion == 0
        if (oldSchemaVersion < 1) {
            // Nothing to do!
            // Realm will automatically detect new properties and removed properties
            // And will update the schema on disk automatically
        }
    };
    
    // Tell Realm to use this new configuration object for the default Realm
    [RLMRealmConfiguration setDefaultConfiguration:config];
    
    // Now that we've told Realm how to handle the schema change, opening the file
    // will automatically perform the migration
    [RLMRealm defaultRealm];
}
@end
