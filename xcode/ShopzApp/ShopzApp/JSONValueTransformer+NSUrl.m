//
//  JSONValueTransformer+NSUrl.m
//  ShopzApp
//
//  Created by Mahesh Kumar on 2/28/15.
//  Copyright (c) 2015 Shopz. All rights reserved.
//

#import "JSONValueTransformer+NSURL.h"

@implementation JSONValueTransformer (NSURL)

- (id)NSURLFromNSString:(NSString *)urlString {
    return  [NSURL URLWithString:urlString];
}



-(id) JSONObjectFromNSURL:(NSURL *)url{
    
    return [url absoluteString];
    
}


@end
