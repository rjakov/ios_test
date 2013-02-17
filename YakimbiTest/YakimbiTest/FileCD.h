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

@property (nonatomic, strong) NSString * created_date;
@property (nonatomic, strong) NSString * is_shared;
@property (nonatomic, strong) NSNumber * item_id;
@property (nonatomic, strong) NSString * last_updated_by;
@property (nonatomic, strong) NSString * last_updated_date;
@property (nonatomic, strong) NSString * link;
@property (nonatomic, strong) NSString * mime_type;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSNumber * parent_id;
@property (nonatomic, strong) NSString * path;
@property (nonatomic, strong) NSString * path_by_id;
@property (nonatomic, strong) NSString * share_id;
@property (nonatomic, strong) NSString * share_level;
@property (nonatomic, strong) NSNumber * shared_by;
@property (nonatomic, strong) NSString * shared_date;
@property (nonatomic, strong) NSNumber * size;
@property (nonatomic, strong) NSString * status;
@property (nonatomic, strong) NSString * type;
@property (nonatomic, strong) NSNumber * user_id;
@property (nonatomic, strong) MyFilesCD *myfiles;

@end
