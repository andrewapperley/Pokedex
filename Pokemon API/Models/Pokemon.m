//
//  Pokemon.m
//  Pokemon API
//
//  Created by Andrew Apperley on 2/14/22.
//

#import "Pokemon.h"

@implementation Pokemon

- (instancetype)initWithDictionary:(NSDictionary *)data {
    self = [super init];
    if (self == nil) { return self; }
    
    self.identififer = [data[@"id"] integerValue];
    self.name = data[@"name"];
    NSMutableArray *types = [[NSMutableArray alloc] init];
    for (NSDictionary *type in data[@"types"]) {
        [types addObject: type[@"type"][@"name"]];
    }
    self.types = types;
    self.sprite = data[@"sprites"][@"front_default"];
    return self;
}

@end
