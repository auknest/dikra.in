<?php

    /*
     * To change this license header, choose License Headers in Project Properties.
     * To change this template file, choose Tools | Templates
     * and open the template in the editor.
     */
    require_once('api.php');

    class ControllerIcymobiFrontReviews extends ControllerIcymobiFrontApi
    {

        const CREATE_REVIEW = 'add';
        const REQUEST_REVIEW = 'get';

        public $ProductComment;
        
        protected function _getResponse()
        {
            $id = isset($this->request->request['id']) ? $this->request->request['id'] : 0;
            $task = isset($this->request->request['task']) ? $this->request->request['task'] : '';
            if ($id && is_numeric($id)) {
                if ($id && $task == self::CREATE_REVIEW) {
                    $this->createReviewProduct($id);
                }

                return $this->getReviewProduct($id);
            }
            throw new Exception(MessageIcy::REVIEW_ID_NOT_FOUND);
        }

        public function createReviewProduct($productId)
        {
            $userLogin = $this->request->request['user_login'];
            $userEmail = $this->request->request['user_email'];
            $comment = isset($this->request->request['comment']) ? $this->request->request['comment'] : null;
            $rating = intval(isset($this->request->request['rating']) ? $this->request->request['rating'] : null);
            $customerId = isset($this->request->request['user_id']) ? $this->request->request['user_id'] : 0;
            
            if (!$customerId && !$userLogin && !$userEmail) {
                throw new Exception('User info is incorrect');
            }
            if (!($rating)) {
                throw new Exception('You must give a rating');
            }
            $this->load->model('catalog/product');
            
            $product = $this->model_catalog_product->getProduct($productId);
            if (!$product) {
                throw new Exception('Product not found');
            }
            $this->load->model('catalog/review');
            $reviewsData = array(
                'name'   => $userLogin,
                'text'   => $comment,
                'rating' => $rating
            );
            $this->model_catalog_review->addReview($productId, $reviewsData);
            
        }

        public function getReviewProduct($productId)
        {
            $this->load->model('catalog/review');
            
            if (isset($this->request->request['page'])) {
                    $page = $this->request->request['page'];
            } else {
                    $page = 1;
            }

            $results = $this->model_catalog_review->getReviewsByProductId($productId, ($page - 1) * 20, 20);

            return $this->formatArrayCommentsByReference($results);
        }

        public function formatArrayCommentsByReference(&$arrayComments)
        {
            foreach ($arrayComments as &$comment) {
                # code...
                $comment['id'] = (int) $comment['review_id'];
                $comment['date_created'] = $comment['date_added'];
                $comment['name'] = $comment['author'];
                $comment['email'] = '';
                $comment['review'] = $comment['text'];
                $comment['rating'] = (int) $comment['rating'];
                $comment['_links'] = array(
                    'self'       => array(
                        array('href' => '')
                    ),
                    'collection' => array(
                        array('href' => '')
                    ),
                    'up'         => array(
                        array('href' => '')
                    )
                );
                $comment['link_avatar'] = '';
                unset($comment['review_id']);
                unset($comment['date_added']);
                unset($comment['author']);
                unset($comment['text']);
                unset($comment['product_id']);
                unset($comment['image']);
                unset($comment['price']);
            }
            return $arrayComments;
        }

    }
    