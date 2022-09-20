//
//  APIClient.h
//  Pokemon API
//
//  Created by Andrew Apperley on 2/11/22.
//

#import <Foundation/Foundation.h>
#import "Pokemon.h"

NS_ASSUME_NONNULL_BEGIN

@interface APIClient : NSObject

+ (APIClient *)shared;
- (void)requestPokemonListWithOffset:(NSInteger)offset andLimit:(NSInteger)limit andCompletionHandler:(void (^)(NSInteger newOffset, NSArray<Pokemon *> * _Nullable pokemon))completion;
@end

NS_ASSUME_NONNULL_END
