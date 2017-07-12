//
//  WikipediaManager.h
//  FinalProject
//
//  Created by Akshay C Khanna on 29/06/2017.
//  Copyright © 2017 Akshay C Khanna. All rights reserved.
//
//

#import <Foundation/Foundation.h>

@interface WikipediaManager : NSObject

/*Fields*/

//OpenGL Number
@property float number;

//Singleton Array
@property (readonly, nonatomic) NSMutableArray *data;


/*Methods*/

//Singleton Method
+(instancetype)sharedManager;

+(instancetype)allocWithZone:(struct _NSZone *)zone;

-(instancetype)initPrivate;

- (id)copyWithZone:(NSZone *)zone;

//Fetch Data from Wikipedia
-(float)fetchDataFromSite:(NSString*) websiteName;

//Helper Method to fetchDataFromSite
-(float)parseFetchedDataOpenGL:(NSDictionary*) dict;

//Helper Method to parseFetchedDataOpenGL
-(float)numberFromString: (NSString*) passedString;

@end
