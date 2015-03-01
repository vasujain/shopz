<?php
/**
 * Created by PhpStorm.
 * User: vasjain
 * Date: 2/28/15
 * Time: 3:00 PM
 */

class BestBuy {
    const API_KEY = "kfujvmk2euy59qp6wu4mcn5t";
    const PRODUCTS_SEARCH_URL = "http://api.remix.bestbuy.com/v1/products";
    const PRODUCTS_SEARCH_RESULT_PARAMS = "&show=sku,name,shortDescription,image,largeFrontImage,url,spin360Url,mobileUrl,addToCartUrl,onSale,regularPrice,salePrice,mediumImage,thumbnailImage,largeImage,longDescription";
    const DEALS_PARAMS = "&show=offers,sku";
    const API_FORMAT_KEY = "?format=json&apiKey=";
    const CATEGORY_URL = "http://api.remix.bestbuy.com/v1/categories";

    function getProductData($search = null) {
        if($search == null) {
            $defaultSearch = "(manufacturer=canon&salePrice%3C1000)";
        } else {
            $defaultSearch = "(search=" . $search . ")";
        }
        $url = self::PRODUCTS_SEARCH_URL . $defaultSearch . self::API_FORMAT_KEY . self::API_KEY. self::PRODUCTS_SEARCH_RESULT_PARAMS;
        $content = file_get_contents($url);
        return $content;
    }

    function getCategories() {
        $content = file_get_contents(self::CATEGORY_URL . self::API_FORMAT_KEY . self::API_KEY);
        return $content;
    }

    function getDeals() {
        $content = file_get_contents(self::PRODUCTS_SEARCH_URL . self::API_FORMAT_KEY . self::API_KEY . self::PRODUCTS_SEARCH_RESULT_PARAMS);
        return $content;
    }

    function htmlDisplay($jsonObj) {
        echo "<div style='color: gray'>";
        print_r($jsonObj);
        echo "</div>";

    }
} 