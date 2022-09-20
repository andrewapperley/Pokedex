//
//  APIClient.m
//  Pokemon API
//
//  Created by Andrew Apperley on 2/11/22.
//

#import "APIClient.h"

@implementation APIClient

const static NSString *kEndpointRoot = @"https://pokeapi.co/api/v2";
const static NSString *kEndpointPokemonPath = @"/pokemon/";

+ (APIClient *)shared {
    static APIClient *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

- (instancetype)init {
    self = [super init];
    
    if (self == nil) { return self; }
    
    return self;
}

- (void)requestPokemonListWithOffset:(NSInteger)offset andLimit:(NSInteger)limit andCompletionHandler:(void (^)(NSInteger newOffset, NSArray<Pokemon *> * _Nullable pokemon))completion {
    NSInteger _offset = offset > 0 ? offset : 1;
    NSInteger nextOffset = _offset + limit;
    NSMutableArray<Pokemon *> *pokemonModels = [[NSMutableArray alloc] initWithCapacity:limit];
    
    const dispatch_group_t group = dispatch_group_create();
    
    NSInteger orderIndex = 0;
    for (NSInteger i = _offset; i < limit+1; i++) {
        // add temp model
        [pokemonModels addObject:[[Pokemon alloc] init]];
        dispatch_group_enter(group);
        NSInteger currentIndex = orderIndex;
        NSString *url = [[NSString alloc] initWithFormat:@"%@%@%ld", kEndpointRoot, kEndpointPokemonPath, i];
        NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL: [NSURL URLWithString: url] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            // check for 200 status code
            const NSInteger statusCode = ((NSHTTPURLResponse *)response).statusCode;
            if (statusCode != 200) { return; } /*Handle error codes*/
            // decode data into JSON
            NSError *jsonError;
            NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error: &jsonError];
            if (jsonError != nil) {
                // handle decoding error
                return;
            }
            // replace temp model. This guarantees the order
            [pokemonModels replaceObjectAtIndex:currentIndex withObject:[[Pokemon alloc] initWithDictionary: jsonData]];
            dispatch_group_leave(group);
        }];
        [task resume];
        orderIndex++;
    }
    
    dispatch_group_notify(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        completion(nextOffset, pokemonModels);
    });
}

@end
