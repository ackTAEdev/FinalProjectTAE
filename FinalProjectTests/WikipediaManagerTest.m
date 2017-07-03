//
//  WikipediaManagerTest.m
//  FinalProject
//
//  Created by Akshay C Khanna on 03/07/2017.
//  Copyright © 2017 Akshay C Khanna. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WikipediaManager.h"

@interface WikipediaManagerTest : XCTestCase

@end

@implementation WikipediaManagerTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


#pragma -mark testWebService
/**
 Method: testfetchDataFromSiteWithPerformance
 
 Description:
 - Tests the method if succesfully true or false
 */
-(void) testfetchDataFromSiteWithPerformance{
    
    //Given
    WikipediaManager *wikipediaManagerObj = [[WikipediaManager alloc] init];
    NSString *urlString = @"TODO";
    float floatAssert = 4;
    
    [self measureBlock:^{
        
    //When
    float floatResult = [wikipediaManagerObj fetchDataFromSite:urlString];
        
    //Then
    XCTAssertEqual(floatResult, floatAssert);
    
    }];
}

#pragma -mark numberFromString
/**
 Method: testNumberFromString
 
 Description:
 - Tests the method if succesfully true or false
 */
-(void) testNumberFromString{
    
    //Given
    WikipediaManager *wikipediaManagerObj = [[WikipediaManager alloc] init];
    NSString *urlString = @"Test Text 4";
    float floatAssert = 4;
    
    //When
    float floatResult = [wikipediaManagerObj numberFromString:urlString];
        
    //Then
    XCTAssertEqual(floatResult, floatAssert);
}

@end
