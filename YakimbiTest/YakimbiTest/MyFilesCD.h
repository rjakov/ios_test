//
//  MyFilesCD.h
//  YakimbiTest
//
//  Created by iteaman on 03.02.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class FileCD;

@interface MyFilesCD : NSManagedObject

@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *files;
@end

@interface MyFilesCD (CoreDataGeneratedAccessors)

- (void)addFilesObject:(FileCD *)value;
- (void)removeFilesObject:(FileCD *)value;
- (void)addFiles:(NSSet *)values;
- (void)removeFiles:(NSSet *)values;
@end
