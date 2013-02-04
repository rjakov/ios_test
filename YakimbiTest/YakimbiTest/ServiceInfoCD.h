//
//  ServiceInfoCD.h
//  YakimbiTest
//
//  Created by iteaman on 03.02.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ServiceInfoCD : NSManagedObject

@property (nonatomic, retain) NSNumber * availableSpace;
@property (nonatomic, retain) NSNumber * last_rev_id;
@property (nonatomic, retain) NSString * mode;
@property (nonatomic, retain) NSNumber * pendingRequests;
@property (nonatomic, retain) NSNumber * totalSpace;
@property (nonatomic, retain) NSNumber * usedSpace;

@end
