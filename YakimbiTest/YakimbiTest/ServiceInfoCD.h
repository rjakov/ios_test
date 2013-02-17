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

@property (nonatomic, strong) NSNumber * availableSpace;
@property (nonatomic, strong) NSNumber * last_rev_id;
@property (nonatomic, strong) NSString * mode;
@property (nonatomic, strong) NSNumber * pendingRequests;
@property (nonatomic, strong) NSNumber * totalSpace;
@property (nonatomic, strong) NSNumber * usedSpace;

@end
