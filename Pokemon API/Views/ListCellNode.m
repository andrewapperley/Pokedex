//
//  ListCellNode.m
//  Pokemon API
//
//  Created by Andrew Apperley on 2/16/22.
//

#import "ListCellNode.h"

@interface ListCellNode() <ASNetworkImageNodeDelegate>

@property (strong, nonatomic) Pokemon *pokemon;
@property (strong, nonatomic) ASTextNode *nameNode;
@property (strong, nonatomic) ASNetworkImageNode *imageNode;

@end

@implementation ListCellNode

- (instancetype)initWithPokemon:(Pokemon *)pokemon {
    self = [super init];
    if (self) {
        _pokemon = pokemon;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // Name Node
        _nameNode = [[ASTextNode alloc] init];
        _nameNode.attributedText = [[NSAttributedString alloc] initWithString:[pokemon.name capitalizedString] attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18.f]}];
        [self addSubnode:_nameNode];
        // Image Node
        _imageNode = [[ASNetworkImageNode alloc] init];
        _imageNode.backgroundColor = ASDisplayNodeDefaultPlaceholderColor();
        _imageNode.style.width = ASDimensionMakeWithPoints(44);
        _imageNode.style.height = ASDimensionMakeWithPoints(44);
        _imageNode.cornerRadius = 22.0;
        _imageNode.URL = [NSURL URLWithString:_pokemon.sprite];
        [self addSubnode:_imageNode];
    }
    return self;
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize {
    ASStackLayoutSpec *stackLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal spacing:10.f justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsCenter children:@[_imageNode, _nameNode]];
    return [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(11.f, 15.f, 11.f, 15.f) child:stackLayout];
}

@end
