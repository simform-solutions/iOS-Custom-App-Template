//
//  DatabaseManager.h
//  Fitness
//
//  Created by Sagar Bhavsar on 4/2/14.
//  Copyright (c) 2014 MyPc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

#define kDataBaseName @"tekkies.sqlite"
#define kDataBasePath @"tekkies.sqlite"



@interface DatabaseManager : NSObject


+ (void) copyDatabaseIfNeeded;
+ (NSString *) getDBPath;
+ (BOOL) executeUpdate :(NSString*)query;
+ (NSMutableArray*) executeQuery :(NSString*)query;
+ (void) executeUpdateWithArray :(NSMutableArray*)arr :(NSString*)table_name :(NSString*)delete_column;

#define Custom Methods
+(NSMutableArray *)getAll :(NSString *)query;

@end
