//
//  SearchManager.m
//  shopZ
//
//  Created by Mahesh Kumar on 2/28/15.
//  Copyright (c) 2015 brk.im. All rights reserved.
//

#import "SearchManager.h"

//static NSString * const BaseURLString = @"http://brk.im/src/launch/?store=bestbuy";
static NSString * const BaseURLString = @"http://brk.im/src/launch/?";
static NSString* const ProductSearchString = @"http://brk.im/src/launch/?store=%@,intent=products";
static NSString* const CategorySearchString = @"http://brk.im/src/launch/?store=%@,intent=categories";

// http://shopz.club/?";

@implementation SearchManager



+ (void) searchForProduct: (NSString*) searchFor
                               fromStore:(NSString* ) store
                                  filter: (NSString*) filter
                                 success:(void (^)( id responseObject))success
                                 failure:(void (^)(NSError *error))failure
{
    NSString *string = [NSString stringWithFormat:@"%@store=%@&intent=products", BaseURLString,store];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSError* err = nil;
        if([store isEqualToString:@"bestbuy"])
        {
            SearchResultsModel* results = [[SearchResultsModel alloc] initWithDictionary:responseObject  error:&err];
        
            //Set Store to products
            [results setStore:@"Best Buy"];
        
            NSLog(@"response String %@ ", [results toJSONString]);
            success( results);
        }
        else if([store isEqualToString:@"macys"])
        {
            NSArray* arrSrch = [responseObject objectForKey:@"searchresultgroups"];
            
            NSDictionary* searchResultGroups = [arrSrch objectAtIndex:0];
 
            MacysSearchResultModel* results = [[MacysSearchResultModel alloc] initWithDictionary:searchResultGroups  error:&err];
            NSLog(@"response String %@ ", [results toJSONString]);

            //Set Store to products
            [results setStore:@"Macy's"];

            SearchResultsModel* srchResult = [[SearchResultsModel alloc]initWithMacysProductResults:results];
            
            
            success( srchResult);
        }

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"products request failed with error %@ ", error);
        failure(error);
        
    }];
    
    [operation start];
}


+ (void) searchForCategoriesFromStore:(NSString* ) store
                  success:(void (^)( SearchResultsModel* responseObject))success
                  failure:(void (^)(NSError *error))failure
{
    NSString *string = [NSString stringWithFormat:@"%@store=%@&intent=categories", BaseURLString,store];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSError* err = nil;
        SearchResultsModel* results = [[SearchResultsModel alloc] initWithDictionary:responseObject  error:&err];
        
        NSLog(@"response String %@ ", [results toJSONString]);
        success( results);
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"products request failed with error %@ ", error);

        [failure error];
    }];
    
    [operation start];
}


-(SearchResultsModel*) createModel:(NSString*) jsonString
{

    NSString* json2 = @"{\"products\":[{ \
    \"sku\": 4706946,\
    \"name\": \"Canon - 10 x 30 IS Image Stabilized Binoculars - Black\",\
    \"salePrice\": 411.99\
    },\
    {\
    \"sku\": 8795075,\
    \"name\": \"Canon - 100-Pack 4 x 6 Glossy Photo Paper - White\",\
    \"salePrice\": 8.74\
    }]}";
    
    
    NSString* json1 = @"{ \
    \"sku\": 4706946,\
    \"name\": \"Canon - 10 x 30 IS Image Stabilized Binoculars - Black\",\
    \"salePrice\": 411.99\
    }";
    
    
    
    NSError* err = nil;
    SearchResultsModel* results = [[SearchResultsModel alloc] initWithString:json2 error:&err];
    
    return results;
    
    
}


+ (NSString* ) getJSON
{
    NSString* json = @"{\
    \"from\": 1,\
    \"to\": 10,\
    \"total\": 238,\
    \"currentPage\": 1,\
    \"totalPages\": 24,\
    \"queryTime\": \"0.250\",\
    \"totalTime\": \"0.309\",\
    \"partial\": false,\
    \"products\": [\
    {\
        \"sku\": 4706946,\
        \"name\": \"Canon - 10 x 30 IS Image Stabilized Binoculars - Black\",\
        \"shortDescription\": \"Image stabilization technology; 10x magnification; water-resistant rubber coating; 30mm diameter; prism design\",\
        \"image\": \"http://img.bbystatic.com/BestBuy_US/images/products/4706/4706946_sc.jpg\",\
        \"largeFrontImage\": \"http://img.bbystatic.com/BestBuy_US/images/products/4706/4706946_sa.jpg\",\
        \"url\": \"http://www.bestbuy.com/site/canon-10-x-30-is-image-stabilized-binoculars-black/4706946.p?id=1051807015475&skuId=4706946&cmp=RMX&ky=2isIp2f6L5dFA7bKDFaLWjtoFNMpFIY3q\",\
        \"spin360Url\": null,\
        \"mobileUrl\": \"http://m.bestbuy.com/r/1051807015475/4706946/\",\
        \"addToCartUrl\": \"http://www.bestbuy.com/site/olspage.jsp?id=pcmcat152200050035&type=category&cmp=RMX&ky=2isIp2f6L5dFA7bKDFaLWjtoFNMpFIY3q&qvsids=4706946\",\
        \"onSale\": true,\
        \"regularPrice\": 549.99,\
        \"salePrice\": 411.99,\
        \"mediumImage\": \"http://img.bbystatic.com/BestBuy_US/images/products/4706/4706946fp.gif\",\
        \"thumbnailImage\": \"http://img.bbystatic.com/BestBuy_US/images/products/4706/4706946_s.gif\",\
        \"largeImage\": \"http://img.bbystatic.com/BestBuy_US/images/products/4706/4706946_sb.jpg\",\
        \"longDescription\": \"These Canon 2897A002 binoculars feature powerful 10x magnification for crystal-clear viewing and a compact design for easy portability. The water-resistant rubber coating allows marine use.\"\
    },\
    {\
        \"sku\": 8795075,\
        \"name\": \"Canon - 100-Pack 4 x 6 Glossy Photo Paper - White\",\
        \"shortDescription\": \"4 x 6 glossy photo paper; 100-count; creates rich colors\",\
        \"image\": \"http://img.bbystatic.com/BestBuy_US/images/products/8795/8795075_sc.jpg\",\
        \"largeFrontImage\": \"http://img.bbystatic.com/BestBuy_US/images/products/8795/8795075_sa.jpg\",\
        \"url\": \"http://www.bestbuy.com/site/canon-100-pack-4-x-6-glossy-photo-paper-white/8795075.p?id=1205537714472&skuId=8795075&cmp=RMX&ky=2isIp2f6L5dFA7bKDFaLWjtoFNMpFIY3q\",\
        \"spin360Url\": null,\
        \"mobileUrl\": \"http://m.bestbuy.com/r/1205537714472/8795075/\",\
        \"addToCartUrl\": \"http://www.bestbuy.com/site/olspage.jsp?id=pcmcat152200050035&type=category&cmp=RMX&ky=2isIp2f6L5dFA7bKDFaLWjtoFNMpFIY3q&qvsids=8795075\",\
        \"onSale\": true,\
        \"regularPrice\": 17.49,\
        \"salePrice\": 8.74,\
        \"mediumImage\": \"http://img.bbystatic.com/BestBuy_US/images/products/8795/8795075fp.gif\",\
        \"thumbnailImage\": \"http://img.bbystatic.com/BestBuy_US/images/products/8795/8795075_s.gif\",\
        \"largeImage\": \"http://img.bbystatic.com/BestBuy_US/images/products/8795/8795075_sb.jpg\",\
        \"longDescription\": \"Preserve your special pictures on this high-quality glossy photo paper. The rich colors and glossy finish make it ideal for scrapbooking.\"\
    },\
    {\
        \"sku\": 5571203,\
        \"name\": \"Canon - 12 x 36 IS II Image Stabilized Binoculars - Black\",\
        \"shortDescription\": \"VAP (vari-angle prism) image stabilizer; 12x magnification; water-resistant,\ nonslip rubber coating; 36mm objective lenses; Porro II prisms; Super Spectra multicoating\",\
        \"image\": \"http://img.bbystatic.com/BestBuy_US/images/products/5571/5571203_sc.jpg\",\
        \"largeFrontImage\": \"http://img.bbystatic.com/BestBuy_US/images/products/5571/5571203_sa.jpg\",\
        \"url\": \"http://www.bestbuy.com/site/canon-12-x-36-is-ii-image-stabilized-binoculars-black/5571203.p?id=1218662155409&skuId=5571203&cmp=RMX&ky=2isIp2f6L5dFA7bKDFaLWjtoFNMpFIY3q\",\
        \"spin360Url\": null,\
        \"mobileUrl\": \"http://m.bestbuy.com/r/1218662155409/5571203/\",\
        \"addToCartUrl\": \"http://www.bestbuy.com/site/olspage.jsp?id=pcmcat152200050035&type=category&cmp=RMX&ky=2isIp2f6L5dFA7bKDFaLWjtoFNMpFIY3q&qvsids=5571203\",\
        \"onSale\": true,\
        \"regularPrice\": 849.99,\
        \"salePrice\": 616.99,\
        \"mediumImage\": \"http://img.bbystatic.com/BestBuy_US/images/products/5571/5571203fp.gif\",\
        \"thumbnailImage\": \"http://img.bbystatic.com/BestBuy_US/images/products/5571/5571203_s.gif\",\
        \"largeImage\": \"http://img.bbystatic.com/BestBuy_US/images/products/5571/5571203_sb.jpg\",\
        \"longDescription\": \"Utilizing a VAP (vari-angle prism) image stabilizer,\ Super Spectra multicoating and Porro II prisms,\ these 12 x 36 Canon 9332A002 binoculars help you achieve a clear view of faraway subjects and scenes.\"\
    },\
    {\
        \"sku\": 1848012,\
        \"name\": \"Canon - 131 Ink Cartridge - Black\",\
        \"shortDescription\": \"Compatible with Canon ImageClass MF8280Cw and ImageClass LBP7110Cw printers; black ink; 1400-page yield\",\
        \"image\": \"http://img.bbystatic.com/BestBuy_US/images/products/1848/1848012_sc.jpg\",\
        \"largeFrontImage\": \"http://img.bbystatic.com/BestBuy_US/images/products/1848/1848012_sa.jpg\",\
        \"url\": \"http://www.bestbuy.com/site/canon-131-ink-cartridge-black/1848012.p?id=1219514014442&skuId=1848012&cmp=RMX&ky=2isIp2f6L5dFA7bKDFaLWjtoFNMpFIY3q\",\
        \"spin360Url\": null,\
        \"mobileUrl\": \"http://m.bestbuy.com/r/1219514014442/1848012/\",\
        \"addToCartUrl\": \"http://www.bestbuy.com/site/olspage.jsp?id=pcmcat152200050035&type=category&cmp=RMX&ky=2isIp2f6L5dFA7bKDFaLWjtoFNMpFIY3q&qvsids=1848012\",\
        \"onSale\": false,\
        \"regularPrice\": 69,\
        \"salePrice\": 69,\
        \"mediumImage\": \"http://img.bbystatic.com/BestBuy_US/images/products/1848/1848012fp.gif\",\
        \"thumbnailImage\": \"http://img.bbystatic.com/BestBuy_US/images/products/1848/1848012_s.gif\",\
        \"largeImage\": \"http://img.bbystatic.com/BestBuy_US/images/products/1848/1848012_sb.jpg\",\
        \"longDescription\": \"This Canon ink cartridge provides high-quality crisp black prints with a yield of up to 1400 pages.\"\
    },\
    {\
        \"sku\": 1848021,\
        \"name\": \"Canon - 137 Ink Cartridge - Black\",\
        \"shortDescription\": \"Compatible with Canon ImageClass MF212w,\ MF216n,\ MF227dw and MF229dw printers; black\
        ink cartridge; 2400-page yield\",\
        \"image\": \"http://img.bbystatic.com/BestBuy_US/images/products/1848/1848021_sc.jpg\",\
        \"largeFrontImage\": \"http://img.bbystatic.com/BestBuy_US/images/products/1848/1848021_sa.jpg\",\
        \"url\": \"http://www.bestbuy.com/site/canon-137-ink-cartridge-black/1848021.p?id=1219514014571&skuId=1848021&cmp=RMX&ky=2isIp2f6L5dFA7bKDFaLWjtoFNMpFIY3q\",\
        \"spin360Url\": null,\
        \"mobileUrl\": \"http://m.bestbuy.com/r/1219514014571/1848021/\",\
        \"addToCartUrl\": \"http://www.bestbuy.com/site/olspage.jsp?id=pcmcat152200050035&type=category&cmp=RMX&ky=2isIp2f6L5dFA7bKDFaLWjtoFNMpFIY3q&qvsids=1848021\",\
        \"onSale\": true,\
        \"regularPrice\": 87,\
        \"salePrice\": 84,\
        \"mediumImage\": \"http://img.bbystatic.com/BestBuy_US/images/products/1848/1848021fp.gif\",\
        \"thumbnailImage\": \"http://img.bbystatic.com/BestBuy_US/images/products/1848/1848021_s.gif\",\
        \"largeImage\": \"http://img.bbystatic.com/BestBuy_US/images/products/1848/1848021_sb.jpg\",\
        \"longDescription\": \"This Canon CRG 137 ink cartridge prints crisp,\ black text and is compatible with select \
        Canon printers.\"\
    },\
    {\
        \"sku\": 7124104,\
        \"name\": \"Canon - 16 Ink Tank Twin-Pack - Multicolor\",\
        \"shortDescription\": \"Compatible with Canon PIXMA iP90 and Selphy DS700 and DS810 photo printers; includes 2 tanks\",\
        \"image\": \"http://img.bbystatic.com/BestBuy_US/images/products/7124/7124104_rc.jpg\",\
        \"largeFrontImage\": null,\
        \"url\": \"http://www.bestbuy.com/site/canon-16-ink-tank-twin-pack-multicolor/7124104.p?id=1109234060875&skuId=7124104&cmp=RMX&ky=2isIp2f6L5dFA7bKDFaLWjtoFNMpFIY3q\",\
        \"spin360Url\": null,\
        \"mobileUrl\": \"http://m.bestbuy.com/r/1109234060875/7124104/\",\
        \"addToCartUrl\": \"http://www.bestbuy.com/site/olspage.jsp?id=pcmcat152200050035&type=category&cmp=RMX&ky=2isIp2f6L5dFA7bKDFaLWjtoFNMpFIY3q&qvsids=7124104\",\
        \"onSale\": true,\
        \"regularPrice\": 28.99,\
        \"salePrice\": 20.99,\
        \"mediumImage\": \"http://img.bbystatic.com/BestBuy_US/images/products/7124/7124104fp.gif\",\
        \"thumbnailImage\": \"http://img.bbystatic.com/BestBuy_US/images/products/7124/7124104_r.gif\",\
        \"largeImage\": \"http://img.bbystatic.com/BestBuy_US/images/products/7124/7124104_rb.jpg\",\
        \"longDescription\": \"Turn your digital photos into brilliant prints with your Canon photo printer and this handy ink twin-pack of color ink tanks. Don't just make memories &#8212; share them.\"\
    },\
    {\
        \"sku\": 8795128,\
        \"name\": \"Canon - 20-Pack 5 x 7 Glossy Photo Paper - White\",\
        \"shortDescription\": \"5 x 7 glossy photo paper; 20-count; creates rich colors\",\
        \"image\": \"http://img.bbystatic.com/BestBuy_US/images/products/8795/8795128_sc.jpg\",\
        \"largeFrontImage\": \"http://img.bbystatic.com/BestBuy_US/images/products/8795/8795128_sa.jpg\",\
        \"url\": \"http://www.bestbuy.com/site/canon-20-pack-5-x-7-glossy-photo-paper-white/8795128.p?id=1205537714606&skuId=8795128&cmp=RMX&ky=2isIp2f6L5dFA7bKDFaLWjtoFNMpFIY3q\",\
        \"spin360Url\": null,\
        \"mobileUrl\": \"http://m.bestbuy.com/r/1205537714606/8795128/\",\
        \"addToCartUrl\": \"http://www.bestbuy.com/site/olspage.jsp?id=pcmcat152200050035&type=category&cmp=RMX&ky=2isIp2f6L5dFA7bKDFaLWjtoFNMpFIY3q&qvsids=8795128\",\
        \"onSale\": true,\
        \"regularPrice\": 8.99,\
        \"salePrice\": 4.49,\
        \"mediumImage\": \"http://img.bbystatic.com/BestBuy_US/images/products/8795/8795128fp.gif\",\
        \"thumbnailImage\": \"http://img.bbystatic.com/BestBuy_US/images/products/8795/8795128_s.gif\",\
        \"largeImage\": \"http://img.bbystatic.com/BestBuy_US/images/products/8795/8795128_sb.jpg\",\
        \"longDescription\": \"Preserve your special pictures on this high-quality glossy photo paper. The rich colors and glossy finish make it ideal for scrapbooking.\"\
    },\
    {\
        \"sku\": 8795137,\
        \"name\": \"Canon - 20-Pack 8.5 x 11 Glossy Photo Paper - White\",\
        \"shortDescription\": \"8.5 x 11 glossy photo paper; 20-count; creates rich colors\",\
        \"image\": \"http://img.bbystatic.com/BestBuy_US/images/products/8795/8795137_sc.jpg\",\
        \"largeFrontImage\": \"http://img.bbystatic.com/BestBuy_US/images/products/8795/8795137_sa.jpg\",\
        \"url\": \"http://www.bestbuy.com/site/canon-20-pack-8-5-x-11-glossy-photo-paper-white/8795137.p?id=1205537714674&skuId=8795137&cmp=RMX&ky=2isIp2f6L5dFA7bKDFaLWjtoFNMpFIY3q\",\
        \"spin360Url\": null,\
        \"mobileUrl\": \"http://m.bestbuy.com/r/1205537714674/8795137/\",\
        \"addToCartUrl\": \"http://www.bestbuy.com/site/olspage.jsp?id=pcmcat152200050035&type=category&cmp=RMX&ky=2isIp2f6L5dFA7bKDFaLWjtoFNMpFIY3q&qvsids=8795137\",\
        \"onSale\": true,\
        \"regularPrice\": 11.99,\
        \"salePrice\": 5.99,\
        \"mediumImage\": \"http://img.bbystatic.com/BestBuy_US/images/products/8795/8795137fp.gif\",\
        \"thumbnailImage\": \"http://img.bbystatic.com/BestBuy_US/images/products/8795/8795137_s.gif\",\
        \"largeImage\": \"http://img.bbystatic.com/BestBuy_US/images/products/8795/8795137_sb.jpg\",\
        \"longDescription\": \"Preserve your special pictures on this high-quality glossy photo paper. The rich colors and glossy finish makes it ideal for scrapbooking.\"\
    },\
    {\
        \"sku\": 9798556,\
        \"name\": \"Canon - 210XL High-Yield Ink Cartridge - Black\",\
        \"shortDescription\": \"Yields up to 401 pagesCompatible with select Canon PIXMA Printers\",\
        \"image\": \"http://img.bbystatic.com/BestBuy_US/images/products/9798/9798556_sc.jpg\",\
        \"largeFrontImage\": \"http://img.bbystatic.com/BestBuy_US/images/products/9798/9798556_sa.jpg\",\
        \"url\": \"http://www.bestbuy.com/site/canon-210xl-high-yield-ink-cartridge-black/9798556.p?id=1218176208240&skuId=9798556&cmp=RMX&ky=2isIp2f6L5dFA7bKDFaLWjtoFNMpFIY3q\",\
        \"spin360Url\": null,\
        \"mobileUrl\": \"http://m.bestbuy.com/r/1218176208240/9798556/\",\
        \"addToCartUrl\": \"http://www.bestbuy.com/site/olspage.jsp?id=pcmcat152200050035&type=category&cmp=RMX&ky=2isIp2f6L5dFA7bKDFaLWjtoFNMpFIY3q&qvsids=9798556\",\
        \"onSale\": false,\
        \"regularPrice\": 21.99,\
        \"salePrice\": 21.99,\
        \"mediumImage\": \"http://img.bbystatic.com/BestBuy_US/images/products/9798/9798556fp.gif\",\
        \"thumbnailImage\": \"http://img.bbystatic.com/BestBuy_US/images/products/9798/9798556_s.gif\",\
        \"largeImage\": \"http://img.bbystatic.com/BestBuy_US/images/products/9798/9798556_sb.jpg\",\
        \"longDescription\": \"This Canon 210XL 2973B001 ink cartridge contains black ink and yields up to 401 pages,\
        so you can easily produce crisp documents using your compatible Canon PIXMA printer.\"\
    },\
    { \
        \"sku\": 9621405,\
        \"name\": \"Canon - 210XL/211XL High-Yield Ink Cartridge + Photo Paper - Multi\",\
        \"shortDescription\": \"Compatible with select Canon printers; black and color ink cartridges; 4 x 6 glossy photo paper\",\
        \"image\": \"http://img.bbystatic.com/BestBuy_US/images/products/9621/9621405_sc.jpg\",\
        \"largeFrontImage\": \"http://img.bbystatic.com/BestBuy_US/images/products/9621/9621405_sa.jpg\",\
        \"url\": \"http://www.bestbuy.com/site/canon-210xl-211xl-high-yield-ink-cartridge-photo-paper-multi/9621405.p?id=1218132461696&skuId=9621405&cmp=RMX&ky=2isIp2f6L5dFA7bKDFaLWjtoFNMpFIY3q\",\
        \"spin360Url\": null,\
        \"mobileUrl\": \"http://m.bestbuy.com/r/1218132461696/9621405/\",\
        \"addToCartUrl\": \"http://www.bestbuy.com/site/olspage.jsp?id=pcmcat152200050035&type=category&cmp=RMX&ky=2isIp2f6L5dFA7bKDFaLWjtoFNMpFIY3q&qvsids=9621405\",\
        \"onSale\": true,\
        \"regularPrice\": 43.99,\
        \"salePrice\": 39.99,\
        \"mediumImage\": \"http://img.bbystatic.com/BestBuy_US/images/products/9621/9621405fp.gif\",\
        \"thumbnailImage\": \"http://img.bbystatic.com/BestBuy_US/images/products/9621/9621405_s.gif\",\
        \"largeImage\": \"http://img.bbystatic.com/BestBuy_US/images/products/9621/9621405_sb.jpg\",\
        \"longDescription\": \"Print crisp and vibrant photos with this ink and paper combo pack that is compatible with select Canon printers.\"\
    }]}";
    
    return json;
    
}

@end
