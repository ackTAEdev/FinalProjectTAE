//
//  TabOneVCTest.m
//  FinalProject
//
//  Created by Akshay C Khanna on 03/07/2017.
//  Copyright © 2017 Akshay C Khanna. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TabOneVC.h"


@interface TabOneVCTest : XCTestCase

@end

@implementation TabOneVCTest

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
 Method: testWebService
 
 Description:
 - Tests the method if succesfully true or false
 */
- (void)testWebService {
    
    //Given
    TabOneVC *tabOneVCObj = [[TabOneVC alloc] init];
    
    //When
    bool trueValue = [tabOneVCObj setupWebServiceWikipediaOpenGLVersion];
    
    //Then
    XCTAssertTrue(trueValue);
}

#pragma -mark testFetchDataFromCoreData
/**
 Method: testFetchDataFromCoreData
 
 Description:
 - Tests the method if succesfully true or false
 */
- (void)testFetchDataFromCoreData {
    
    //Given
    TabOneVC *tabOneVCObj = [[TabOneVC alloc] init];
    
    //When
    bool trueValue = [tabOneVCObj fetchDataFromCoreData];
    
    //Then
    XCTAssertTrue(trueValue);
}


#pragma -mark testSaveDataToCoreData
/**
 Method: testSaveDataToCoreData
 
 Description:
 - Tests the method if succesfully true or false
 */
- (void)testSaveDataToCoreData {
    
    //Given
    TabOneVC *tabOneVCObj = [[TabOneVC alloc] init];
    
    //When
    bool trueValue = [tabOneVCObj saveDataToCoreData];
    
    //Then
    XCTAssertTrue(trueValue);
}

@end
