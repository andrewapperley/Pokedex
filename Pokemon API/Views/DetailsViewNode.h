//
//  DetailsViewNode.h
//  Pokemon API
//
//  Created by Andrew Apperley on 2/16/22.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "Pokemon.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewNode : ASDisplayNode

- (instancetype)initWithPokemon:(Pokemon *)pokemon;

@end

NS_ASSUME_NONNULL_END
