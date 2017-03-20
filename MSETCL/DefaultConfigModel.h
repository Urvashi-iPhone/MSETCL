//
//  DefaultConfigModel.h
//  MSETCL
//
//  Created by Tecksky Techonologies on 3/6/17.
//  Copyright © 2017 Tecksky Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface DefaultConfigDataType : NSObject
{
    NSInteger id;
    NSString *key,*value;
}

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;
@end


@interface DefaultConfigDataModels : NSObject
{
    NSMutableArray<DefaultConfigDataType *> *designation,*zone,*state;
}
@end

@interface DefaultConfigModel : NSObject
{
    BOOL status;
    NSString *message;
}

@end

