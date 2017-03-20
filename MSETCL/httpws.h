//
//  httpws.h
//  Runmileapp
//
//  Created by Tecksky Techonologies on 9/2/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface httpws : NSObject {}
+ (NSMutableArray*)getGooglePlace:(NSString*)searchTerm;

+ (NSDictionary*)httpGet:(NSString*)url;

+ (NSDictionary*)httpPost:(NSString*)url:(NSDictionary*)jsondata;

+ (NSDictionary*)httpPostWithauth:(NSString*)url:(NSDictionary*)jsondata :(NSString*)authstring;


+(NSDictionary*)httpDeletewithauth: (NSString*)url:(NSDictionary*)jsondata : (NSString*)authstring;

+ (NSDictionary*)httpPutWithauth:(NSString*)url:(NSDictionary*)jsondata :(NSString*)authstring;


@end
