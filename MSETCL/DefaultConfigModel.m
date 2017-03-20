//
//  DefaultConfigModel.m
//  MSETCL
//
//  Created by Tecksky Techonologies on 3/6/17.
//  Copyright © 2017 Tecksky Technologies. All rights reserved.
//

#import "DefaultConfigModel.h"

@implementation DefaultConfigModel

@end

@implementation DefaultConfigDataModels

@end

@implementation DefaultConfigDataType
- (instancetype)initWithDictionary:(NSDictionary*)dictionary {
    if (self = [super init]) {
        self->id = dictionary[@"id"];
        self->key = dictionary[@"key"];
        self->value = dictionary[@"value"];
    }
    return self;
}
@end
