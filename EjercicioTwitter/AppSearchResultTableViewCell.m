//
//  AppSearchResultTableViewCell.m
//  EjercicioTwitter
//
//  Created by Gerardo Fernandez on 1/18/16.
//  Copyright © 2016 Gerardo Fernandez. All rights reserved.
//

#import "AppSearchResultTableViewCell.h"
#import "Masonry.h"

@implementation AppSearchResultTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        //Create components
        self.artwork = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        self.artwork.backgroundColor = [UIColor blackColor];
        self.artistName = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 60, 30)];
        self.collectionName = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 60, 30)];
        self.trackName = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 60, 30)];
        
        //Set font size
        self.collectionName.font = [UIFont systemFontOfSize:12];
        self.trackName.font = [UIFont systemFontOfSize:12];
        
        //Add them to the cell view
        [self addSubview:self.artwork];
        [self addSubview:self.artistName];
        [self addSubview:self.collectionName];
        [self addSubview:self.trackName];
        
        //Apply constraints
        [self.artistName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.width.equalTo(self.mas_width).with.offset(60);
            make.left.equalTo(self.artwork.mas_right);
        }];
        [self.collectionName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.artistName.mas_bottom);
            make.width.equalTo(self.mas_width).with.offset(60);
            make.left.equalTo(self.artwork.mas_right);
        }];
        [self.trackName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.collectionName.mas_bottom);
            make.width.equalTo(self.mas_width).with.offset(60);
            make.left.equalTo(self.artwork.mas_right);
        }];
    }
    
    return self;
}

@end
