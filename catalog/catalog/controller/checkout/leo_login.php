<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of leo_login
 * 
 * @author leometric
 * 
 * developed by V2
 * Copyright 2018 Leometric Technology. All Rights Reserved.
 */
class ControllerCheckoutLeoLogin extends Controller {

    public function index() {
        $this->load->language('checkout/checkout');

        $data['text_checkout_account'] = $this->language->get('text_checkout_account');
        $data['text_checkout_payment_address'] = $this->language->get('text_checkout_payment_address');
        $data['text_new_customer'] = $this->language->get('text_new_customer');
        $data['text_returning_customer'] = $this->language->get('text_returning_customer');
        $data['text_checkout'] = $this->language->get('text_checkout');
        $data['text_register'] = $this->language->get('text_register');
        $data['text_guest'] = $this->language->get('text_guest');
        $data['text_i_am_returning_customer'] = $this->language->get('text_i_am_returning_customer');
        $data['text_register_account'] = $this->language->get('text_register_account');
        $data['text_forgotten'] = $this->language->get('text_forgotten');
        $data['text_loading'] = $this->language->get('text_loading');

        $data['entry_email'] = $this->language->get('entry_email');
        $data['entry_password'] = $this->language->get('entry_password');

        $data['button_continue'] = $this->language->get('button_continue');
        $data['button_login'] = $this->language->get('button_login');

        $data['checkout_guest'] = ($this->config->get('config_checkout_guest') && !$this->config->get('config_customer_price') && !$this->cart->hasDownload());
        if (isset($this->session->data['account'])) {
            $data['account'] = $this->session->data['account'];
        } else {
            $data['account'] = 'register';
        }
        $data['forgotten'] = $this->url->link('account/forgotten', '', true);
        //          BOF Social Log in
        if (!$this->customer->isLogged()) {
            if (!isset($this->advancedlogin)) {

                if (!class_exists('BaseFacebook')) {
                    require_once(DIR_SYSTEM . 'vendor/facebook-sdk/facebook.php');
                }
                $this->advancedlogin = new Facebook(array(
                    'appId' => $this->config->get('advancedlogin_apikey'),
                    'secret' => $this->config->get('advancedlogin_apisecret'),
                ));
            }
            $data['advancedlogin_url'] = $this->advancedlogin->getLoginUrl(
                    array(
                        'scope' => 'public_profile, email',
                        'redirect_uri' => $this->url->link('account/advancedlogin', '', 'SSL')
                    )
            );
            $data['advancedlogin'] = $this->config->get('advancedlogin');
            if (!isset($this->googleObject)) {
                if (!class_exists('Google')) {
                    require_once(DIR_SYSTEM . 'vendor/google-api/Google_Client.php');
                }
                $this->googleObject = new Google_Client();
                $this->googleObject->setClientId($this->config->get('advancedlogin_gclientid'));


                $this->googleObject->setClientSecret($this->config->get('advancedlogin_gapi'));
                $this->googleObject->setRedirectUri($this->url->link('account/advancedlogingoogle', '', 'SSL'));
                $this->googleObject->setScopes(array('https://www.googleapis.com/auth/userinfo.profile', 'https://www.googleapis.com/auth/userinfo.email'));
            }





            $data['advancedlogin_furl'] = $this->googleObject->createAuthUrl();
        }
        $data['genable'] = $this->config->get('advancedlogin_enablegoogle');
        $data['fbenable'] = $this->config->get('advancedlogin_enablefb');
        $language_id = $this->config->get('config_language_id');
        $data['fbbutton'] = "image/" . $this->config->get('advancedlogin_' . $language_id . '_fbutton');
        $data['gbutton'] = "image/" . $this->config->get('advancedlogin_' . $language_id . '_gbutton');
//     EOF Social Log in
        $this->response->setOutput($this->load->view('checkout/leo_login', $data));
    }

    public function save() {
        $this->load->language('checkout/checkout');

        $json = array();

        if ($this->customer->isLogged()) {
            $json['redirect'] = $this->url->link('checkout/leo_checkout', '', true);
        }

        if ((!$this->cart->hasProducts() && empty($this->session->data['vouchers'])) || (!$this->cart->hasStock() && !$this->config->get('config_stock_checkout'))) {
            $json['redirect'] = $this->url->link('checkout/cart');
        }

        if (!$json) {
            $this->load->model('account/customer');

            // Check how many login attempts have been made.
            $login_info = $this->model_account_customer->getLoginAttempts($this->request->post['email']);

            if ($login_info && ($login_info['total'] >= $this->config->get('config_login_attempts')) && strtotime('-1 hour') < strtotime($login_info['date_modified'])) {
                $json['error']['warning'] = $this->language->get('error_attempts');
            }

            // Check if customer has been approved.
            $customer_info = $this->model_account_customer->getCustomerByEmail($this->request->post['email']);

            if (!$customer_info) {
                $customer_info = $this->model_account_customer->getCustomerByTelephone($this->request->post['email']);
            }
            if ($customer_info && !$customer_info['approved']) {
                $json['error']['warning'] = $this->language->get('error_approved');
            }

            if (!isset($json['error'])) {
                if (!$this->customer->login($this->request->post['email'], $this->request->post['password'])) {
                    $json['error']['warning'] = $this->language->get('error_login');

                    $this->model_account_customer->addLoginAttempt($this->request->post['email']);
                } else {
                    $this->model_account_customer->deleteLoginAttempts($this->request->post['email']);
                }
            }
        }

        if (!$json) {
            // Unset guest
            unset($this->session->data['guest']);

            // Default Shipping Address
            $this->load->model('account/address');

            if ($this->config->get('config_tax_customer') == 'payment') {
                $this->session->data['payment_address'] = $this->model_account_address->getAddress($this->customer->getAddressId());
            }

            if ($this->config->get('config_tax_customer') == 'shipping') {
                $this->session->data['shipping_address'] = $this->model_account_address->getAddress($this->customer->getAddressId());
            }

            // Wishlist
            if (isset($this->session->data['wishlist']) && is_array($this->session->data['wishlist'])) {
                $this->load->model('account/wishlist');

                foreach ($this->session->data['wishlist'] as $key => $product_id) {
                    $this->model_account_wishlist->addWishlist($product_id);

                    unset($this->session->data['wishlist'][$key]);
                }
            }

            // Add to activity log
            if ($this->config->get('config_customer_activity')) {
                $this->load->model('account/activity');

                $activity_data = array(
                    'customer_id' => $this->customer->getId(),
                    'name' => $this->customer->getFirstName() . ' ' . $this->customer->getLastName()
                );

                $this->model_account_activity->addActivity('login', $activity_data);
            }

            $json['redirect'] = $this->url->link('checkout/leo_checkout', '', true);
        }

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }

}
