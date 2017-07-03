//
//  TabTwoVCTest.m
//  FinalProject
//
//  Created by Akshay C Khanna on 03/07/2017.
//  Copyright © 2017 Akshay C Khanna. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TabTwoVC.h"

@interface TabTwoVCTest : XCTestCase

@end

@implementation TabTwoVCTest

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
- (void)testFetchDataFromCoreData {
    
    //Given
    TabTwoVC *tabTwoVCCObj = [[TabTwoVC alloc] init];
    
    //When
    bool trueValue = [tabTwoVCCObj fetchDataFromCoreData];
    
    //Then
    XCTAssertTrue(trueValue);
    
}

@end
