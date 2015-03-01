<?php
/**
 * Created by PhpStorm.
 * User: vasjain
 * Date: 2/27/15
 * Time: 3:32 AM
 */

class Payment {
    var $intent;
    var $redirect_urls = array();
    var $transactions = array();
    var $payer = array();

    /**
     * @return array
     */
    public function getPayer() {
        return $this->payer;
    }

    /**
     * @param array $payer
     */
    public function setPayer($payer) {
        $this->payer = $payer;
    }

    /**
     * @return array
     */
    public function getTransactions() {
        return $this->transactions;
    }

    /**
     * @param array $transactions
     */
    public function setTransactions($transactions) {
        $this->transactions = $transactions;
    }

    public function getRedirectUrls() {
        return $this->redirect_urls;
    }

    public function setRedirectUrls($redirecturls) {
        return $this->redirect_urls = $redirecturls;
    }

    /**
     * @return mixed
     */
    public function getIntent() {
        return $this->intent;
    }

    /**
     * @param mixed $intent
     */
    public function setIntent($intent) {
        $this->intent = $intent;
    }

}