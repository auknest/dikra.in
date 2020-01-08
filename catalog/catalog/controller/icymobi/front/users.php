<?php

    /**
     * Copyright © 2016 Inspius. All rights reserved.
     * Author: Khanh Tran
     * Author URI: http://inspius.com
     */
    require_once("api.php");

    class ControllerIcymobiFrontUsers extends ControllerIcymobiFrontApi
    {

        const USER_ACTION_LOGIN = 'login';
        const USER_ACTION_LOGIN_SOCIAL = 'loginSocial';
        const USER_ACTION_REGISTER = 'register';
        const USER_ACTION_FORGOT = 'forgot';
        const USER_ACTION_UPDATE = 'update';
        const USER_ACTION_UPDATE_SHIPPING = 'update_shipping';
        const USER_ACTION_UPDATE_BILLING = 'update_billing';

        protected $id_lang_default;

        protected function _getResponse()
        {
            $task = $this->request->get['task'];
            $response = 'cdcd';
            switch ($task)
            {
                case self::USER_ACTION_REGISTER : 
                    $response = $this->_register();
                    break;
                case self::USER_ACTION_FORGOT : 
                    $response = $this->_forgotPassword();
                    break;
                case self::USER_ACTION_LOGIN : 
                    $response = $this->_login();
                    break;
                case self::USER_ACTION_UPDATE:
                    $data = $this->_updateCustomer();
                    break;
                case self::USER_ACTION_UPDATE_BILLING:
                    $data = $this->_updateAddress();
                    break;
                case self::USER_ACTION_UPDATE_SHIPPING:
                    $data = $this->_updateAddress(false);
                    break;
            }
            return $response;
        }
        
        function handleLoginSocial() 
        {
            $platform = Tools::getValue('socialPlatform');
            if($platform  == 'google') {
                return $this->_loginGoogleSocial();
            }
            if($platform == 'facebook') {
                return $this->_loginFacebookSocial();
            }
        }
            
        protected function _loginFacebookSocial()
        {
            $passwd = 'facebook123';
            $email = Tools::getValue('email');
            $gender = Tools::getValue('gender');
            $name = Tools::getValue('name');
//            $picture = Tools::getValue('picture');
            $picture = Tools::getValue('picture_large');
            if($gender && $gender == 'male') {
                $id_gender = 1;
            } elseif($gender && $gender == 'female') {
                $id_gender = 2;
            } else {
                $id_gender = 0;
        }
        
            
            $userObj = new Customer();
            $exists = $userObj->customerExists($email);
            if (!$exists == TRUE) {
                $user = new Customer();
                
                $user->firstname = substr($name, 0, strpos($name ,' ', 0));
                $user->lastname = substr($name, strpos($name ,' ', 0));
                $user->email = $email;
                $user->id_gender = $id_gender;
                $user->passwd = Tools::encrypt($passwd);
                $user->newsletter = 0;

                $user->id_shop = ($user->id_shop) ? $user->id_shop : Context::getContext()->shop->id;
                $user->id_shop_group = ($user->id_shop_group) ? $user->id_shop_group : Context::getContext()->shop->id_shop_group;
                $user->id_lang = ($user->id_lang) ? $user->id_lang : Context::getContext()->language->id;
                $user->secure_key = md5(uniqid(rand(), true));
                $user->last_passwd_gen = date('Y-m-d H:i:s', strtotime('-' . Configuration::get('PS_PASSWD_TIME_FRONT') . 'minutes'));

                $success = $user->add($autodate = true, $null_values = true);
                if ($success == FALSE) {
                    throw new Exception('Sorry ,something is wrong!');
                }
                $user->updateGroup($user->groupBox);
            } else {
                $user = $userObj->getByEmail($email);
            }
            $return = array (
                "id"            => (int) $user->id,
                "date_created"  => "$user->date_add",
                "date_modified" => $user->date_upd,
                "email"         => $user->email,
                "first_name"    => $user->firstname,
                "last_name"     => $user->lastname,
                "username"      => null,
                "last_order"    => array(
                    "id"   => "",
                    "date" => ""
                ),
                "orders_count"  => 0,
                "total_spent"   => "0.00",
                "avatar_url"    => "$picture",
                "billing"       => array(
                    "first_name" => "",
                    "last_name"  => "",
                    "company"    => "",
                    "address_1"  => "",
                    "address_2"  => "",
                    "city"       => "",
                    "state"      => "",
                    "postcode"   => "",
                    "country"    => "",
                    "email"      => "",
                    "phone"      => ""
                ),
                "shipping"      => array(
                    "first_name" => "",
                    "last_name"  => "",
                    "company"    => "",
                    "address_1"  => "",
                    "address_2"  => "",
                    "city"       => "",
                    "state"      => "",
                    "postcode"   => "",
                    "country"    => ""
                ),
                "_links"        => array(
                    "self"       => array(
                        array(
                            "href" => ''
                        )
                    ),
                    "collection" => array(
                        array(
                            "href" => ""
                        )
                    )
                ),
                "avatar"        => ""
            );
            return $return;
        }
        protected function _loginGoogleSocial()
        {
            $passwd = 'google123';
            $email = Tools::getValue('email');
            $gender = Tools::getValue('gender');
            $name = Tools::getValue('name');
            $picture = Tools::getValue('picture');
            if($gender && $gender == 'male') {
                $id_gender = 1;
            } elseif($gender && $gender == 'female') {
                $id_gender = 2;
            } else {
                $id_gender = 0;
            }
            
            
            $userObj = new Customer();
            $exists = $userObj->customerExists($email);
            if (!$exists == TRUE) {
                $user = new Customer();
                
                $user->firstname = substr($name, 0, strpos($name ,' ', 0));
                $user->lastname = substr($name, strpos($name ,' ', 0));
                $user->email = $email;
                $user->id_gender = $id_gender;
                $user->passwd = Tools::encrypt($passwd);
                $user->newsletter = 0;

                $user->id_shop = ($user->id_shop) ? $user->id_shop : Context::getContext()->shop->id;
                $user->id_shop_group = ($user->id_shop_group) ? $user->id_shop_group : Context::getContext()->shop->id_shop_group;
                $user->id_lang = ($user->id_lang) ? $user->id_lang : Context::getContext()->language->id;
                $user->secure_key = md5(uniqid(rand(), true));
                $user->last_passwd_gen = date('Y-m-d H:i:s', strtotime('-' . Configuration::get('PS_PASSWD_TIME_FRONT') . 'minutes'));

                $success = $user->add($autodate = true, $null_values = true);
                if ($success == FALSE) {
                    throw new Exception('Sorry ,something is wrong!');
                }
                $user->updateGroup($user->groupBox);
            } else {
                $user = $userObj->getByEmail($email);
            }
            $return = array (
                "id"            => (int) $user->id,
                "date_created"  => "$user->date_add",
                "date_modified" => $user->date_upd,
                "email"         => $user->email,
                "first_name"    => $user->firstname,
                "last_name"     => $user->lastname,
                "username"      => null,
                "last_order"    => array(
                    "id"   => "",
                    "date" => ""
                ),
                "orders_count"  => 0,
                "total_spent"   => "0.00",
                "avatar_url"    => "$picture",
                "billing"       => array(
                    "first_name" => "",
                    "last_name"  => "",
                    "company"    => "",
                    "address_1"  => "",
                    "address_2"  => "",
                    "city"       => "",
                    "state"      => "",
                    "postcode"   => "",
                    "country"    => "",
                    "email"      => "",
                    "phone"      => ""
                ),
                "shipping"      => array(
                    "first_name" => "",
                    "last_name"  => "",
                    "company"    => "",
                    "address_1"  => "",
                    "address_2"  => "",
                    "city"       => "",
                    "state"      => "",
                    "postcode"   => "",
                    "country"    => ""
                ),
                "_links"        => array(
                    "self"       => array(
                        array(
                            "href" => ''
                        )
                    ),
                    "collection" => array(
                        array(
                            "href" => ""
                        )
                    )
                ),
                "avatar"        => ""
            );
            return $return;
        }

        protected function _login()
        {   
            $this->load->model('account/customer');
            if($this->validateLogin()) {
                // Add to activity log
                if ($this->config->get('config_customer_activity')) {
                    $this->load->model('account/activity');

                    $activity_data = array(
                            'customer_id' => $this->customer->getId(),
                            'name'        => $this->customer->getFirstName() . ' ' . $this->customer->getLastName()
                    );

                    $this->model_account_activity->addActivity('login', $activity_data);
                }
            } else {
                throw new Exception(MessageIcy::USER_LOGIN_FAILED);
            }
            $customer = $this->model_account_customer->getCustomer($this->customer->getId());
            $response = $this->formatResponse((array)$customer);
            return $response;
        }
        
        protected function validateLogin() {
            $err = false;
            // Check how many login attempts have been made.
            $login_info = $this->model_account_customer->getLoginAttempts($this->request->post['user_login']);

            if ($login_info && ($login_info['total'] >= $this->config->get('config_login_attempts')) && strtotime('-1 hour') < strtotime($login_info['date_modified'])) {
                $err = true;
                throw new Exception(MessageIcy::USER_LOGIN_EXCEEDED_ATTEMPTS);
            }

            // Check if customer has been approved.
            $customer_info = $this->model_account_customer->getCustomerByEmail($this->request->post['user_login']);

            if ($customer_info && !$customer_info['approved']) {
                $err = true;
                throw new Exception(MessageIcy::USER_LOGIN_NOT_APPROVED);
            }

            if (!$err) {
                if (!$this->customer->login($this->request->post['user_login'], $this->request->post['user_pass'])) {
                    $err = true;

                    $this->model_account_customer->addLoginAttempt($this->request->post['user_login']);
                } else {
                    $this->model_account_customer->deleteLoginAttempts($this->request->post['user_login']);
                }
            }

            return !$err;
	}
        
        protected function _register()
        {
            $password = $this->request->post['user_pass'];
            $email = $this->request->post['user_email'];
            $firstname = $this->request->post['first_name'];
            $lastname = $this->request->post['last_name'];
            $newsletter = @$this->request->post['newsletter']?:FALSE;
            
            $this->load->model('account/customer');
            
            $this->validateRegister();
            
            $data = array();
            if($newsletter == 1) {
                $data = compact('password', 'email', 'firstname', 'lastname', 'newsletter');
            } else {
                $data = compact('password', 'email', 'firstname', 'lastname');
            }
            $data['telephone'] = '';
            $data['fax'] = '';
            $data['company'] = '';
            $data['address_1'] = '';
            $data['address_2'] = '';
            $data['city'] = '';
            $data['postcode'] = '';
            $data['country_id'] = '';
            $data['zone_id'] = '';
            $customer_id = $this->model_account_customer->addCustomer($data);

            // Clear any previous login attempts for unregistered accounts.
            $this->model_account_customer->deleteLoginAttempts($email);
            
            $customer = $this->model_account_customer->getCustomer($customer_id);
            
            if ($this->config->get('config_customer_activity')) {
                $this->load->model('account/activity');

                $activity_data = array(
                        'customer_id' => $customer_id,
                        'name'        => $customer->firstname . ' ' . $customer->lastname
                );

                $this->model_account_activity->addActivity('register', $activity_data);
            }
            
            $reponse = $this->formatResponse($customer);
            
            return $reponse;
        }
        
        private function validateRegister() {
            if ((utf8_strlen(trim($this->request->post['first_name'])) < 1) || (utf8_strlen(trim($this->request->post['first_name'])) > 32)) {
                throw new Exception(MessageIcy::USER_REGISTER_USER_LOGIN_TOO_LONG);
            }

            if ((utf8_strlen(trim($this->request->post['last_name'])) < 1) || (utf8_strlen(trim($this->request->post['last_name'])) > 32)) {
                throw new Exception(MessageIcy::USER_REGISTER_USER_LOGIN_TOO_LONG);
            }

            if ((utf8_strlen($this->request->post['user_email']) > 96) || !filter_var($this->request->post['user_email'], FILTER_VALIDATE_EMAIL)) {
                throw new Exception(MessageIcy::USER_LOGIN_INVALID_EMAIL);
            }

            if ($this->model_account_customer->getTotalCustomersByEmail($this->request->post['user_email'])) {
                throw new Exception(MessageIcy::USER_REGISTER_EXISTING_USER_EMAIL);
            }

            if ((utf8_strlen($this->request->post['user_pass']) < 4) || (utf8_strlen($this->request->post['user_pass']) > 20)) {
                throw new Exception(MessageIcy::USER_REGISTER_PASSWORD_INVALID);
            }

            if ($this->request->post['user_confirmpass'] != $this->request->post['user_pass']) {
                throw new Exception(MessageIcy::USER_REGISTER_PASSWORD_NOT_MACTH_CONFIRM);
            }

            return !$this->error;
	}
        
        public function formatResponse(array $customer)
        {
            $response = array (
                "id"            => (int) $customer['customer_id'],
                "date_created"  => $customer['date_added'],
                "date_modified" => $customer['date_added'],
                "email"         => $customer['email'],
                "first_name"    => $customer['firstname'],
                "last_name"     => $customer['lastname'],
                "username"      => null,
                "last_order"    => array(
                    "id"   => "",
                    "date" => ""
                ),
                "orders_count"  => 0,
                "total_spent"   => "0.00",
                "avatar_url"    => "",
                "billing"       => array(
                    "first_name" => "",
                    "last_name"  => "",
                    "company"    => "",
                    "address_1"  => "",
                    "address_2"  => "",
                    "city"       => "",
                    "state"      => "",
                    "postcode"   => "",
                    "country"    => "",
                    "email"      => "",
                    "phone"      => ""
                ),
                "shipping"      => array(
                    "first_name" => "",
                    "last_name"  => "",
                    "company"    => "",
                    "address_1"  => "",
                    "address_2"  => "",
                    "city"       => "",
                    "state"      => "",
                    "postcode"   => "",
                    "country"    => ""
                ),
                "_links"        => array(
                    "self"       => array(
                        array(
                            "href" => ''
                        )
                    ),
                    "collection" => array(
                        array(
                            "href" => ""
                        )
                    )
                ),
                "avatar"        => ""
            );
            return $response;
        }

        protected function _forgotPassword()
        {   
            $this->load->model('account/customer');
            
            $this->validateForgotPassword();
            
            $code = token(40);
            
            $this->model_account_customer->editCode($this->request->post['user_login'], $code);

            $subject = sprintf($this->language->get('text_subject'), html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'));

            $message  = sprintf($this->language->get('text_greeting'), html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8')) . "\n\n";
            $message .= $this->language->get('text_change') . "\n\n";
            $message .= $this->url->link('account/reset', 'code=' . $code, true) . "\n\n";
            $message .= sprintf($this->language->get('text_ip'), $this->request->server['REMOTE_ADDR']) . "\n\n";
            
            $mail = new Mail();
            $mail->protocol = $this->config->get('config_mail_protocol');
            $mail->parameter = $this->config->get('config_mail_parameter');
            $mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
            $mail->smtp_username = $this->config->get('config_mail_smtp_username');
            $mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
            $mail->smtp_port = $this->config->get('config_mail_smtp_port');
            $mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');

            $mail->setTo($this->request->post['user_login']);
            $mail->setFrom($this->config->get('config_email'));
            $mail->setSender(html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'));
            $mail->setSubject(html_entity_decode($subject, ENT_QUOTES, 'UTF-8'));
            $mail->setText(html_entity_decode($message, ENT_QUOTES, 'UTF-8'));
            $mail->send();
            
            // Add to activity log
            if ($this->config->get('config_customer_activity')) {
                $customer_info = $this->model_account_customer->getCustomerByEmail($this->request->post['user_login']);

                if ($customer_info) {
                    $this->load->model('account/activity');

                    $activity_data = array(
                            'customer_id' => $customer_info['customer_id'],
                            'name'        => $customer_info['firstname'] . ' ' . $customer_info['lastname']
                    );

                    $this->model_account_activity->addActivity('forgotten', $activity_data);
                }
            }
            return true;
        }
        
        protected function validateForgotPassword() {
		if (!isset($this->request->post['user_login'])) {
                    throw new Exception(MessageIcy::USER_FORGOT_INVALID_DATA);
		} elseif (!$this->model_account_customer->getTotalCustomersByEmail($this->request->post['user_login'])) {
                    throw new Exception(MessageIcy::USER_FORGOT_USER_NOT_EXIST);
		}

		$customer_info = $this->model_account_customer->getCustomerByEmail($this->request->post['user_login']);

		if ($customer_info && !$customer_info['approved']) {
                    throw new Exception(MessageIcy::USER_FORGOT_CANNOT_RESET);
		}

		return !$this->error;
	}
        
        protected function _updateCustomer()
        {
            $firstname = $this->request->request['user_firstname'];
            $lastname = $this->request->request['user_lastname'];
            $email = $this->request->request['user_email'];
            $passwd = $this->request->request['user_pass'];
            $newPasswd = $this->request->request['user_new_password'];
            $newPasswdConfirm = $this->request->request['user_confirmation'];
            $userId = intval($this->request->request['user_id']);
            
            
            if(empty($firstname)) {
                throw new Exception('Invalid firstname');
            }
            
            if(empty($lastname)) {
                throw new Exception('Invalid lastname');
            }
            
            if(empty($email)) {
                throw new Exception('Invalid email');
            }
            
            if(empty($userId) || !is_integer($userId)) {
                throw new Exception('Please login to change personal infomations');
            }
            
            $this->load->model('account/customer');
            $customerInfo = $this->model_account_customer->getCustomer($userId);
            
            if(!$customerInfo) {
                throw new Exception('User is not exist');
            }
            
            if(empty($passwd) && (!empty($newPasswd) || !empty($newPasswdConfirm)) ) {
                throw new Exception('Please type current password to change password');
            }
            
            if(!empty($passwd) && (empty($newPasswd) || empty($newPasswdConfirm)) ) {
                throw new Exception('Please fill in new password and re confirm new password to change personal infomations');
            }
            
            if(!empty($passwd) && ($newPasswd != $newPasswdConfirm) ) {
                throw new Exception('Please type correct new password and re confirm new password to change personal infomations');
            }
            $this->customer->login($email, $passwd);
            if(!empty($passwd) && ($this->customer->login($email, $passwd)) != true ) {
                throw new Exception('wrong current password');
            }
            
            $updateData = array();
            if(!empty($firstname)) {
                $updateData['firstname'] = $firstname;
            }
            if(!empty($lastname)) { 
                $updateData['lastname'] = $lastname;
            }
            if(!empty($email)) { 
                $updateData['email'] = $email;
            }
            
            $this->model_account_customer->editCustomer($updateData);
            if(!empty($newPasswd)) {
                $this->model_account_customer->editPassword($email, $newPasswd);
            }
            
            return true;
        }

        protected function _updateAddress($isBilling = true)
        {
            return array();
        }

    }
    