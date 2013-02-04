//
//  FileCD.h
//  YakimbiTest
//
//  Created by iteaman on 04.02.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MyFilesCD;

@interface FileCD : NSManagedObject

@property (nonatomic, retain) NSString * created_date;
@property (nonatomic, retain) NSString * is_shared;
@property (nonatomic, retain) NSNumber * item_id;
@property (nonatomic, retain) NSString * last_updated_by;
@property (nonatomic, retain) NSString * last_updated_date;
@property (nonatomic, retain) NSString * link;
@property (nonatomic, retain) NSString * mime_type;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * parent_id;
@property (nonatomic, retain) NSString * path;
@property (nonatomic, retain) NSString * path_by_id;
@property (nonatomic, retain) NSString * share_id;
@property (nonatomic, retain) NSString * share_level;
@property (nonatomic, retain) NSNumber * shared_by;
@property (nonatomic, retain) NSString * shared_date;
@property (nonatomic, retain) NSNumber * size;
@property (nonatomic, retain) NSString * status;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSNumber * user_id;
@property (nonatomic, retain) MyFilesCD *myfiles;

@end
