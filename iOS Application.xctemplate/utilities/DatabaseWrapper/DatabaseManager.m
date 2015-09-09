//
//  DatabaseManager.m
//  Fitness
//
//  Created by Sagar Bhavsar on 4/2/14.
//  Copyright (c) 2014 MyPc. All rights reserved.
//

#import "DatabaseManager.h"

@implementation DatabaseManager

#pragma Database Basic Functions

+ (void) copyDatabaseIfNeeded {
    
    //Using NSFileManager we can perform many file system operations.
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    
    NSString *dbPath = [self getDBPath];
    NSLog(@"DBpath=%@",dbPath);
    BOOL success = [fileManager fileExistsAtPath:dbPath];
    
    if(!success) {
        
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:kDataBasePath];
        NSLog(@"defaultDBPath=%@",defaultDBPath);
        success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
        
        if (!success)
            NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
    }
    else
    {
        NSLog(@"Database file copied successfully.");
    }
}

+ (NSString *) getDBPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    return [documentsDir stringByAppendingPathComponent:kDataBaseName];
}

+ (BOOL) executeUpdate :(NSString*)query
{
    BOOL status;
    
   
    
    FMDatabase* db = [FMDatabase databaseWithPath:[self getDBPath]];
    [db open];
    
    [db beginTransaction];
    status =[db executeUpdate:query];
    
    if (!status) {
       NSLog(@"Error %@ - Error Code= %d", [db lastErrorMessage], [db lastErrorCode]);
        
        NSLog(@"Query Failed-- %@",query);
        
       
    }
    
    [db commit];
    
    [db close];
    
    return status;
    
}
+ (void) executeUpdateWithArray :(NSMutableArray*)arr :(NSString*)table_name :(NSString*)delete_column
{
    
    
    FMDatabase* db = [FMDatabase databaseWithPath:[self getDBPath]];
    [db open];
    
    [db beginTransaction];
    
    for(int i=0;i<arr.count;i++)
    {
        [db executeUpdate:[NSString stringWithFormat:@"Delete from %@ where %@=%@",table_name,delete_column,[[arr objectAtIndex:i] valueForKey:delete_column]]];
        [db executeUpdate:[DatabaseManager generateQueryFromDictionary:[arr objectAtIndex:i]:table_name]];
        
    }
    
    [db commit];
    
    [db close];
}
+(NSString*)generateQueryFromDictionary:(NSDictionary*)dict :(NSString*)table_name
{
    
    NSMutableArray* cols = [[NSMutableArray alloc] init];
    NSMutableArray* vals = [[NSMutableArray alloc] init];
    for (id key in dict) {
        [cols addObject:key];
        [vals addObject:[dict objectForKey:key]];
    }
    NSMutableArray* newCols = [[NSMutableArray alloc] init];
    NSMutableArray* newVals = [[NSMutableArray alloc] init];
    for (int i = 0; i<[cols count]; i++) {
        [newCols addObject:[NSString stringWithFormat:@"'%@'", [cols objectAtIndex:i]]];
        [newVals addObject:[NSString stringWithFormat:@"'%@'", [vals objectAtIndex:i]]];
    }
    NSString* sql = [NSString stringWithFormat:@"insert into %@ (%@) values (%@)", table_name,[newCols componentsJoinedByString:@", "], [newVals componentsJoinedByString:@", "]];
    NSLog(@"%@", sql);
    return sql;
    
}

+ (NSMutableArray*) executeQuery :(NSString*)query
{
    NSMutableArray *array = [NSMutableArray array];
    
    FMDatabase* db = [FMDatabase databaseWithPath:[self getDBPath]];
    
    [db open];
    
    FMResultSet* rs = [db executeQuery:query];
    while ([rs next]) {
        [array addObject:[rs resultDictionary]];
    }
    
    if(array.count==0 && [db lastErrorCode]!=0)
    {
        
            NSLog(@"Error %@ - Error Code= %d", [db lastErrorMessage], [db lastErrorCode]);
            
            NSLog(@"Query Failed-- %@",query);
        
    }
    
    [rs close];
    [db close];
    
    
    return array;
    
}

#define Custom Methods

+(NSMutableArray *)getAll :(NSString *)query
{
    return [DatabaseManager executeQuery:query];
}

@end
