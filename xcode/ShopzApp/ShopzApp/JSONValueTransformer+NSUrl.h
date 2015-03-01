//
//  JSONValueTransformer+NSUrl.h
//  ShopzApp
//
//  Created by Mahesh Kumar on 2/28/15.
//  Copyright (c) 2015 Shopz. All rights reserved.
//

#import "JSONValueTransformer.h"

@interface JSONValueTransformer (NSURL)
- (id)NSURLFromNSString:(NSString*)string;
- (id)JSONObjectFromNSURL:(NSURL*)tags;

@end
