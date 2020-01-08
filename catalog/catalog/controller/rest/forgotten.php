<?php

/**
 * forgotten.php
 *
 * Forgotten password
 *
 * @author     Opencart-api.com
 * @copyright  2017
 * @license    License.txt
 * @version    2.0
 * @link       https://opencart-api.com/product/shopping-cart-rest-api/
 * @documentations https://opencart-api.com/opencart-rest-api-documentations/
 */
require_once(DIR_SYSTEM . 'engine/restcontroller.php');

class ControllerRestForgotten extends RestController {

    public function forgotten() {

        $this->checkPlugin();

        if ($_SERVER['REQUEST_METHOD'] === 'POST') {

            $post = $this->getPost();

            if ($this->customer->isLogged()) {
                $this->json['error'][] = "User is logged.";
                $this->statusCode = 400;
            } else {
                $this->load->model('account/customer');
                $this->load->language('account/forgotten');
                $this->load->language('mail/forgotten');

                $error = $this->validate($post);

                if (empty($error)) {

                    if ($this->opencartVersion < 2200) {
                        $password = substr(sha1(uniqid(mt_rand(), true)), 0, 10);

                        $this->model_account_customer->editPassword($post['email'], $password);

                        $subject = sprintf($this->language->get('text_subject'), $this->config->get('config_name'));

                        $message = sprintf($this->language->get('text_greeting'), $this->config->get('config_name')) . "\n\n";
                        $message .= $this->language->get('text_password') . "\n\n";
                        $message .= $password;
                    } else {

                        $code = token(40);

                        $this->model_account_customer->editCode($post['email'], $code);

                        $subject = sprintf($this->language->get('text_subject'), html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'));

                        $message = sprintf($this->language->get('text_greeting'), html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8')) . "\n\n";
                        $message .= $this->language->get('text_change') . "\n\n";
                        $message .= $this->url->link('account/reset', 'code=' . $code, true) . "\n\n";
                        $message .= sprintf($this->language->get('text_ip'), $this->request->server['REMOTE_ADDR']) . "\n\n";
                    }


                    if ($this->opencartVersion <= 2011) {
                        $mail = new Mail($this->config->get('config_mail'));
                    } else {
                        $mail = new Mail();
                        $mail->protocol = $this->config->get('config_mail_protocol');
                        $mail->parameter = $this->config->get('config_mail_parameter');

                        if ($this->opencartVersion == 2020) {
                            $mail->smtp_hostname = $this->config->get('config_mail_smtp_host');
                        } else {
                            $mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
                        }

                        $mail->smtp_username = $this->config->get('config_mail_smtp_username');
                        $mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
                        $mail->smtp_port = $this->config->get('config_mail_smtp_port');
                        $mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');
                    }

                    $mail->setTo($post['email']);
                    $mail->setFrom($this->config->get('config_email'));
                    $mail->setSender(html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'));
                    $mail->setSubject(html_entity_decode($subject, ENT_QUOTES, 'UTF-8'));
                    $mail->setText(html_entity_decode($message, ENT_QUOTES, 'UTF-8'));
                    $mail->send();
                } else {
                    $this->statusCode = 400;
                    $this->json['error'] = $error;
                }
            }
        } else {
            $this->statusCode = 405;
            $this->allowedHeaders = array("POST");
        }

        $this->sendResponse();
    }

    protected function validate($post) {
        $error = array();
        if (!isset($post['email'])) {
            $error[] = $this->language->get('error_email');
        } elseif (!$this->model_account_customer->getTotalCustomersByEmail($post['email'])) {
            $error[] = $this->language->get('error_email');
        }
        return $error;
    }

}
