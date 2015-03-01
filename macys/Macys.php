<?php
/**
 * Created by PhpStorm.
 * User: vasjain
 * Date: 2/28/15
 * Time: 6:11 PM
 */

class Macys {
    const API_URL = "http://api.macys.com/";
    const CATALOG_SEARCH = "v4/catalog/search?searchphrase=";
    const CATEG_INDEX = "v3/catalog/category/index";
    const PROMOS_SORTED = "v3/promotions/sorted";
    const RESULT_SIZE = 24;

    private static $headersArray = array('X-Macys-Webservice-Client-Id: Launch2015', 'Accept: application/json');

    function searchCatalog($searchPhrase = null) {
        if($searchPhrase == null) {
            $defaultSearch = "jeans";
        } else {
            $defaultSearch = $searchPhrase;
        }
        $url = self::API_URL . self::CATALOG_SEARCH . $defaultSearch . "&perpage=" . self::RESULT_SIZE;
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_HTTPHEADER, self::$headersArray);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        $response = curl_exec($ch);
        curl_close($ch);
        return $response;
    }

    function getCategories() {
        $url = self::API_URL . self::CATEG_INDEX;
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_HTTPHEADER, self::$headersArray);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        $response = curl_exec($ch);
        curl_close($ch);
        return $response;
    }

    function getDeals() {
        $url = self::API_URL . self::PROMOS_SORTED;
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_HTTPHEADER, self::$headersArray);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        $response = curl_exec($ch);
        curl_close($ch);
        return $response;
    }

} 