//
//  httpws.m
//  Runmileapp
//
//  Created by Tecksky Techonologies on 9/2/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#import "httpws.h"
#import "AppMethod.h"
#import <UIKit/UIKit.h>

@implementation httpws

+(NSMutableArray*)getGooglePlace:(NSString *)searchTerm
{
    NSMutableArray *placelist=[[NSMutableArray alloc]init];
    
    searchTerm = [searchTerm stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    
    
    NSString *str1 = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/autocomplete/json?input=%@&types=geocode&sensor=false&key=AIzaSyBEQouslAJ77Ybd-zGhfsIdNE21igskgU4" , searchTerm];
    
    NSURL *url1 = [NSURL URLWithString:str1];
    
    NSData *jsondata = [NSData dataWithContentsOfURL:url1];
    
    NSError *error;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsondata options:kNilOptions error:&error];
    
    
    NSMutableArray *predictions = [dic valueForKey:@"predictions"];
    for (int i=0; i<[predictions count]; i++)
    {
        NSDictionary *place = [predictions objectAtIndex:i];
        [placelist addObject:[place valueForKey:@"description"]];
    }
    
    return placelist;
}


+(NSDictionary*)httpGet:(NSString *)url
{
    if ([AppMethod Check_Internet]>0)
    {
        NSURL *url1 = [NSURL URLWithString:url];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        
        NSData *jsondata = [NSData dataWithContentsOfURL:url1];
        
        NSError *error;
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsondata options:kNilOptions error:&error];
        
        if (dic != nil)
        {
            if ([dic objectForKey:@"status"])
            {
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

                return dic;
            }
            else
            {
                NSDictionary *errDic = [NSDictionary dictionaryWithObjectsAndKeys:@"false",@"status",@"Response Error",@"message", nil];
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

                return errDic;
            }
        }
        else
        {
            NSDictionary *errDic = [NSDictionary dictionaryWithObjectsAndKeys:@"false",@"status",@"Error",@"message", nil];
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

            return errDic;
        }
        

    }
    else
    {
        NSDictionary *errDic = [NSDictionary dictionaryWithObjectsAndKeys:@"false",@"status",@"No Internet Connection",@"message", nil];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

        return errDic;
    }
}

+(NSDictionary*)httpPost:(NSString *)url :(NSDictionary *)jsondata
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSError *error2;
    
    NSData *jsondata2 = [NSJSONSerialization dataWithJSONObject:jsondata options:NSJSONWritingPrettyPrinted error:&error2];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [jsondata2 length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:@"POST"];
    
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    
    [request setHTTPBody:jsondata2];
    
    NSURLResponse *response;
    
    NSData *POSTReply = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    NSMutableDictionary *dic12 = [NSJSONSerialization JSONObjectWithData:POSTReply options:0 error:nil];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    return dic12;

}


+(NSDictionary*)httpPostWithauth:(NSString *)url :(NSDictionary *)jsondata :(NSString *)authstring
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSError *error2;
    
    NSData *jsondata2 = [NSJSONSerialization dataWithJSONObject:jsondata options:NSJSONWritingPrettyPrinted error:&error2];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [jsondata2 length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:@"POST"];
    
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:authstring forHTTPHeaderField:@"TeckskyAuth"];
    
    
    [request setHTTPBody:jsondata2];
    
    NSURLResponse *response;
    
    NSData *POSTReply = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    NSMutableDictionary *dic12 = [NSJSONSerialization JSONObjectWithData:POSTReply options:0 error:nil];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    return dic12;
}

+(NSDictionary*)httpDeletewithauth:(NSString *)url :(NSDictionary *)jsondata :(NSString *)authstring
{
    NSError *error2;
    
    NSData *jsondata2 = [NSJSONSerialization dataWithJSONObject:jsondata options:NSJSONWritingPrettyPrinted error:&error2];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [jsondata2 length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:@"DELETE"];
    
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:authstring forHTTPHeaderField:@"TeckskyAuth"];
    
    
    [request setHTTPBody:jsondata2];
    
    NSURLResponse *response;
    
    NSData *POSTReply = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    NSMutableDictionary *dic12 = [NSJSONSerialization JSONObjectWithData:POSTReply options:0 error:nil];
    
    return dic12;
}

+(NSDictionary*)httpPutWithauth:(NSString *)url :(NSDictionary *)jsondata :(NSString *)authstring
{
    NSError *error2;
    
    NSData *jsondata2 = [NSJSONSerialization dataWithJSONObject:jsondata options:NSJSONWritingPrettyPrinted error:&error2];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [jsondata2 length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:@"PUT"];
    
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:authstring forHTTPHeaderField:@"TeckskyAuth"];
    
    
    [request setHTTPBody:jsondata2];
    
    NSURLResponse *response;
    
    NSData *POSTReply = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    NSMutableDictionary *dic12 = [NSJSONSerialization JSONObjectWithData:POSTReply options:0 error:nil];
    
    return dic12;
}



@end
