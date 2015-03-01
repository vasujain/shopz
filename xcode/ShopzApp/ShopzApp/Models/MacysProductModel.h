//
//  MacysProductModel.h
//  ShopzApp
//
//  Created by Mahesh Kumar on 2/28/15.
//  Copyright (c) 2015 Shopz. All rights reserved.
//

#import "JSONModel.h"
#import "MacysImageModel.h"
@protocol MacysProductModel
@end

@interface MacysProductModel : JSONModel
@property (strong, nonatomic) NSString<Ignore>* fromStore;
@property (strong, nonatomic) NSNumber* sku;
@property (strong, nonatomic) NSString<Optional>* name;
@property (strong, nonatomic) NSNumber<Optional>* salePrice;
@property (assign, nonatomic) BOOL onSale;
@property (strong, nonatomic) NSString<Optional>* regularPrice;
@property (strong, nonatomic) NSString<Optional>* shortDescription;
@property (strong, nonatomic) NSURL<Optional>* largeFrontImage;
@property (strong, nonatomic) NSURL<Optional>* url;
@property (strong, nonatomic) NSURL<Optional>* spin360Url;
@property (strong, nonatomic) NSURL<Optional>*  mobileUrl;
@property (strong, nonatomic) NSURL<Optional>* addToCartUrl;
@property (strong, nonatomic) NSURL<Optional>* mediumImage;
@property (strong, nonatomic) NSURL<Optional>* thumbnailImage;
@property (strong, nonatomic) NSURL<Optional>* largeImage;
@property (strong, nonatomic) NSString<Optional>* longDescription;


@property (strong, nonatomic) NSMutableArray<MacysImageModel>* images;



@end
