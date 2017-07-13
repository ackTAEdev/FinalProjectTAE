//
//  WikipediaManager.m
//  FinalProject
//
//  Created by Akshay C Khanna on 29/06/2017.
//  Copyright © 2017 Akshay C Khanna. All rights reserved.
//

#import "WikipediaManager.h"

@implementation WikipediaManager

#pragma mark - sharedManager
/**
 Method: sharedManager
 
 Description
 - Method to Force Singleton Behaviour
 
 @return Singleton
 */
+(instancetype)sharedManager{
    //Init Class Object
    static WikipediaManager *sharedObject;
    
    //Init Token
    static dispatch_once_t onceToken;
    
    //Call dispatch
    dispatch_once(&onceToken, ^{
        //Init SharedObject
        sharedObject = [[super allocWithZone:NULL] initPrivate];
    });//End of Block
    
    //Return SharedObject
    return sharedObject;
}

#pragma mark - initPrivate
/**
 Method:initPrivate
 
 Description
 - Helper method
 - Used to init a Singleton
 
 
 @return Singleton
 */
-(instancetype)initPrivate
{
    //Init Self
    self = [super init];
    
    //Check for Self
    if (self)
    {
        //Init Data
        _data = [NSMutableArray array];
    }
    
    //Return Self
    return self;
}


#pragma  -mark allocWithZone
/**
 Method: allocWithZone
 
 Description
 - Helper Method
 - Used to alloc a zone to Singleton
 
 @param zone zone
 @return Singleton
 */
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    //Return Singleton
    return [WikipediaManager sharedManager];
}


#pragma  -mark copyWithZone
/**
 Method:copyWithZone
 
 Description
 - Helper Method
 
 @param zone Zone
 @return Self
 */
- (id)copyWithZone:(NSZone *)zone
{
    //Return Self
    return self;
}

#pragma - mark fetchDataFromSite
/**
 Method: fetchDataFromSite
 
 Description
 - Helper Method
 - Fetches Data from a Website
 - Returns data
 
 @param websiteName Site to Fetch
 */
-(float)fetchDataFromSite:(NSString*) websiteName :(void(^)(float)) complete {
    
    
    //Init NSURL Session
    NSURLSession *session = [NSURLSession sharedSession];
    
    //Init URL
    NSURL *url = [NSURL URLWithString:websiteName];
    
    //
    //Error Checking
    id completionBlock = ^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if(error){
            //Return Log
            NSLog(@"Error: %@", error.localizedDescription);
        }
        
        NSError *jsonError = nil;
        
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
        
        if (jsonError) {
            NSLog(@"Parsing Error: %@", jsonError.localizedDescription);
        }
        else {
            
            //Parse Data
            _number =  [self parseFetchedDataOpenGL:dictionary];
            
            //Call Completion Block
            complete(_number);
            
            
        }//End of Else Blcok
        
    };//End of Block
    
    //Init Data Task
    NSURLSessionTask *dataTask = [session dataTaskWithURL:url completionHandler:completionBlock];
    
    //Start dataTask
    [dataTask resume];
    
    //Return the Number
    return _number;
    
}

#pragma  - mark parseFetchedDataOpenGL
/**
 Method:parseFetchedDataOpenGL
 
 
 Description
 - Helper Method
 - Parse Data Task
 - Perform JSON Dictionary Key Value Searching
 - Perform String Parsing
 - Identitfy OpenGL Version
 
 - Help:  https://en.wikipedia.org/w/api.php?action=query&prop=revisions&rvprop=content&format=jsonfm&titles=OpenGL&rvsection=0
 
 @param dict FetchedData
 @return  OpenGL Version
 */
-(float)parseFetchedDataOpenGL:(NSDictionary*) dict{
    
    //Init & Set ParseArrayNo_1
    NSMutableArray *parseArrayNo_1 = [dict valueForKey:@"query.pages.22497.revisions"];
    
    //Int & Set  Dict
    NSDictionary *tempDict = parseArrayNo_1[0];
    
    //Init & Set Another Array
    NSString *string = [tempDict valueForKey:@"*"];
    
    //Init Another Parse Array
    NSArray *parseArrayNo_2 = [string componentsSeparatedByString:@"\n"];
    
    //Init NSString
    NSString *matchedString = [[NSString alloc] init];
    
    //Init Searched String
    NSString *searchString = @"latest release version";
    
    //Search Array for String Match
    for (int i = 0; i < parseArrayNo_2.count; i++) {
        
        //Check if String Matches Intended String
        if([parseArrayNo_2[i] containsString:searchString] == YES) {
            
            //Assign Value to MatchString
            matchedString =  parseArrayNo_2[i];
            
        }//End of If Loop
    }//End of For Loop
    
    //Parse Number from the String
    float number = [self numberFromString:matchedString];
    
    //Return the number
    return number;
    
}

#pragma -mark numberFromString
/**
 Method:numberFromString
 
 Description:
 - Helper Method
 - Parses string to find a number
 
 @param passedString <#passedString description#>
 @return <#return value description#>
 */
-(float)numberFromString: (NSString*) passedString{
    
    //Init NSString
    NSString *numberString;
    
    //Init Scanner
    NSScanner *scanner = [NSScanner scannerWithString:passedString];
    
    //Init CharacterSet
    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    
    // Throw away characters before the first number.
    [scanner scanUpToCharactersFromSet:numbers intoString:NULL];
    
    // Collect numbers.
    [scanner scanCharactersFromSet:numbers intoString:&numberString];
    
    // Get Result
    float number = [numberString floatValue];
    
    //Return Number
    return number;
}



@end
