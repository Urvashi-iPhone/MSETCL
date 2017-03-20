//
//  AppMethod.m
//  Runmileapp
//
//  Created by Tecksky Techonologies on 9/3/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import "AppMethod.h"
#import "Reachability.h"
#import <AssetsLibrary/AssetsLibrary.h>
@implementation AppMethod

+(void)setStringDefault:(NSString *)key :(NSString *)value
{
    [[NSUserDefaults standardUserDefaults]setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}
+(NSString*)getStringDefault:(NSString *)key
{
    NSString *value=[[NSUserDefaults standardUserDefaults]stringForKey:key];
    return value;
}

+(void)setBoolDefault:(NSString *)key :(BOOL)value
{
    [[NSUserDefaults standardUserDefaults]setBool:value forKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}
+(BOOL)getBoolDefault:(NSString *)key
{
    BOOL value=[[NSUserDefaults standardUserDefaults]boolForKey:key];
    return value;
}

+(void)setIntegerDefault:(NSString *)key :(NSInteger)value
{
    [[NSUserDefaults standardUserDefaults]setInteger:value forKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}
+(NSInteger)getIntegerDefault:(NSString *)key
{
    BOOL value=[[NSUserDefaults standardUserDefaults]integerForKey:key];
    return value;
}

+(void)setDictionaryDefault:(NSString*)key:(NSDictionary*)value
{
    [[NSUserDefaults standardUserDefaults]setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
+(NSDictionary*)getDictionaryDefault:(NSString*)key
{
    NSDictionary *value=[[NSUserDefaults standardUserDefaults]objectForKey:key];
    return value;
}
//for address
+(NSString *)convertHTML:(NSString *)html
{
    
    NSScanner *myScanner;
    NSString *text = nil;
    myScanner = [NSScanner scannerWithString:html];
    
    while ([myScanner isAtEnd] == NO) {
        
        [myScanner scanUpToString:@"<" intoString:NULL] ;
        
        [myScanner scanUpToString:@">" intoString:&text] ;
        
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@"\n"];
    }
    html = [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return html;
}


+(void)setArrayDefault:(NSMutableArray *)key :(NSMutableArray *)value
{
    [[NSUserDefaults standardUserDefaults]setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
+(NSMutableArray*)getArrayDefault:(NSMutableArray *)key
{
    NSMutableArray *value = [[NSUserDefaults standardUserDefaults]arrayForKey:key];
    return value;
}

+(NSInteger)Check_Internet;
{
    Reachability *IsReachable = [Reachability reachabilityForInternetConnection];
    NetworkStatus internetStats = [IsReachable currentReachabilityStatus];
    
    if (internetStats == NotReachable)
    {
        return 0;
    }
    else
    {
        return 1;
    }
}
+(NSDictionary *)Parse_Adondata
{
    NSString *json = [AppMethod getStringDefault:@"default_adon"];
    NSError *error;
    NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *adondata = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    //NSDictionary *adondata = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    return adondata;
}

+(void)UnderLineStyleTextField:(UITextField *)textField
{
    CALayer *textFieldbottomBorder = [CALayer layer];
    textFieldbottomBorder.frame = CGRectMake(0.0f, textField.frame.size.height - 2, textField.frame.size.width, 5.0f);
    textFieldbottomBorder.backgroundColor = [UIColor blackColor].CGColor;
    [textField.layer addSublayer:textFieldbottomBorder];
}


+(NSDictionary*)dictionaryWithContentsOfJSONString:(NSString*)fileLocation{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:[fileLocation stringByDeletingPathExtension] ofType:[fileLocation pathExtension]];
    NSData* data = [NSData dataWithContentsOfFile:filePath];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data
                                                options:kNilOptions error:&error];
    // Be careful here. You add this as a category to NSDictionary
    // but you get an id back, which means that result
    // might be an NSArray as well!
    if (error != nil) return nil;
    return result;
}

//create folder in document
+(NSString*)createDirForImage :(NSString *)dirName
{
    NSString *path;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    path = [[paths objectAtIndex:0] stringByAppendingPathComponent:dirName];
    NSError *error;
    if (![[NSFileManager defaultManager] fileExistsAtPath:path])    //Does directory already exist?
    {
        if (![[NSFileManager defaultManager] createDirectoryAtPath:path
                                       withIntermediateDirectories:NO
                                                        attributes:nil
                                                             error:&error])
        {
            NSLog(@"Create directory error: %@", error);
        }
        
        NSLog(@"path: %@",path);
        
    }
    else
    {
        NSLog(@"Directory already exist");
    }
    //use:[AppMethod createDirForImage:@"Clarify"];
    return path;
}

//corner radious all

+(UIView *)roundCornersOnView:(UIView *)view onTopLeft:(BOOL)tl topRight:(BOOL)tr bottomLeft:(BOOL)bl bottomRight:(BOOL)br radius:(float)radius
{
    if (tl || tr || bl || br) {
        UIRectCorner corner = 0;
        if (tl) corner = corner | UIRectCornerTopLeft;
        if (tr) corner = corner | UIRectCornerTopRight;
        if (bl) corner = corner | UIRectCornerBottomLeft;
        if (br) corner = corner | UIRectCornerBottomRight;
        
        UIView *roundedView = view;
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:roundedView.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(radius, radius)];
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.frame = roundedView.bounds;
        maskLayer.path = maskPath.CGPath;
        roundedView.layer.mask = maskLayer;
        return roundedView;
    }
    return view;
}

//create folder in library photos with album

+(void)savePhotoToAlbum:(UIImage*)imageToSave {
    
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library addAssetsGroupAlbumWithName:@"Clarify Album" resultBlock:^(ALAssetsGroup *group)
     {
        ///checks if group previously created
        if(group == nil)
        {
            
        //enumerate albums
        [library enumerateGroupsWithTypes:ALAssetsGroupAlbum usingBlock:^(ALAssetsGroup *g, BOOL *stop)
             {
                //if the album is equal to our album
                if ([[g valueForProperty:ALAssetsGroupPropertyName] isEqualToString:@"Clarify Album"]) {
                //save image
                [library writeImageDataToSavedPhotosAlbum:UIImagePNGRepresentation(imageToSave) metadata:nil
                                               completionBlock:^(NSURL *assetURL, NSError *error)
                    {
                  //then get the image asseturl
                    [library assetForURL:assetURL resultBlock:^(ALAsset *asset)
                        {
                        //put it into our album
                         [g addAsset:asset];
                         } failureBlock:^(NSError *error)
                        {
                        }];
                    }];
                     
                 }
             }failureBlock:^(NSError *error)
             {
                 
             }];
            
        }else{
            // save image directly to library
            [library writeImageDataToSavedPhotosAlbum:UIImagePNGRepresentation(imageToSave) metadata:nil
                                      completionBlock:^(NSURL *assetURL, NSError *error) {
                                          
                [library assetForURL:assetURL resultBlock:^(ALAsset *asset) {
                    [group addAsset:asset];
                    } failureBlock:^(NSError *error)
                        {
                        }];
                    }];
        }
        
    } failureBlock:^(NSError *error) {
        
    }];
}

+(BOOL)stringMatchedREGEX:(NSString*)input:(NSString*)RegexStr
{
    NSPredicate *myTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", RegexStr];
    if ([myTest evaluateWithObject: input]){
        return true;
    }
    else
    {
        return false;
    }
}
//image capture

//- (UIImage *)captureView {
//    
//    //hide controls if needed
//    CGRect rect = [_mainView bounds];
//    UIGraphicsBeginImageContext(rect.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    [_mainView.layer renderInContext:context];
//    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return img;
//    
//}
//
//use: _img.image = [self captureView];

@end
