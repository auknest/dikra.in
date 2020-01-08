<?php

class ModelSaleOrder extends Model {

//staging 
      //private $dotzot_customer_code = 'CC000100132';
      //private $dotzot_ClientId = 'DOTZOT';
     // private $dotzot_user_name = 'dztuser';
     // private $dotzot_password = 'dotzot@2013';
     // private $dotzot_domain = "http://instacom-staging.azurewebsites.net/";
//Live
    private $dotzot_customer_code = 'SP000103213';
    private $dotzot_ClientId = 'INSTACOM';
    private $dotzot_user_name = 'instauser';
   private $dotzot_password = 'insta2013';
   private $dotzot_domain = "https://instacom.azurewebsites.net/";

            

    public function deleteOrder($order_id) {
        $this->db->query("DELETE FROM `" . DB_PREFIX . "order` WHERE order_id = '" . (int) $order_id . "'");
        $this->db->query("DELETE FROM `" . DB_PREFIX . "order_product` WHERE order_id = '" . (int) $order_id . "'");
        $this->db->query("DELETE FROM `" . DB_PREFIX . "order_option` WHERE order_id = '" . (int) $order_id . "'");
        $this->db->query("DELETE FROM `" . DB_PREFIX . "order_voucher` WHERE order_id = '" . (int) $order_id . "'");
        $this->db->query("DELETE FROM `" . DB_PREFIX . "order_total` WHERE order_id = '" . (int) $order_id . "'");
        $this->db->query("DELETE FROM `" . DB_PREFIX . "order_history` WHERE order_id = '" . (int) $order_id . "'");
        $this->db->query("DELETE `or`, ort FROM `" . DB_PREFIX . "order_recurring` `or`, `" . DB_PREFIX . "order_recurring_transaction` `ort` WHERE order_id = '" . (int) $order_id . "' AND ort.order_recurring_id = `or`.order_recurring_id");
        $this->db->query("DELETE FROM `" . DB_PREFIX . "affiliate_transaction` WHERE order_id = '" . (int) $order_id . "'");

        // Delete voucher data as well
        $this->db->query("DELETE FROM `" . DB_PREFIX . "voucher` WHERE order_id = '" . (int) $order_id . "'");
        $this->db->query("DELETE FROM `" . DB_PREFIX . "voucher_history` WHERE order_id = '" . (int) $order_id . "'");
    }

    public function getOrder($order_id) {
        $order_query = $this->db->query("SELECT *, (SELECT CONCAT(c.firstname, ' ', c.lastname) FROM " . DB_PREFIX . "customer c WHERE c.customer_id = o.customer_id) AS customer, (SELECT os.name FROM " . DB_PREFIX . "order_status os WHERE os.order_status_id = o.order_status_id AND os.language_id = '" . (int) $this->config->get('config_language_id') . "') AS order_status FROM `" . DB_PREFIX . "order` o WHERE o.order_id = '" . (int) $order_id . "'");

        if ($order_query->num_rows) {
            $country_query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "country` WHERE country_id = '" . (int) $order_query->row['payment_country_id'] . "'");

            if ($country_query->num_rows) {
                $payment_iso_code_2 = $country_query->row['iso_code_2'];
                $payment_iso_code_3 = $country_query->row['iso_code_3'];
            } else {
                $payment_iso_code_2 = '';
                $payment_iso_code_3 = '';
            }

            $zone_query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "zone` WHERE zone_id = '" . (int) $order_query->row['payment_zone_id'] . "'");

            if ($zone_query->num_rows) {
                $payment_zone_code = $zone_query->row['code'];
            } else {
                $payment_zone_code = '';
            }

            $country_query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "country` WHERE country_id = '" . (int) $order_query->row['shipping_country_id'] . "'");

            if ($country_query->num_rows) {
                $shipping_iso_code_2 = $country_query->row['iso_code_2'];
                $shipping_iso_code_3 = $country_query->row['iso_code_3'];
            } else {
                $shipping_iso_code_2 = '';
                $shipping_iso_code_3 = '';
            }

            $zone_query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "zone` WHERE zone_id = '" . (int) $order_query->row['shipping_zone_id'] . "'");

            if ($zone_query->num_rows) {
                $shipping_zone_code = $zone_query->row['code'];
            } else {
                $shipping_zone_code = '';
            }

            $reward = 0;

            $order_product_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_product WHERE order_id = '" . (int) $order_id . "'");

            foreach ($order_product_query->rows as $product) {
                $reward += $product['reward'];
            }

            if ($order_query->row['affiliate_id']) {
                $affiliate_id = $order_query->row['affiliate_id'];
            } else {
                $affiliate_id = 0;
            }

            $this->load->model('marketing/affiliate');

            $affiliate_info = $this->model_marketing_affiliate->getAffiliate($affiliate_id);

            if ($affiliate_info) {
                $affiliate_firstname = $affiliate_info['firstname'];
                $affiliate_lastname = $affiliate_info['lastname'];
            } else {
                $affiliate_firstname = '';
                $affiliate_lastname = '';
            }

            $this->load->model('localisation/language');

            $language_info = $this->model_localisation_language->getLanguage($order_query->row['language_id']);

            if ($language_info) {
                $language_code = $language_info['code'];
            } else {
                $language_code = $this->config->get('config_language');
            }

            return array(
                'order_id' => $order_query->row['order_id'],

'docket_no' => $order_query->row['docket_no'],
            
                'invoice_no' => $order_query->row['invoice_no'],
                'invoice_prefix' => $order_query->row['invoice_prefix'],
                'store_id' => $order_query->row['store_id'],
                'store_name' => $order_query->row['store_name'],
                'store_url' => $order_query->row['store_url'],
                'customer_id' => $order_query->row['customer_id'],
                'customer' => $order_query->row['customer'],
                'customer_group_id' => $order_query->row['customer_group_id'],
                'firstname' => $order_query->row['firstname'],
                'lastname' => $order_query->row['lastname'],
                'email' => $order_query->row['email'],
                'telephone' => $order_query->row['telephone'],
                'fax' => $order_query->row['fax'],
                'custom_field' => json_decode($order_query->row['custom_field'], true),
                'payment_firstname' => $order_query->row['payment_firstname'],
                'payment_lastname' => $order_query->row['payment_lastname'],
                'payment_company' => $order_query->row['payment_company'],
                'payment_address_1' => $order_query->row['payment_address_1'],
                'payment_address_2' => $order_query->row['payment_address_2'],
                'payment_postcode' => $order_query->row['payment_postcode'],
                'payment_city' => $order_query->row['payment_city'],
                'payment_zone_id' => $order_query->row['payment_zone_id'],
                'payment_zone' => $order_query->row['payment_zone'],
                'payment_zone_code' => $payment_zone_code,
                'payment_country_id' => $order_query->row['payment_country_id'],
                'payment_country' => $order_query->row['payment_country'],
                'payment_iso_code_2' => $payment_iso_code_2,
                'payment_iso_code_3' => $payment_iso_code_3,
                'payment_address_format' => $order_query->row['payment_address_format'],
                'payment_custom_field' => json_decode($order_query->row['payment_custom_field'], true),
                'payment_method' => $order_query->row['payment_method'],
                'payment_code' => $order_query->row['payment_code'],
                'shipping_firstname' => $order_query->row['shipping_firstname'],
                'shipping_lastname' => $order_query->row['shipping_lastname'],
                'shipping_company' => $order_query->row['shipping_company'],
                'shipping_address_1' => $order_query->row['shipping_address_1'],
                'shipping_address_2' => $order_query->row['shipping_address_2'],
                'shipping_postcode' => $order_query->row['shipping_postcode'],
                'shipping_city' => $order_query->row['shipping_city'],
                'shipping_zone_id' => $order_query->row['shipping_zone_id'],
                'shipping_zone' => $order_query->row['shipping_zone'],
                'shipping_zone_code' => $shipping_zone_code,
                'shipping_country_id' => $order_query->row['shipping_country_id'],
                'shipping_country' => $order_query->row['shipping_country'],
                'shipping_iso_code_2' => $shipping_iso_code_2,
                'shipping_iso_code_3' => $shipping_iso_code_3,
                'shipping_address_format' => $order_query->row['shipping_address_format'],
                'shipping_custom_field' => json_decode($order_query->row['shipping_custom_field'], true),
                'shipping_method' => $order_query->row['shipping_method'],
                'shipping_code' => $order_query->row['shipping_code'],
                'comment' => $order_query->row['comment'],
                'total' => $order_query->row['total'],
                'reward' => $reward,
                'order_status_id' => $order_query->row['order_status_id'],
                'order_status' => $order_query->row['order_status'],
                'affiliate_id' => $order_query->row['affiliate_id'],
                'affiliate_firstname' => $affiliate_firstname,
                'affiliate_lastname' => $affiliate_lastname,
                'commission' => $order_query->row['commission'],
                'language_id' => $order_query->row['language_id'],
                'language_code' => $language_code,
                'currency_id' => $order_query->row['currency_id'],
                'currency_code' => $order_query->row['currency_code'],
                'currency_value' => $order_query->row['currency_value'],
                'ip' => $order_query->row['ip'],
                'forwarded_ip' => $order_query->row['forwarded_ip'],
                'user_agent' => $order_query->row['user_agent'],
                'accept_language' => $order_query->row['accept_language'],
                'date_added' => $order_query->row['date_added'],
                'date_modified' => $order_query->row['date_modified']
            );
        } else {
            return;
        }
    }

    public function getOrders($data = array()) {
        
$sql = "SELECT o.order_id,docket_no,o.order_status_id, CONCAT(o.firstname, ' ', o.lastname) AS customer, (SELECT os.name FROM " . DB_PREFIX . "order_status os WHERE os.order_status_id = o.order_status_id AND os.language_id = '" . (int) $this->config->get('config_language_id') . "') AS order_status, o.shipping_code, o.total, o.currency_code, o.currency_value, o.date_added, o.date_modified FROM `" . DB_PREFIX . "order` o";
            

        if (isset($data['filter_order_status'])) {
            $implode = array();

            $order_statuses = explode(',', $data['filter_order_status']);

            foreach ($order_statuses as $order_status_id) {
                $implode[] = "o.order_status_id = '" . (int) $order_status_id . "'";
            }

            if ($implode) {
                $sql .= " WHERE (" . implode(" OR ", $implode) . ")";
            }
        } else {
            $sql .= " WHERE o.order_status_id > '0'";
        }

        if (!empty($data['filter_order_id'])) {
            $sql .= " AND o.order_id = '" . (int) $data['filter_order_id'] . "'";
        }

        if (!empty($data['filter_customer'])) {
            $sql .= " AND CONCAT(o.firstname, ' ', o.lastname) LIKE '%" . $this->db->escape($data['filter_customer']) . "%'";
        }

        if (!empty($data['filter_date_added'])) {
            $sql .= " AND DATE(o.date_added) = DATE('" . $this->db->escape($data['filter_date_added']) . "')";
        }

        if (!empty($data['filter_date_modified'])) {
            $sql .= " AND DATE(o.date_modified) = DATE('" . $this->db->escape($data['filter_date_modified']) . "')";
        }

        if (!empty($data['filter_total'])) {
            $sql .= " AND o.total = '" . (float) $data['filter_total'] . "'";
        }

        $sort_data = array(
            'o.order_id',
            'customer',
            'order_status',
            'o.date_added',
            'o.date_modified',
            'o.total'
        );

        if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
            $sql .= " ORDER BY " . $data['sort'];
        } else {
            $sql .= " ORDER BY o.order_id";
        }

        if (isset($data['order']) && ($data['order'] == 'DESC')) {
            $sql .= " DESC";
        } else {
            $sql .= " ASC";
        }

        if (isset($data['start']) || isset($data['limit'])) {
            if ($data['start'] < 0) {
                $data['start'] = 0;
            }

            if ($data['limit'] < 1) {
                $data['limit'] = 20;
            }

            $sql .= " LIMIT " . (int) $data['start'] . "," . (int) $data['limit'];
        }

        $query = $this->db->query($sql);

        return $query->rows;
    }

    public function getOrderProducts($order_id) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_product WHERE order_id = '" . (int) $order_id . "'");

        return $query->rows;
    }

    public function getOrderOptions($order_id, $order_product_id) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_option WHERE order_id = '" . (int) $order_id . "' AND order_product_id = '" . (int) $order_product_id . "'");

        return $query->rows;
    }

    public function getOrderVouchers($order_id) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_voucher WHERE order_id = '" . (int) $order_id . "'");

        return $query->rows;
    }

    public function getOrderVoucherByVoucherId($voucher_id) {
        $query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "order_voucher` WHERE voucher_id = '" . (int) $voucher_id . "'");

        return $query->row;
    }

    public function getOrderTotals($order_id) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_total WHERE order_id = '" . (int) $order_id . "' ORDER BY sort_order");

        return $query->rows;
    }

    public function getTotalOrders($data = array()) {
        $sql = "SELECT COUNT(*) AS total FROM `" . DB_PREFIX . "order`";

        if (isset($data['filter_order_status'])) {
            $implode = array();

            $order_statuses = explode(',', $data['filter_order_status']);

            foreach ($order_statuses as $order_status_id) {
                $implode[] = "order_status_id = '" . (int) $order_status_id . "'";
            }

            if ($implode) {
                $sql .= " WHERE (" . implode(" OR ", $implode) . ")";
            }
        } else {
            $sql .= " WHERE order_status_id > '0'";
        }

        if (!empty($data['filter_order_id'])) {
            $sql .= " AND order_id = '" . (int) $data['filter_order_id'] . "'";
        }

        if (!empty($data['filter_customer'])) {
            $sql .= " AND CONCAT(firstname, ' ', lastname) LIKE '%" . $this->db->escape($data['filter_customer']) . "%'";
        }

        if (!empty($data['filter_date_added'])) {
            $sql .= " AND DATE(date_added) = DATE('" . $this->db->escape($data['filter_date_added']) . "')";
        }

        if (!empty($data['filter_date_modified'])) {
            $sql .= " AND DATE(date_modified) = DATE('" . $this->db->escape($data['filter_date_modified']) . "')";
        }

        if (!empty($data['filter_total'])) {
            $sql .= " AND total = '" . (float) $data['filter_total'] . "'";
        }

        $query = $this->db->query($sql);

        return $query->row['total'];
    }

    public function getTotalOrdersByStoreId($store_id) {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM `" . DB_PREFIX . "order` WHERE store_id = '" . (int) $store_id . "'");

        return $query->row['total'];
    }

    public function getTotalOrdersByOrderStatusId($order_status_id) {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM `" . DB_PREFIX . "order` WHERE order_status_id = '" . (int) $order_status_id . "' AND order_status_id > '0'");

        return $query->row['total'];
    }

    public function getTotalOrdersByProcessingStatus() {
        $implode = array();

        $order_statuses = $this->config->get('config_processing_status');

        foreach ($order_statuses as $order_status_id) {
            $implode[] = "order_status_id = '" . (int) $order_status_id . "'";
        }

        if ($implode) {
            $query = $this->db->query("SELECT COUNT(*) AS total FROM `" . DB_PREFIX . "order` WHERE " . implode(" OR ", $implode));

            return $query->row['total'];
        } else {
            return 0;
        }
    }

    public function getTotalOrdersByCompleteStatus() {
        $implode = array();

        $order_statuses = $this->config->get('config_complete_status');

        foreach ($order_statuses as $order_status_id) {
            $implode[] = "order_status_id = '" . (int) $order_status_id . "'";
        }

        if ($implode) {
            $query = $this->db->query("SELECT COUNT(*) AS total FROM `" . DB_PREFIX . "order` WHERE " . implode(" OR ", $implode) . "");

            return $query->row['total'];
        } else {
            return 0;
        }
    }

    public function getTotalOrdersByLanguageId($language_id) {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM `" . DB_PREFIX . "order` WHERE language_id = '" . (int) $language_id . "' AND order_status_id > '0'");

        return $query->row['total'];
    }

    public function getTotalOrdersByCurrencyId($currency_id) {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM `" . DB_PREFIX . "order` WHERE currency_id = '" . (int) $currency_id . "' AND order_status_id > '0'");

        return $query->row['total'];
    }

    public function createInvoiceNo($order_id) {
        $order_info = $this->getOrder($order_id);

        if ($order_info && !$order_info['invoice_no']) {
            $query = $this->db->query("SELECT MAX(invoice_no) AS invoice_no FROM `" . DB_PREFIX . "order` WHERE invoice_prefix = '" . $this->db->escape($order_info['invoice_prefix']) . "'");

            if ($query->row['invoice_no']) {
                $invoice_no = $query->row['invoice_no'] + 1;
            } else {
                $invoice_no = 1;
            }

            $this->db->query("UPDATE `" . DB_PREFIX . "order` SET invoice_no = '" . (int) $invoice_no . "', invoice_prefix = '" . $this->db->escape($order_info['invoice_prefix']) . "' WHERE order_id = '" . (int) $order_id . "'");

            return $order_info['invoice_prefix'] . $invoice_no;
        }
    }

    public function getOrderHistories($order_id, $start = 0, $limit = 10) {
        if ($start < 0) {
            $start = 0;
        }

        if ($limit < 1) {
            $limit = 10;
        }

        $query = $this->db->query("SELECT oh.date_added, os.name AS status, oh.comment, oh.notify FROM " . DB_PREFIX . "order_history oh LEFT JOIN " . DB_PREFIX . "order_status os ON oh.order_status_id = os.order_status_id WHERE oh.order_id = '" . (int) $order_id . "' AND os.language_id = '" . (int) $this->config->get('config_language_id') . "' ORDER BY oh.date_added ASC LIMIT " . (int) $start . "," . (int) $limit);

        return $query->rows;
    }

    public function getTotalOrderHistories($order_id) {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "order_history WHERE order_id = '" . (int) $order_id . "'");

        return $query->row['total'];
    }

    public function getTotalOrderHistoriesByOrderStatusId($order_status_id) {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "order_history WHERE order_status_id = '" . (int) $order_status_id . "'");

        return $query->row['total'];
    }

    public function getEmailsByProductsOrdered($products, $start, $end) {
        $implode = array();

        foreach ($products as $product_id) {
            $implode[] = "op.product_id = '" . (int) $product_id . "'";
        }

        $query = $this->db->query("SELECT DISTINCT email FROM `" . DB_PREFIX . "order` o LEFT JOIN " . DB_PREFIX . "order_product op ON (o.order_id = op.order_id) WHERE (" . implode(" OR ", $implode) . ") AND o.order_status_id <> '0' LIMIT " . (int) $start . "," . (int) $end);

        return $query->rows;
    }


public function pushOrder($order_id) {
        $order_info = $this->getOrder($order_id);
        $order_products = $this->getOrderProducts($order_id);
        $order_products = $order_products[0];

        $vendorName = $this->config->get('config_name');
        $vendoraddr1 = $this->config->get('config_address');
        $vendoraddr2 = '';
        $vendorMob = $this->config->get('config_telephone');
        $vendorzip = $this->config->get('config_postcode');


        if (isset($order_info)) {
            if ($order_info['payment_code'] == 'cod') {
                $mode = 'C';
                $cash = round($order_info['total']);
            } else {
                $mode = 'P';
                $cash = 0;
            }
            $total_amount = round($order_info['total']);

            $customer_name = $order_info['firstname'] . '' . $order_info['lastname'];
            $shipping_address_1 = $order_info['shipping_address_1'];
            $shipping_address_2 = $order_info['shipping_address_2'];
            $shipping_postcode = $order_info['shipping_postcode'];
            $shipping_city = $order_info['shipping_city'];
            $shipping_state = $order_info['shipping_zone'];
            $shipping_telephone = $order_info['telephone'];
            $ShippingEmailId = $order_info['email'];
            $product_code = $order_products['product_id'];
            $product_name = $order_products['name'];
            $product_quantity = $order_products['quantity'];
            $post_json = ['Customer' =>
                [
                    'CUSTCD' => $this->dotzot_customer_code,
                ],
                'DocketList' =>
                [0 => [
                        'AgentID' => '',
                        'AwbNo' => '',
                        'Breath' => '1',
                        'CPD' => date('d/m/Y', strtotime(' + 3 days')),
                        'CollectableAmount' => $cash,
                        'Consg_Number' => '',
                        'Consolidate_EW' => '',
                        'CustomerName' => $customer_name,
                        'Ewb_Number' => '',
                        'GST_REG_STATUS' => 'N',
                        'HSN_code' => '',
                        'Height' => '1',
                        'Invoice_Ref' => $order_id,
                        'IsPudo' => 'N',
                        'ItemName' => $product_name,
                        'Length' => '1',
                        'Mode' => $mode,
                        'NoOfPieces' => $product_quantity,
                        'OrderConformation' => 'Y',
                        'OrderNo' => $order_id,
                        'ProductCode' => $product_code,
                        'PudoId' => '',
                        'REASON_TRANSPORT' => '',
                        'RateCalculation' => 'N',
                        'Seller_GSTIN' => '',
                        'ShippingAdd1' => $shipping_address_1,
                        'ShippingAdd2' => $shipping_address_2,
                        'ShippingCity' => $shipping_city,
                        'ShippingEmailId' => $ShippingEmailId,
                        'ShippingMobileNo' => $shipping_telephone,
                        'ShippingState' => $shipping_state,
                        'ShippingTelephoneNo' => $shipping_telephone,
                        'ShippingZip' => $shipping_postcode,
                        'Shipping_GSTIN' => '',
                        'TotalAmount' => round($total_amount),
                        'TransDistance' => '20',
                        'TransporterID' => '',
                        'TransporterName' => '',
                        'TypeOfDelivery' => 'Home Delivery',
                        'TypeOfService' => 'Express',
                        'UOM' => 'Per KG',
                        'VendorAddress1' => $vendoraddr1,
                        'VendorAddress2' => $vendoraddr2,
                        'VendorName' => $vendorName,
                        'VendorPincode' => $vendorzip,
                        'VendorTeleNo' => $vendorMob,
                        'Weight' => '0.150',
                    ],
                ],
            ];
            $curl = curl_init();
            curl_setopt_array($curl, array(
                CURLOPT_URL => $this->dotzot_domain . "restservice/pushorderdataservice.svc/pushorderdata_pudo_gst",
                CURLOPT_RETURNTRANSFER => true,
                CURLOPT_ENCODING => "",
                CURLOPT_MAXREDIRS => 10,
                CURLOPT_TIMEOUT => 200,
                CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
                CURLOPT_CUSTOMREQUEST => "POST",
                CURLOPT_POSTFIELDS => json_encode($post_json),
                CURLOPT_HTTPHEADER => array(
                    "cache-control: no-cache",
                    "content-type: application/json",
                ),
            ));
            $response = curl_exec($curl);
            $err = curl_error($curl);
            if ($err) {
                echo "cURL Error #:" . $err;
            } else {
                $result = json_decode($response);
                $res = $result[0];
                return $res;
            }
        }
    }

    public function addDocketNo($order_id, $dock_no) {
        $this->db->query("UPDATE `" . DB_PREFIX . "order` SET docket_no='" . $this->db->escape($dock_no) . "', date_modified = NOW() WHERE order_id = '" . (int) $order_id . "'");
    }

        public function returnOrder($order_id, $check = N) {

        $order_info = $this->getOrder($order_id);
        $order_products = $this->getOrderProducts($order_id);
        $order_products = $order_products[0];

        $vendorCompany = $this->config->get('config_name');
        $vendoraddr1 = $this->config->get('config_address');
        $vendoraddr2 = '';
        $vendorMob = $this->config->get('config_telephone');
        $vendorzip = $this->config->get('config_postcode');

        if (isset($order_info)) {
            if ($order_info['payment_code'] == 'cod') {
                $mode = 'C';
                $cash = $order_info['total'];
            } else {
                $mode = 'P';
                $cash = $order_info['total'];
            }
            $total_amount = $order_info['total'];
            $customer_name = $order_info['firstname'] . '' . $order_info['lastname'];
            $shipping_address_1 = $order_info['shipping_address_1'];
            $shipping_address_2 = $order_info['shipping_address_2'];
            $shipping_postcode = $order_info['shipping_postcode'];
            $shipping_city = $order_info['shipping_city'];
            $shipping_state = $order_info['shipping_zone'];
            $shipping_telephone = $order_info['telephone'];
            $xml = '<?xml version="1.0" encoding="UTF-8"?>';
            $xml .= '<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="https://instacom.dotzot.in/">';
            $xml .= '<SOAP-ENV:Body>';
            $xml .= '<ns1:PushReverseOrderData_PUDO>';
            $xml .= '<ns1:ClientId>' . $this->dotzot_ClientId . '</ns1:ClientId>';
            $xml .= '<ns1:UserName>' . $this->dotzot_user_name . '</ns1:UserName>';
            $xml .= '<ns1:Password>' . $this->dotzot_password . '</ns1:Password>';
            $xml .= '<ns1:RequestId>' . $order_id . '</ns1:RequestId>';
            $xml .= '<ns1:ConsignorName>' . $vendorCompany . '</ns1:ConsignorName>';
            $xml .= '<ns1:ConsignorAddress1>' . $vendoraddr1  . '</ns1:ConsignorAddress1>';
            $xml .= '<ns1:ConsignorAddress2>' . $vendoraddr2 . ' ' . $shipping_city . ',' . $shipping_state . '</ns1:ConsignorAddress2>';
            $xml .= '<ns1:MobileNo>' . $vendorMob . '</ns1:MobileNo>';
            $xml .= '<ns1:Pincode>' . $vendorzip . '</ns1:Pincode>';
            $xml .= '<ns1:SkuDescription> t</ns1:SkuDescription>';
            $xml .= '<ns1:DeclaredValue>' . round($cash, 0, PHP_ROUND_HALF_UP) . '</ns1:DeclaredValue>';
            $xml .= '<ns1:AgentId>Dikra</ns1:AgentId>';
            $xml .= '<ns1:CustomerCode>' . $this->dotzot_customer_code . '</ns1:CustomerCode>';
            $xml .= '<ns1:VendorName>' . $customer_name . '</ns1:VendorName>';
            $xml .= '<ns1:VendorAddress1>' . $shipping_address_1 . '</ns1:VendorAddress1>';
            $xml .= '<ns1:VendorAddress2>' . $shipping_address_2 . '</ns1:VendorAddress2>';
            $xml .= '<ns1:VendorPincode>' . $shipping_postcode . '</ns1:VendorPincode>';
            $xml .= '<ns1:VendorTeleNo>' . $shipping_telephone . '</ns1:VendorTeleNo>';
            $xml .= '<ns1:TransportMode>Express</ns1:TransportMode>';
            $xml .= '<ns1:ItemChecked>'.$check.'</ns1:ItemChecked>';
            $xml .= '<ns1:DockNo></ns1:DockNo>';
            $xml .= '</ns1:PushReverseOrderData_PUDO>';
            $xml .= '</SOAP-ENV:Body>';
            $xml .= '</SOAP-ENV:Envelope>';
            $res = simplexml_load_string($this->call($xml));
            return $res->ORDER;
        }
    }

    public function call($xml) {
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $this->dotzot_domain . "services/InstacomCustomerServices.asmx?wsdl");
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_HTTPHEADER, array(
            "Content-type: text/xml;charset=\"utf-8\"",
            "Accept: text/xml",
            "Cache-Control: no-cache",
            "Pragma: no-cache",
            "Content-length: " . strlen($xml),
        ));
        curl_setopt($ch, CURLOPT_HTTPAUTH, 'CURLAUTH_BASIC');
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $xml);
        curl_setopt($ch, CURLOPT_VERBOSE, true);
        $response = curl_exec($ch);
        $res = $response;
        $data = new SimpleXMLElement($res);
        $sxml = $this->xmlToArray($data);
        if ($response) {
            $ressult_t = $sxml['Envelope']['soap:Body']['PushReverseOrderData_PUDOResponse']['PushReverseOrderData_PUDOResult'];
            curl_close($ch);
            return $ressult_t;
        } else {
            return FALSE;
        }
    }

    public function xmlToArray($xml, $options = array()) {
        $defaults = array(
            'namespaceSeparator' => ':', //you may want this to be something other than a colon
            'attributePrefix' => '@', //to distinguish between attributes and nodes with the same name
            'alwaysArray' => array(), //array of xml tag names which should always become arrays
            'autoArray' => true, //only create arrays for tags which appear more than once
            'textContent' => '$', //key used for the text content of elements
            'autoText' => true, //skip textContent key if node has no attributes or child nodes
            'keySearch' => false, //optional search and replace on tag and attribute names
            'keyReplace' => false       //replace values for above search values (as passed to str_replace())
        );
        $options = array_merge($defaults, $options);
        $namespaces = $xml->getDocNamespaces();
        $namespaces[''] = null; //add base (empty) namespace
        //get attributes from all namespaces
        $attributesArray = array();
        foreach ($namespaces as $prefix => $namespace) {
            foreach ($xml->attributes($namespace) as $attributeName => $attribute) {
                //replace characters in attribute name
                if ($options['keySearch'])
                    $attributeName = str_replace($options['keySearch'], $options['keyReplace'], $attributeName);
                $attributeKey = $options['attributePrefix']
                        . ($prefix ? $prefix . $options['namespaceSeparator'] : '')
                        . $attributeName;
                $attributesArray[$attributeKey] = (string) $attribute;
            }
        }

        //get child nodes from all namespaces
        $tagsArray = array();
        foreach ($namespaces as $prefix => $namespace) {
            foreach ($xml->children($namespace) as $childXml) {
                //recurse into child nodes
                $childArray = $this->xmlToArray($childXml, $options);
                list($childTagName, $childProperties) = each($childArray);

                //replace characters in tag name
                if ($options['keySearch'])
                    $childTagName = str_replace($options['keySearch'], $options['keyReplace'], $childTagName);
                //add namespace prefix, if any
                if ($prefix)
                    $childTagName = $prefix . $options['namespaceSeparator'] . $childTagName;

                if (!isset($tagsArray[$childTagName])) {
                    //only entry with this key
                    //test if tags of this type should always be arrays, no matter the element count
                    $tagsArray[$childTagName] = in_array($childTagName, $options['alwaysArray']) || !$options['autoArray'] ? array($childProperties) : $childProperties;
                } elseif (
                        is_array($tagsArray[$childTagName]) && array_keys($tagsArray[$childTagName]) === range(0, count($tagsArray[$childTagName]) - 1)
                ) {
                    //key already exists and is integer indexed array
                    $tagsArray[$childTagName][] = $childProperties;
                } else {
                    //key exists so convert to integer indexed array with previous value in position 0
                    $tagsArray[$childTagName] = array($tagsArray[$childTagName], $childProperties);
                }
            }
        }

        //get text content of node
        $textContentArray = array();
        $plainText = trim((string) $xml);
        if ($plainText !== '')
            $textContentArray[$options['textContent']] = $plainText;

        //stick it all together
        $propertiesArray = !$options['autoText'] || $attributesArray || $tagsArray || ($plainText === '') ? array_merge($attributesArray, $tagsArray, $textContentArray) : $plainText;

        //return node as array
        return array(
            $xml->getName() => $propertiesArray
        );
    }

    public function cancelOrder($DockNo) {
        $curl = curl_init();
        curl_setopt_array($curl, array(
            CURLOPT_URL => $this->dotzot_domain . "RestService/PreventOrderDataService.svc/PreventOrderData",
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_ENCODING => "",
            CURLOPT_MAXREDIRS => 10,
            CURLOPT_TIMEOUT => 30,
            CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
            CURLOPT_CUSTOMREQUEST => "POST",
            CURLOPT_POSTFIELDS => "<PreventDocketMain xmlns=\"http://schemas.datacontract.org/2004/07/WebX.Entity\">\n<ClientId>".$this->dotzot_ClientId."</ClientId>\n<PassWord>".$this->dotzot_password."</PassWord>\n<PreventDocketList>\n<PreventDocket>\n<AddRemove>Add</AddRemove>\n<DockNo>" . trim($DockNo) . "</DockNo>\n</PreventDocket>\n</PreventDocketList>\n<Type>P</Type>\n<UserId>".$this->dotzot_user_name."</UserId>\n</PreventDocketMain>",
            CURLOPT_HTTPHEADER => array(
                "cache-control: no-cache",
                "content-type: application/xml",
            ),
        ));
        $response = curl_exec($curl);
        $err = curl_error($curl);
        curl_close($curl);
        $res = (string) $response;


        $sxml = simplexml_load_string($res);
        //echo $res;die;
//        $result = json_encode($sxml);

        return $sxml;
    }

    public function trackOrder($DockNo) {
        $curl = curl_init();

        curl_setopt_array($curl, array(
            CURLOPT_URL => $this->dotzot_domain . "RestService/DocketTrackingService.svc/GetDocketTrackingDetails",
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_ENCODING => "",
            CURLOPT_MAXREDIRS => 10,
            CURLOPT_TIMEOUT => 30,
            CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
            CURLOPT_CUSTOMREQUEST => "POST",
            CURLOPT_POSTFIELDS => "{\"DocketNo\":\"$DockNo\"}",
            CURLOPT_HTTPHEADER => array(
                "cache-control: no-cache",
                "content-type: application/json",
            ),
        ));

        $response = curl_exec($curl);
        $err = curl_error($curl);

        curl_close($curl);
        $res = json_decode($response);
        return $res[0];
    }

            
    public function getTotalEmailsByProductsOrdered($products) {
        $implode = array();

        foreach ($products as $product_id) {
            $implode[] = "op.product_id = '" . (int) $product_id . "'";
        }

        $query = $this->db->query("SELECT DISTINCT email FROM `" . DB_PREFIX . "order` o LEFT JOIN " . DB_PREFIX . "order_product op ON (o.order_id = op.order_id) WHERE (" . implode(" OR ", $implode) . ") AND o.order_status_id <> '0'");

        return $query->row['email'];
    }

}
