//
//  MacysImageModel.h
//  ShopzApp
//
//  Created by Mahesh Kumar on 3/1/15.
//  Copyright (c) 2015 Shopz. All rights reserved.
//

#import "JSONModel.h"
@protocol MacysImageModel
@end


@interface MacysImageModel : JSONModel

//@property (assign, nonatomic) BOOL isPrimaryImage;
@property (strong, nonatomic) NSNumber<Optional>* isPrimaryImage;
@property (strong, nonatomic) NSString<Optional>* imagetype;
@property (strong, nonatomic) NSURL<Optional>* imageurl;

@end
