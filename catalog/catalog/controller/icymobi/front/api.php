<?php

    /**
     * Description of api
     *
     * @author KhanhTT <khanh.tran@inspius.com at inspius.com>
     */
    require_once('helpers/Status.php');
    require_once('helpers/Message.php');

    abstract class ControllerIcymobiFrontApi extends Controller
    {

        public function index()
        {
//            echo 'sdcsdcsdcsd';
//            return;
            // Allow from any origin
            if (isset($this->request->server['HTTP_ORIGIN'])) {
                header("Access-Control-Allow-Origin: {$this->request->server['HTTP_ORIGIN']}");
                header('Access-Control-Allow-Credentials: true');
                header('Access-Control-Max-Age: 86400');    // cache for 1 day
            }

            // Access-Control headers are received during OPTIONS requests
            if ($this->request->server['REQUEST_METHOD'] == 'OPTIONS') {

                if (isset($this->request->server['HTTP_ACCESS_CONTROL_REQUEST_METHOD']))
                    header("Access-Control-Allow-Methods: GET, POST, OPTIONS");

                if (isset($this->request->server['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']))
                    header("Access-Control-Allow-Headers:        {$this->request->server['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']}");

                exit(0);
            }
            header('Content-Type: application/json');
//            echo 'sdcsdcsdcsd';
//            return;
            try {
                echo $this->_formatResponse(Status::API_SUCCESS, null, $this->_getResponse());
            }
            catch (\Exception $ex) {
                echo $this->_formatResponse(Status::API_FAILED, $ex->getMessage());
            }
        }

        protected abstract function _getResponse();

        protected function _formatResponse($status = Status::API_SUCCESS, $message = '', $data = array ())
        {
            return json_encode(array (
                'status'  => $status,
                'message' => $message,
                'data'    => $data
            ));
        }

    }
    