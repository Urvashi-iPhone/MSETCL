//
//  AppMethod.h
//  Runmileapp
//
//  Created by Tecksky Techonologies on 9/3/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface AppMethod : NSObject

+(void)setStringDefault:(NSString*)key:(NSString*)value;
+(NSString*)getStringDefault:(NSString*)key;

+(void)setBoolDefault:(NSString*)key:(BOOL)value;
+(BOOL)getBoolDefault:(NSString*)key;

+(void)setIntegerDefault:(NSString *)key :(NSInteger)value;
+(NSInteger)getIntegerDefault:(NSString *)key;

+(void)setDictionaryDefault:(NSString*)key:(NSDictionary*)value;
+(NSDictionary*)getDictionaryDefault:(NSString*)key;

+(NSString *)convertHTML:(NSString *)html;
+(NSInteger)getIntegerDefault:(NSString *)key;
+(void)setArrayDefault:(NSMutableArray*)key:(NSMutableArray*)value;
+(NSMutableArray*)getArrayDefault:(NSMutableArray*)key;

+(NSInteger)Check_Internet;
+(NSDictionary *)Parse_Adondata;

+(void)UnderLineStyleTextField:(UITextField*)textField;
+(NSDictionary*)dictionaryWithContentsOfJSONString:(NSString*)fileLocation;
+(NSString*)createDirForImage :(NSString *)dirName;

+(UIView *)roundCornersOnView:(UIView *)view onTopLeft:(BOOL)tl topRight:(BOOL)tr bottomLeft:(BOOL)bl bottomRight:(BOOL)br radius:(float)radius;

+(void)savePhotoToAlbum:(UIImage*)imageToSave;
+(BOOL)stringMatchedREGEX:(NSString*)input:(NSString*)RegexStr;
@end
