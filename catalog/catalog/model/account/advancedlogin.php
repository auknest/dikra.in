<?php

class ModelAccountadvancedlogin extends Model {

    public function checkmailid($data) {

        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "customer WHERE LOWER(email) = '" . $this->db->escape(utf8_strtolower($data['email'])) . "'");

        return $query->row;
    }

    public function address($data) {


        $lccode = $this->config->get('config_language_id');
        $customer_id = $this->customer->getId();


        if ((!isset($data['firstname'])) || ($data['firstname'] == '')) {
            $data['firstname'] = $this->customer->getFirstName();
        }


        if ((!isset($data['lastname'])) || ($data['lastname'] == '')) {
            $data['lastname'] = "";
        }


        if ((!isset($data['fax'])) || ($data['fax'] == '')) {
            $data['fax'] = "";
        }

        if ((!isset($data['telephone'])) || ($data['telephone'] == '')) {
            $data['telephone'] = "";
        }
        if ((!isset($data['company'])) || ($data['company'] == '')) {
            $data['company'] = "";
        }

        if ((!isset($data['address_1'])) || ($data['address_1'] == '')) {
            $data['address_1'] = "";
        }

        if ((!isset($data['address_2'])) || ($data['address_2'] == '')) {
            $data['address_2'] = "";
        }

        if ((!isset($data['city'])) || ($data['city'] == '')) {
            $data['city'] = "";
        }


        if ((!isset($data['postcode'])) || ($data['postcode'] == '')) {
            $data['postcode'] = "";
        }


        if ((!isset($data['country_id'])) || ($data['country_id'] == '')) {
            $data['country_id'] = "";
        }

        if ((!isset($data['zone_id'])) || ($data['zone_id'] == '')) {
            $data['zone_id'] = "";
        }

        $this->db->query("UPDATE " . DB_PREFIX . "customer SET firstname = '" . $this->db->escape($data['firstname']) . "', lastname = '" . $this->db->escape($data['lastname']) . "', telephone = '" . $this->db->escape($data['telephone']) . "', fax = '" . $this->db->escape($data['fax']) . "' WHERE customer_id = '" . (int) $customer_id . "'");

        $this->db->query("INSERT INTO " . DB_PREFIX . "address SET customer_id = '" . (int) $customer_id . "', firstname = '" . $this->db->escape($data['firstname']) . "', lastname = '" . $this->db->escape($data['lastname']) . "', company = '" . $this->db->escape($data['company']) . "',  address_1 = '" . $this->db->escape($data['address_1']) . "', address_2 = '" . $this->db->escape($data['address_2']) . "', city = '" . $this->db->escape($data['city']) . "', postcode = '" . $this->db->escape($data['postcode']) . "', country_id = '" . (int) $data['country_id'] . "', zone_id = '" . (int) $data['zone_id'] . "'");

        $address_id = $this->db->getLastId();

        $this->db->query("UPDATE " . DB_PREFIX . "customer SET address_id = '" . (int) $address_id . "' WHERE customer_id = '" . (int) $customer_id . "'");



        //	$this->registeremail($data);
        //	$this->adminemailsub($data);
    }

    public function register($data, $local = 1) {

        $lccode = $this->config->get('config_language_id');
        $customer_group_id = $this->config->get('advancedlogin_customer_group');

        $this->session->data['fieldrequired'] = array();

        if ($local == 3) {

            $this->session->data['fieldrequired'] += array("firstname" => "firstname",);
            $this->session->data['fieldrequired'] += array("lastname" => "lastname",);
        } else {
            $this->session->data['fieldrequired'] += array("lastname" => "lastname",);
        }



        if (!isset($data['firstname'])) {
            $data['firstname'] = strstr($data['email'], '@', true);
        }



        if ((!isset($data['fax'])) && ($this->config->get('advancedlogin_fax'))) {
            $this->session->data['fieldrequired'] += array("fax" => "fax",);
        }

        if ((!isset($data['telephone'])) && ($this->config->get('advancedlogin_telephone'))) {
            $this->session->data['fieldrequired'] += array("telephone" => "telephone",);
        }
        if ((!isset($data['company'])) && ($this->config->get('advancedlogin_company'))) {
            $this->session->data['fieldrequired'] += array("company" => "company",);
        }

        if ((!isset($data['address_1'])) && ($this->config->get('advancedlogin_address'))) {
            $this->session->data['fieldrequired'] += array("address_1" => "address_1",);
            $this->session->data['fieldrequired'] += array("address_2" => "address_2",);
        }

        if ((!isset($data['city'])) && ($this->config->get('advancedlogin_city'))) {
            $this->session->data['fieldrequired'] += array("city" => "city",);
        }


        if ((!isset($data['postcode'])) && ($this->config->get('advancedlogin_postcode'))) {
            $this->session->data['fieldrequired'] += array("postcode" => "postcode",);
        }



        if ((!isset($data['country_id'])) && ($this->config->get('advancedlogin_country'))) {
            $this->session->data['fieldrequired'] += array("country_id" => "country_id",);
        }

        if ((!isset($data['zone_id'])) && ($this->config->get('advancedlogin_zone'))) {
            $this->session->data['fieldrequired'] += array("zone_id" => "zone_id",);
        }


        $this->db->query("INSERT INTO " . DB_PREFIX . "customer SET store_id = '" . (int) $this->config->get('config_store_id') . "', email = '" . $this->db->escape($data['email']) . "', firstname = '" . $this->db->escape($data['firstname']) . "', salt = '" . $this->db->escape($salt = substr(md5(uniqid(rand(), true)), 0, 9)) . "', newsletter = '0', customer_group_id = '" . (int) $customer_group_id . "', ip = '" . $this->db->escape($this->request->server['REMOTE_ADDR']) . "', status = '1', approved = '1', password = '" . $this->db->escape(sha1($salt . sha1($salt . sha1($data['password'])))) . "', date_added = NOW()");


        $this->registeremail($data);
    }

    public function registeremail($data) {
        if ($this->config->get('advancedlogin_enableemail')) {
            $language_id = $this->config->get('config_language_id');
            $store_name = $this->config->get('config_name');
            $storeurl = $this->config->get('config_url');
            $storeemail = $this->config->get('config_email');
            $storeimage = sprintf($storeurl . "/image/" . $this->config->get('config_logo'));
            $storeimage = '<img style="padding: 1px; border: 1px solid #DDDDDD;" src="' . $storeimage . '" />';

            $username = $data['firstname'];
            $email_id = $data['email'];
            $password = $data['password'];





            if ($this->config->get('advancedlogin_autocoupon')) {
                $random_id_length = 6;
                $rnd_id = crypt(uniqid(rand(), 1));
                $rnd_id = strip_tags(stripslashes($rnd_id));
                $rnd_id = str_replace(".", "", $rnd_id);
                $rnd_id = strrev(str_replace("/", "", $rnd_id));
                $rnd_id = substr($rnd_id, 0, $random_id_length);
                $prefix_length = 4;
                $prefix = substr($this->config->get('advancedlogin_coupon_prefix'), 0, $prefix_length);
                $discountCode = strtoupper(sprintf($prefix . '' . $rnd_id));

                $startDate = date("Y-m-d");
                $week = sprintf('+ ' . $this->config->get('advancedlogin_coupon_weeks') . ' week');
                $endDate = date('Y-m-d', strtotime($week, strtotime($startDate)));
                $endDate2 = date('d-m-Y', strtotime($week, strtotime($startDate)));



                $this->db->query("INSERT INTO " . DB_PREFIX . "coupon (name, code, type, discount, logged, shipping, total, date_start, date_end, uses_total, uses_customer, status, date_added)
   VALUES ('" . $this->config->get('advancedlogin_coupon_name') . "', '" . $discountCode . "', '" . $this->config->get('advancedlogin_coupon_type') . "', '" . $this->config->get('advancedlogin_coupon_discount') . "', '" . $this->config->get('advancedlogin_coupon_login') . "', '" . $this->config->get('advancedlogin_coupon_shipping') . "', '" . $this->config->get('advancedlogin_coupon_total') . "', '" . $startDate . "', '" . $endDate . "', '" . $this->config->get('advancedlogin_coupon_uses') . "', '1', '1', '" . $startDate . "')");


                $id = $this->db->query("SELECT MAX(coupon_id) As coupon_id FROM " . DB_PREFIX . "coupon");
                $id = $id->row['coupon_id'];

                $categories = $this->db->query("SELECT category_id AS category_id  FROM " . DB_PREFIX . "category");
                foreach ($categories->rows as $category) {

                    $category = $category['category_id'];

                    $this->db->query("INSERT INTO " . DB_PREFIX . "coupon_category SET coupon_id = '" . (int) $id . "', category_id = '" . (int) $category . "'");
                }

                $mail_subject = $this->config->get('advancedlogin_autoemailsubject_' . $language_id);
                $mail_message = html_entity_decode($this->config->get('advancedlogin_autoemailbody_' . $language_id), ENT_QUOTES, 'UTF-8');



                $mail_subject = str_replace('{store_name}', $store_name, $mail_subject);
                $mail_subject = str_replace('{user_name}', $username, $mail_subject);
                $mail_subject = str_replace('{user_email}', $email_id, $mail_subject);


                $mail_message = str_replace('{store_name}', $store_name, $mail_message);
                $mail_message = str_replace('{store_url}', $storeurl, $mail_message);
                $mail_message = str_replace('{store_logo}', $storeimage, $mail_message);
                $mail_message = str_replace('{user_name}', $username, $mail_message);
                $mail_message = str_replace('{user_email}', $email_id, $mail_message);
                $mail_message = str_replace('{user_password}', $password, $mail_message);
                $mail_message = str_replace('{ac_validupto}', $endDate2, $mail_message);
                $mail_message = str_replace('{ac_coupon}', $discountCode, $mail_message);
            } else {
                $mail_subject = $this->config->get('advancedlogin_emailsubject_' . $language_id);
                $mail_message = html_entity_decode($this->config->get('advancedlogin_emailbody_' . $language_id), ENT_QUOTES, 'UTF-8');



                $mail_subject = str_replace('{store_name}', $store_name, $mail_subject);
                $mail_subject = str_replace('{user_name}', $username, $mail_subject);
                $mail_subject = str_replace('{user_email}', $email_id, $mail_subject);


                $mail_message = str_replace('{store_name}', $store_name, $mail_message);
                $mail_message = str_replace('{store_url}', $storeurl, $mail_message);
                $mail_message = str_replace('{store_logo}', $storeimage, $mail_message);
                $mail_message = str_replace('{user_name}', $username, $mail_message);
                $mail_message = str_replace('{user_email}', $email_id, $mail_message);
                $mail_message = str_replace('{user_password}', $password, $mail_message);
            }



            $mail = new Mail($this->config->get('config_mail'));
            $mail->setSubject($mail_subject);
            $mail->setHtml($mail_message);

            $mail->setFrom($storeemail);
            $mail->setSender($store_name);
            $mail->setTo($email_id);

            $mail->send();
        }
    }

}

?>
