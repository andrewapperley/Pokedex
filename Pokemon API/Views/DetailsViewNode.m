//
//  DetailsViewNode.m
//  Pokemon API
//
//  Created by Andrew Apperley on 2/16/22.
//

#import "DetailsViewNode.h"

@interface DetailsViewNode()

@property (strong, nonatomic) Pokemon *pokemon;
@property (strong, nonatomic) ASTextNode *nameNode;
@property (strong, nonatomic) ASNetworkImageNode *imageNode;
@property (strong, nonatomic) ASStackLayoutSpec *typeStack;

@end

@implementation DetailsViewNode

- (instancetype)initWithPokemon:(Pokemon *)pokemon {
    self = [super init];
    if (self) {
        _pokemon = pokemon;
        
        // Name Node
        _nameNode = [[ASTextNode alloc] init];
        _nameNode.attributedText = [[NSAttributedString alloc] initWithString:[pokemon.name capitalizedString] attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:22.f]}];
        [self addSubnode:_nameNode];
        // Image Node
        _imageNode = [[ASNetworkImageNode alloc] init];
        _imageNode.backgroundColor = ASDisplayNodeDefaultPlaceholderColor();
        _imageNode.style.width = ASDimensionMakeWithPoints(70);
        _imageNode.style.height = ASDimensionMakeWithPoints(70);
        _imageNode.cornerRadius = 35.0;
        _imageNode.URL = [NSURL URLWithString:_pokemon.sprite];
        [self addSubnode:_imageNode];
        
        NSMutableArray *types = [[NSMutableArray alloc] initWithCapacity:_pokemon.types.count];
        for (NSString *type in _pokemon.types) {
            ASTextNode *typeNode = [[ASTextNode alloc] init];
            typeNode.attributedText = [[NSAttributedString alloc] initWithString:[type capitalizedString] attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.f]}];
            [self addSubnode:typeNode];
            [types addObject:typeNode];
        }
        _typeStack = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal spacing:10.f justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsCenter children:types];
    }
    return self;
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize {
    ASStackLayoutSpec *verticalStackLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:10.f justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsCenter children:@[_imageNode, _nameNode, _typeStack]];
    return [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(11.f, 15.f, 11.f, 15.f) child:verticalStackLayout];
}

@end
