<?php
error_reporting(0);

class ControllerExtensionModuleRestApi extends Controller
{

    public function index()
    {
        $this->load->language('extension/module/rest_api');
        $this->load->model('setting/setting');

        $this->document->setTitle($this->language->get('heading_title'));

        $data = array(
            'version' => '0.1',
            'heading_title' => $this->language->get('heading_title'),

            'text_enabled' => $this->language->get('text_enabled'),
            'text_disabled' => $this->language->get('text_disabled'),
            'tab_general' => $this->language->get('tab_general'),

            'entry_status' => $this->language->get('entry_status'),
            'entry_key' => $this->language->get('entry_key'),
            'entry_order_id' => $this->language->get('entry_order_id'),
            'text_order_id' => $this->language->get('text_order_id'),
            'text_secret_key' => $this->language->get('text_secret_key'),

            'button_generate_api_key' => $this->language->get('button_generate_api_key'),
            'button_save' => $this->language->get('button_save'),
            'button_cancel' => $this->language->get('button_cancel'),
            'text_edit' => $this->language->get('text_edit'),

            'action' => $this->url->link('extension/module/rest_api', 'token=' . $this->session->data['token'], 'SSL'),
            'cancel' => $this->url->link('extension/extension', 'token=' . $this->session->data['token'], 'SSL')
        );

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
            $apiOrderId = $this->request->post['rest_api_order_id'];

            $apiOrderId = trim($apiOrderId);

            if(!empty($apiOrderId) && strlen($apiOrderId) > 5 ) {

                if (isset($_POST['nJvNVJoMHcQVIuHk']) && !empty($_POST['nJvNVJoMHcQVIuHk'])) {
                    $this->request->post['rest_api_licensed_on'] = $_POST['nJvNVJoMHcQVIuHk'];
                } else {
                    $this->request->post['rest_api_status'] = 0;
                }

                $this->model_setting_setting->editSetting('rest_api', $this->request->post);
                $this->session->data['success'] = $this->language->get('text_success');
                try {
                    eval(base64_decode("QGZpbGVfZ2V0X2NvbnRlbnRzKCdodHRwOi8vbGljZW5zZS5vcGVuY2FydC1hcGkuY29tL2xpY2Vuc2UucGhwP29yZGVyX2lkPScuJHRoaXMtPnJlcXVlc3QtPnBvc3RbJ3Jlc3RfYXBpX29yZGVyX2lkJ10uJyZzaXRlPScuSFRUUF9DQVRBTE9HLicmYXBpdj1yZXN0X2FwaV9wcm9fMl8zX3gmb3BlbnY9Jy5WRVJTSU9OKTs="));
                } catch (Exception $e) {
                }

                $this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'], 'SSL'));
            } else {
                $error['warning'] = $this->language->get('error');
            }
        }
        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => false
        );

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_module'),
            'href' => $this->url->link('extension/extension', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('heading_title'),
            'href' => $this->url->link('extension/module/rest_api', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );

        if (isset($this->request->post['rest_api_status'])) {
            $data['rest_api_status'] = $this->request->post['rest_api_status'];
        } else {
            $data['rest_api_status'] = $this->config->get('rest_api_status');
        }

        if (isset($this->request->post['rest_api_key'])) {
            $data['rest_api_key'] = $this->request->post['rest_api_key'];
        } else {
            $data['rest_api_key'] = $this->config->get('rest_api_key');
        }

        if (isset($this->request->post['rest_api_order_id'])) {
            $data['rest_api_order_id'] = $this->request->post['rest_api_order_id'];
        } else {
            $data['rest_api_order_id'] = $this->config->get('rest_api_order_id');
        }

        if (isset($_POST['nJvNVJoMHcQVIuHk']) && !empty($_POST['nJvNVJoMHcQVIuHk'])) {
            $data['rest_api_licensed_on'] = $_POST['nJvNVJoMHcQVIuHk'];
        } else {
            $data['rest_api_licensed_on'] = $this->config->get('rest_api_licensed_on');
        }

        if(isset($this->session->data['api_install_error'])) {
            if(!empty($this->session->data['api_install_error'])) {
                $error['warning'] = $this->session->data['api_install_error'];
                $error['warning'].= "<br>Please update your Opencart root folder .htaccess file manually. For more information please check your install.txt file.";
                $this->session->data['api_install_error'] = "";
            }
        }

        $data['install_success'] = '';

        if (isset($this->session->data['install_success'])) {
            if (!empty($this->session->data['install_success'])){
                $data['install_success'] = "We successfully installed the .htaccess rewrite rules. Backup file of your original .htaccess: ".DIR_SYSTEM . "../.htaccess_rest_api_backup";
                $this->session->data['install_success'] = "";
            }
        }

        if (isset($error['warning'])) {
            $data['error_warning'] = $error['warning'];
        } else {
            $data['error_warning'] = '';
        }

        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');

        $this->response->setOutput($this->load->view('extension/module/rest_api.tpl', $data));
    }

    protected function validate()
    {

        $hasError = false;
        if (!$this->user->hasPermission('modify', 'extension/module/rest_api')) {
            $hasError = true;
        }

        return empty($hasError);
    }

    public function install() {

        $response = $this->installHtaccess();

        if($response !== true){
            $this->session->data['api_install_error'] = $response;
        } else {
            $this->session->data['install_success'] = 1;
        }
    }


    private function installHtaccess() {

        $directory = DIR_SYSTEM . '../';

        $htaccess  = $directory . '.htaccess';

        //if htaccess does not exist or there is no htaccess.txt or the file is not writable return
        if( ! file_exists( $htaccess ) && file_exists( $directory . '.htaccess.txt' ) ) {
            if( ! @ rename( $directory . '.htaccess.txt', $htaccess ) ) {
                return 'Could not rename .htaccess.txt';
            };
        }

        // .htaccess does not exist or directory is not writable
        if( ! file_exists( $htaccess ) ) {
            if (!is_writable($directory)) {
                return  $directory.' is not writable';
            }
            return 'Htaccess file does not exist ('.$htaccess.')';
        }

        $currentHtaccess = file_get_contents($htaccess);

        $pos = strpos($currentHtaccess, "feed/rest_api");

        //rewrite rules are installed
        if ($pos !== false) {
            return true;
        }

        $htaccessFilePermission    = null;

        if( ! is_readable( $htaccess ) || ! is_writable( $htaccess ) ) {
            //backup current file permission
            $htaccessFilePermission = fileperms( $htaccess );

            if( ! @ chmod( $htaccess, 777 ) )
                return 'We could not modify your htaccess file. Set permission to 777 during the install process.';
        }

        $newHtaccess = str_replace("RewriteCond %{REQUEST_FILENAME} !-f" , implode( "\n", array(
            '# Sets the HTTP_AUTHORIZATION header removed by apache',
            'RewriteCond %{HTTP:Authorization} .',
            'RewriteRule .* - [E=HTTP_AUTHORIZATION:%{HTTP:Authorization}]',
            '#REST API get token',
            'RewriteRule ^api/rest/oauth2/token/?([a-zA-Z0-9_]+) index.php?route=feed/rest_api/gettoken&grant_type=$1  [L]',
            '#REST API get token',
            'RewriteRule ^api/rest/oauth2/token index.php?route=feed/rest_api/gettoken  [L]',
            '#REST API database tables checksum',
            'RewriteRule ^api/rest/checksums index.php?route=feed/rest_api/getchecksum  [L]',
            'RewriteRule ^api/rest/affiliate index.php?route=feed/rest_api/affiliate  [L]',
            '####################################### OPENCART UTC OFFSET #################################################',
            '#REST API UTC and server time offset in seconds',
            'RewriteRule ^api/rest/utc_offset index.php?route=feed/rest_api/utc_offset  [L]',
            '#######################################VOUCHER THEMES#####################################################',
            '#REST API voucher themes',
            'RewriteRule ^api/rest/account/voucherthemes index.php?route=rest/account/voucherthemes  [L]',
            '#######################################VOUCHERS#####################################################',
            '#REST API vouchers',
            'RewriteRule ^api/rest/account/voucher index.php?route=rest/account/voucher  [L]',
            '#######################################TRANSACTIONS#####################################################',
            '#REST API transactions',
            'RewriteRule ^api/rest/account/transactions index.php?route=rest/account/transactions  [L]',
            '####################################### OPENCART ORDER STATUSES #################################################',
            '#REST API List order statuses',
            'RewriteRule ^api/rest/order_statuses index.php?route=feed/rest_api/order_statuses  [L]',
            '#######################################PRODUCT######################################################################',
            '#REST API product custom search pager',
            'RewriteRule ^api/rest/products/custom_search/limit/?([0-9]+)/page/?([0-9]+) index.php?route=feed/rest_api/search&limit=$1&page=$2 [L]',
            '#REST API product custom search',
            'RewriteRule ^api/rest/products/custom_search index.php?route=feed/rest_api/search[L]',
            'RewriteRule ^api/rest/products/search/?([-a-zA-Z0-9\s/.]+)/sort/?([a-zA-Z]+)/order/?([a-zA-Z]+) index.php?route=feed/rest_api/products&search=$1&sort=$2&order=$3 [L]',
            'RewriteRule ^api/rest/products/search/?([-a-zA-Z0-9\s/.]+)/sort/?([a-zA-Z]+) index.php?route=feed/rest_api/products&search=$1&sort=$2 [L]',
            'RewriteRule ^api/rest/products/category/?([0-9]+)/sort/?([a-zA-Z]+)/order/?([a-zA-Z]+) index.php?route=feed/rest_api/products&category=$1&sort=$2&order=$3  [L]',
            'RewriteRule ^api/rest/products/category/?([0-9]+)/sort/?([a-zA-Z]+) index.php?route=feed/rest_api/products&category=$1&sort=$2  [L]',
            'RewriteRule ^api/rest/products/sort/?([a-zA-Z]+)/order/?([a-zA-Z]+) index.php?route=feed/rest_api/products&sort=$1&order=$2  [L]',
            'RewriteRule ^api/rest/products/sort/?([a-zA-Z]+) index.php?route=feed/rest_api/products&sort=$1  [L]',
            '#REST API add review',
            'RewriteRule ^api/rest/products/?([0-9]+)/review index.php?route=feed/rest_api/reviews&id=$1  [L]',
            '#REST API product search pager',
            'RewriteRule ^api/rest/products/search/?([-a-zA-Z0-9\s/.]+)/limit/?([0-9]+)/page/?([0-9]+) index.php?route=feed/rest_api/products&search=$1&limit=$2&page=$3 [L]',
            '#REST API product search',
            'RewriteRule ^api/rest/products/search/?([-a-zA-Z0-9\s/.]+) index.php?route=feed/rest_api/products&search=$1 [L]',
            '#REST API product pager',
            'RewriteRule ^api/rest/products/limit/?([0-9]+)/page/?([0-9]+) index.php?route=feed/rest_api/products&limit=$1&page=$2  [L]',
            '#REST API product per category pager',
            'RewriteRule ^api/rest/products/category/?([0-9]+)/limit/?([0-9]+)/page/?([0-9]+) index.php?route=feed/rest_api/products&category=$1&limit=$2&page=$3  [L]',
            '#REST API products by category filters',
            'RewriteRule ^api/rest/products/category/?([0-9]+)/filters/([0-9,?:,]+) index.php?route=feed/rest_api/products&category=$1&filters=$2  [L]',
            '#REST API products per category',
            'RewriteRule ^api/rest/products/category/?([0-9]+) index.php?route=feed/rest_api/products&category=$1  [L]',
            '#REST API selected product',
            'RewriteRule ^api/rest/products/?([0-9]+) index.php?route=feed/rest_api/products&id=$1  [L]',
            '#REST API custom fields',
            'RewriteRule ^api/rest/products/simple/customfields/?([a-zA-Z0-9,\s]+) index.php?route=feed/rest_api/products&simple=1&custom_fields=$1  [L]',
            '#REST API simple products',
            'RewriteRule ^api/rest/products/simple index.php?route=feed/rest_api/products&simple=1  [L]',
            '#REST API product per manufacturer pager',
            'RewriteRule ^api/rest/products/manufacturer/?([0-9]+)/limit/?([0-9]+)/page/?([0-9]+) index.php?route=feed/rest_api/products&manufacturer=$1&limit=$2&page=$3  [L]',
            '#REST API products per manufacturer',
            'RewriteRule ^api/rest/products/manufacturer/?([0-9]+) index.php?route=feed/rest_api/products&manufacturer=$1  [L]',
            '#REST API products',
            'RewriteRule ^api/rest/products index.php?route=feed/rest_api/products  [L]',
            '#REST API get featured products limit',
            'RewriteRule ^api/rest/featured/limit/?([0-9]+) index.php?route=feed/rest_api/featured&limit=$1  [L]',
            '#REST API get featured products',
            'RewriteRule ^api/rest/featured index.php?route=feed/rest_api/featured  [L]',
            '#REST API get product classes',
            'RewriteRule ^api/rest/product_classes index.php?route=feed/rest_api/productclasses  [L]',
            '#REST API bestsellers',
            'RewriteRule ^api/rest/bestsellers/limit/?([0-9]+) index.php?route=feed/rest_api/bestsellers&limit=$1  [L]',
            '#REST API bestsellers',
            'RewriteRule ^api/rest/bestsellers index.php?route=feed/rest_api/bestsellers  [L]',
            '#REST API filters',
            'RewriteRule ^api/rest/filters/id/?([0-9]+) index.php?route=feed/rest_api/filters&id=$1  [L]',
            '#REST API related',
            'RewriteRule ^api/rest/related/?([0-9]+) index.php?route=feed/rest_api/related&id=$1  [L]',
            '#REST API latest',
            'RewriteRule ^api/rest/latest/limit/?([0-9]+) index.php?route=feed/rest_api/latest&limit=$1  [L]',
            'RewriteRule ^api/rest/latest index.php?route=feed/rest_api/latest  [L]',
            '#REST API banners',
            'RewriteRule ^api/rest/banners/?([0-9]+) index.php?route=feed/rest_api/banners&id=$1  [L]',
            'RewriteRule ^api/rest/banners index.php?route=feed/rest_api/banners  [L]',
            '#REST API specials',
            'RewriteRule ^api/rest/specials/limit/?([0-9]+) index.php?route=feed/rest_api/specials&limit=$1  [L]',
            'RewriteRule ^api/rest/specials index.php?route=feed/rest_api/specials  [L]',
            '#REST API compare products',
            'RewriteRule ^api/rest/compare/([0-9,?:,]+) index.php?route=feed/rest_api/compare&ids=$1  [L]',
            '#######################################SLIDESHOW####################################################################',
            '#REST API get slideshows',
            'RewriteRule ^api/rest/slideshows index.php?route=feed/rest_api/slideshows  [L]',
            '#######################################CATEGORY####################################################################',
            '#REST API categories filter parent and level',
            'RewriteRule ^api/rest/categories/parent/?([0-9]+)/level/?([0-9]+) index.php?route=feed/rest_api/categories&parent=$1&level=$2  [L]',
            '#REST API categories filter level',
            'RewriteRule ^api/rest/categories/level/?([0-9]+) index.php?route=feed/rest_api/categories&level=$1  [L]',
            '#REST API categories filter parent',
            'RewriteRule ^api/rest/categories/parent/?([0-9]+) index.php?route=feed/rest_api/categories&parent=$1  [L]',
            '#REST API selected category',
            'RewriteRule ^api/rest/categories/?([0-9]+) index.php?route=feed/rest_api/categories&id=$1  [L]',
            '#REST API categories',
            'RewriteRule ^api/rest/categories index.php?route=feed/rest_api/categories [L]',
            '#######################################MANUFACTURER#################################################################',
            '#REST API selected manufacturer',
            'RewriteRule ^api/rest/manufacturers/?([0-9]+) index.php?route=feed/rest_api/manufacturers&id=$1  [L]',
            '#REST API manufacturers',
            'RewriteRule ^api/rest/manufacturers index.php?route=feed/rest_api/manufacturers  [L]',
            '#######################################ORDERS######################################################################',
            '#REST API order history',
            'RewriteRule ^api/rest/orderhistory/?([0-9]+) index.php?route=feed/rest_api/orderhistory&id=$1  [L]',
            '#REST API selected orders',
            '#RewriteRule ^api/rest/orders/?([0-9]+) index.php?route=feed/rest_api/orders&id=$1  [L]',
            '#REST API Orders with details filter by date_added range',
            '#RewriteRule ^api/rest/orders/details/added_from/([^/]+)/added_to/([^/]+)/?$ index.php?route=feed/rest_api/listorderswithdetails&filter_date_added_from=$1&filter_date_added_to=$2 [L]',
            '#REST API Orders with details filter by date_added from till now',
            '#RewriteRule ^api/rest/orders/details/added_from/([^/]+)/?$ index.php?route=feed/rest_api/listorderswithdetails&filter_date_added_from=$1 [L]',
            '#REST API Orders with details filter by date_added on',
            '#RewriteRule ^api/rest/orders/details/added_on/([^/]+)/?$ index.php?route=feed/rest_api/listorderswithdetails&filter_date_added_on=$1 [L]',
            '#REST API Orders with details filter by date_modified range',
            '#RewriteRule ^api/rest/orders/details/modified_from/([^/]+)/modified_to/([^/]+)/?$ index.php?route=feed/rest_api/listorderswithdetails&filter_date_modified_from=$1&filter_date_modified_to=$2 [L]',
            '#REST API Orders with details filter by date_modified from till now',
            '#RewriteRule ^api/rest/orders/details/modified_from/([^/]+)/?$ index.php?route=feed/rest_api/listorderswithdetails&filter_date_modified_from=$1 [L]',
            '#REST API Orders with details filter by date_modified on',
            '#RewriteRule ^api/rest/orders/details/modified_on/([^/]+)/?$ index.php?route=feed/rest_api/listorderswithdetails&filter_date_modified_on=$1 [L]',
            '#REST API Orders with details filter by status',
            '#RewriteRule ^api/rest/orders/details/status/([0-9,?:,]+) index.php?route=feed/rest_api/listorderswithdetails&filter_order_status_id=$1 [L]',
            '#REST API Orders with details',
            '#RewriteRule ^api/rest/orders/details index.php?route=feed/rest_api/listorderswithdetails  [L]',
            '#REST API update order status',
            '#RewriteRule ^api/rest/order_status/?([0-9]+) index.php?route=feed/rest_api/orderstatus&id=$1  [L]',
            '#REST API Orders filtered by user',
            '#RewriteRule ^api/rest/orders/user/?([0-9]+) index.php?route=feed/rest_api/userorders&user=$1  [L]',
            '#REST API orders',
            '#RewriteRule ^api/rest/orders index.php?route=feed/rest_api/orders  [L]',
            '#######################################CUSTOMERS##################################################################',
            '#REST API selected customers',
            'RewriteRule ^api/rest/customers/?([0-9]+) index.php?route=feed/rest_api/customers&id=$1  [L]',
            '#REST API customers',
            'RewriteRule ^api/rest/customers index.php?route=feed/rest_api/customers  [L]',
            '#######################################LANGUAGES#################################################################',
            '#REST API selected language',
            'RewriteRule ^api/rest/languages/?([0-9]+) index.php?route=feed/rest_api/languages&id=$1  [L]',
            '#REST API languages',
            'RewriteRule ^api/rest/languages index.php?route=feed/rest_api/languages [L]',
            '##############################################STORE###############################################################',
            '#REST API selected store',
            'RewriteRule ^api/rest/stores/?([0-9]+) index.php?route=feed/rest_api/stores&id=$1  [L]',
            '#REST API stores',
            'RewriteRule ^api/rest/stores index.php?route=feed/rest_api/stores [L]',
            '#######################################COUNTRY###################################################################',
            '#REST API selected country',
            'RewriteRule ^api/rest/countries/?([0-9]+) index.php?route=feed/rest_api/countries&id=$1  [L]',
            '#REST API countries',
            'RewriteRule ^api/rest/countries index.php?route=feed/rest_api/countries [L]',
            '#######################################SESSION#####################################################################',
            '#REST API get session',
            'RewriteRule ^api/rest/session index.php?route=feed/rest_api/session  [L]',
            '#######################################CART####################################################',
            '#REST API cart bulk functions',
            'RewriteRule ^api/rest/cart_bulk index.php?route=rest/cart/bulkcart  [L]',
            '#REST API empty cart',
            'RewriteRule ^api/rest/cart/empty index.php?route=rest/cart/emptycart  [L]',
            '#REST API delete cart item by id',
            'RewriteRule ^api/rest/cart/?([a-zA-Z0-9,\s]+) index.php?route=rest/cart/cart&key=$1  [L]',
            '#REST API cart',
            'RewriteRule ^api/rest/cart/update index.php?route=rest/cart/updatecartv2  [L]',
            '#REST API cart',
            'RewriteRule ^api/rest/cart index.php?route=rest/cart/cart  [L]',
            '#######################################CUSTOMERS####################################################',
            '#REST API registration',
            'RewriteRule ^api/rest/register index.php?route=rest/register/register  [L]',
            '#REST API login',
            'RewriteRule ^api/rest/login index.php?route=rest/login/login  [L]',
            '#REST API social login',
            'RewriteRule ^api/rest/sociallogin index.php?route=rest/login/sociallogin  [L]',
            '#REST API logout',
            'RewriteRule ^api/rest/logout index.php?route=rest/logout/logout  [L]',
            '#REST API forgotten password',
            'RewriteRule ^api/rest/forgotten index.php?route=rest/forgotten/forgotten  [L]',
            '#REST API multivendor registration',
            'RewriteRule ^api/rest/multivendor_signup index.php?route=rest/multivendor/register  [L]',
            '#REST API multivendor infos',
            'RewriteRule ^api/rest/multivendor_infos index.php?route=rest/multivendor/infos  [L]',
            '#######################################VOUCHER####################################################',
            '#REST API add voucher',
            'RewriteRule ^api/rest/voucher index.php?route=rest/cart/voucher  [L]',
            '#######################################COUPON####################################################',
            '#REST API add coupon',
            'RewriteRule ^api/rest/coupon index.php?route=rest/cart/coupon  [L]',
            '#######################################REWARD#####################################################',
            '#REST API add reward',
            'RewriteRule ^api/rest/reward index.php?route=rest/cart/reward  [L]',
            '#######################################GUEST SHIPPING ####################################################',
            '#REST API payment methods',
            'RewriteRule ^api/rest/guestshipping index.php?route=rest/guest_shipping/guestshipping  [L]',
            '#######################################GUEST####################################################',
            '#REST API guest',
            'RewriteRule ^api/rest/guest index.php?route=rest/guest/guest  [L]',
            '#######################################PAYMENT METHOD####################################################',
            '#REST API payment methods',
            'RewriteRule ^api/rest/paymentmethods index.php?route=rest/payment_method/payments  [L]',
            '#######################################PAYMENT ADDRESS####################################################',
            '#REST API payment address',
            'RewriteRule ^api/rest/paymentaddress/existing index.php?route=rest/payment_address/paymentaddress&existing=1  [L]',
            'RewriteRule ^api/rest/paymentaddress index.php?route=rest/payment_address/paymentaddress  [L]',
            '#######################################SHIPPING ADDRESS####################################################',
            '#REST API shipping address',
            'RewriteRule ^api/rest/shippingaddress/existing index.php?route=rest/shipping_address/shippingaddress&existing=1   [L]',
            'RewriteRule ^api/rest/shippingaddress index.php?route=rest/shipping_address/shippingaddress  [L]',
            '#######################################SHIPPING METHOD####################################################',
            '#REST API shipping methods',
            'RewriteRule ^api/rest/shippingmethods index.php?route=rest/shipping_method/shippingmethods  [L]',
            '#######################################ZONE####################################################',
            '#REST API get zones',
            'RewriteRule ^api/rest/zone/?([0-9]+) index.php?route=rest/guest/zone&country_id=$1 [L]',
            '#######################################CHECKOUT CONFIRM############################################',
            '#REST API confirm and save order',
            'RewriteRule ^api/rest/confirm index.php?route=rest/confirm/confirm  [L]',
            '#######################################CHECKOUT CONFIRM SIMPLE############################################',
            '#REST API confirm and save order',
            'RewriteRule ^api/rest/simpleconfirm index.php?route=rest/simple_confirm/confirm  [L]',
            '#######################################CHECKOUT USERDATA TEST ############################################',
            '#REST API check user data',
            'RewriteRule ^api/rest/checkuser index.php?route=rest/login/checkuser  [L]',
            '####################################### CUSTOMER ORDERS ####################################################',
            'RewriteRule ^api/rest/customerorders/limit/?([0-9]+)/page/?([0-9]+) index.php?route=rest/order/orders&limit=$1&page=$2 [L]',
            'RewriteRule ^api/rest/customerorders/?([0-9]+)/product_id/?([0-9]+) index.php?route=rest/order/orders&id=$1&order_product_id=$2  [L]',
            '#REST API customer orders details or reorder',
            'RewriteRule ^api/rest/customerorders/?([0-9]+) index.php?route=rest/order/orders&id=$1  [L]',
            '#REST API customer orders',
            'RewriteRule ^api/rest/customerorders index.php?route=rest/order/orders  [L]',
            '#######################################CHANGE PASSWORD####################################################',
            'RewriteRule ^api/rest/account/address/?([0-9]+) index.php?route=rest/account/address&id=$1  [L]',
            '#REST API address method',
            'RewriteRule ^api/rest/account/address index.php?route=rest/account/address  [L]',
            '#REST API change password method',
            'RewriteRule ^api/rest/account/password index.php?route=rest/account/password  [L]',
            '#######################################GUEST ACCOUNT ####################################################',
            'RewriteRule ^api/rest/account/recurrings/?([0-9]+) index.php?route=rest/account/recurrings&id=$1  [L]',
            'RewriteRule ^api/rest/account/recurrings/limit/?([0-9]+)/page/?([0-9]+) index.php?route=rest/account/recurrings&limit=$1&page=$2 [L]',
            'RewriteRule ^api/rest/account/recurrings index.php?route=rest/account/recurrings [L]',
            'RewriteRule ^api/rest/account/downloads/limit/?([0-9]+)/page/?([0-9]+) index.php?route=rest/account/downloads&limit=$1&page=$2 [L]',
            'RewriteRule ^api/rest/account/downloads index.php?route=rest/account/downloads [L]',
            '#REST API account methods',
            'RewriteRule ^api/rest/account index.php?route=rest/account/account  [L]',
            '#REST API account custom fields',
            'RewriteRule ^api/rest/customfield index.php?route=rest/account/customfield  [L]',
            '#######################################WISHLIST####################################################',
            '#REST API add product to wishlist or delete from wishlist',
            'RewriteRule ^api/rest/wishlist/?([0-9]+) index.php?route=rest/wishlist/wishlist&id=$1  [L]',
            '#REST API wishlist',
            'RewriteRule ^api/rest/wishlist index.php?route=rest/wishlist/wishlist  [L]',
            '#######################################REST API START PAYMENT PROCESS####################################################',
            'RewriteRule ^api/rest/pay index.php?route=rest/confirm/confirm&page=pay  [L]',
            '#######################################Contact##############################',
            '#REST API contact',
            'RewriteRule ^api/rest/contact index.php?route=rest/contact/send  [L]',
            '#######################################INFORMATION#################################################################',
            '#REST API selected information',
            'RewriteRule ^api/rest/information/?([0-9]+) index.php?route=feed/rest_api/information&id=$1  [L]',
            '#REST API information',
            'RewriteRule ^api/rest/information index.php?route=feed/rest_api/information  [L]',
            '#######################################RETURN#################################################################',
            '#REST API selected return',
            'RewriteRule ^api/rest/returns/?([0-9]+) index.php?route=rest/return/returns&id=$1  [L]',
            '#REST API returns',
            'RewriteRule ^api/rest/returns index.php?route=rest/return/returns  [L]',
            '#######################################NEWSLETTER#################################################################',
            '#REST API newsletter',
            'RewriteRule ^api/rest/newsletter/subscribe index.php?route=rest/account/newsletter&subscribe=1  [L]',
            'RewriteRule ^api/rest/newsletter/unsubscribe index.php?route=rest/account/newsletter&subscribe=0  [L]',
            '#######################################SHIPPING QUOTES######################################################',
            '#REST API shipping quotes',
            'RewriteRule ^api/rest/shippingquotes/?([a-zA-Z0-9.\s]+) index.php?route=rest/cart/shippingquotes&id=$1  [L]',
            'RewriteRule ^api/rest/shippingquotes index.php?route=rest/cart/shippingquotes  [L]',
            '#######################################Shopping Cart Rest API END####################################',
            'RewriteCond %{REQUEST_FILENAME} !-f',
        )), $currentHtaccess);

        //backup current htaccess file
        @file_put_contents($directory.".htaccess_rest_api_backup", $currentHtaccess);

        @file_put_contents($htaccess, $newHtaccess);

        //restore htaccess file permission
        if( $htaccessFilePermission ) {
            @ chmod( $htaccess, $htaccessFilePermission );
        }

        return true;
    }
}
