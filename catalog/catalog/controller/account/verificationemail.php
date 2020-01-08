<?php

class ControllerAccountVerificationEmail extends Controller {

    public function index() {
        if ($this->customer->isLogged()) {
            $this->response->redirect($this->url->link('account/logout', '', 'SSL'));
            die();
        }
        if (strlen($this->request->get['v']) != 32 ||
                intval($this->request->get['u']) <= 0) {
            header('Location: ' . HTTP_SERVER);
            die();
        }

        $customer_id = $this->request->get['u'];
        $verification_code = $this->request->get['v'];

        $customer = $this->db->query("SELECT verification_code FROM " . DB_PREFIX . "customer_verification WHERE customer_id='" . $customer_id . "'");

        if ($customer->row['verification_code'] != $verification_code) {
            header('Location: ' . HTTP_SERVER);
            die();
        }

        $this->db->query("UPDATE " . DB_PREFIX . "customer SET approved = '1'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "customer_verification WHERE customer_id='" . $customer_id . "'");

        $this->load->language('account/verificationemail');

        $this->document->setTitle($this->language->get('heading_title'));
        $data['breadcrumbs'] = array();
        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/home'),
            'separator' => false
        );
        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_account'),
            'href' => $this->url->link('account/account', '', 'SSL'),
            'separator' => $this->language->get('text_separator')
        );

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_verification'),
            'href' => $this->url->link('account/verificationemail', '', 'SSL'),
            'separator' => $this->language->get('text_separator')
        );

        $data['heading_title'] = $this->language->get('heading_title');

        $data['text_account_verificaiton'] = $this->language->get('text_account_verificaiton');
        $data['text_account_verified'] = $this->language->get('text_account_verified');

        $data['login'] = $this->url->link('account/login', '', 'SSL');



        $data['column_left'] = $this->load->controller('common/column_left');
        $data['column_right'] = $this->load->controller('common/column_right');
        $data['content_top'] = $this->load->controller('common/content_top');
        $data['content_bottom'] = $this->load->controller('common/content_bottom');
        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');

        $this->response->setOutput($this->load->view('account/verificationemail', $data));
    }

}

?>
