<?php 
class Controlleraccountadvancedlogingoogle extends Controller {
	private $error = array();
	      
  	public function index() {
	


		if ($this->customer->isLogged()) {
			if ($this->config->get('advancedlogin_redirect_advurl')) {
	  		$this->response->redirect($this->session->data['advurl']);
			}
			else
			{
			$this->response->redirect($this->url->link('account/account', '', 'SSL'));
			}
		}


		

		if(!isset($this->advancedlogin)){
			if (!class_exists('Google')) {
				require_once(DIR_SYSTEM . 'vendor/google-api/Google_Client.php');
				require_once(DIR_SYSTEM . 'vendor/google-api/contrib/Google_Oauth2Service.php');

			}
		$this->googleObject = new Google_Client();
				$this->googleObject->setClientId($this->config->get('advancedlogin_gclientid'));
				
				
				$this->googleObject->setClientSecret($this->config->get('advancedlogin_gapi'));
				$this->googleObject->setRedirectUri($this->url->link('account/advancedlogingoogle', '', 'SSL'));
				$this->googleObject->setScopes(array('https://www.googleapis.com/auth/userinfo.profile', 'https://www.googleapis.com/auth/userinfo.email'));
				$oauth2 = new Google_Oauth2Service($this->googleObject);

			
		}
		$salt = $this->config->get('advancedlogin_gpwdsecret');
		if (isset($_GET['code'])) {
  			$this->googleObject->authenticate($_GET['code']);
			$token = $this->googleObject->getAccessToken();
		}
		
		if (isset($token) && isset($oauth2)) {
			$this->googleObject->setAccessToken($token);
			$user = $oauth2->userinfo->get();
			
			if (empty($user['error'])){
				if (!$user['verified_email']) {
					
					$this->response->redirect($this->url->link('account/login'));

				}
				$this->load->model('account/customer');
				
				$email = $user['email'];
				$salt = (!empty($salt)) ? $salt : 'qwd2asdaej62ad';
				$password = $this->encrypt($user['id'],$salt);
	
				if($this->customer->login($email, $password)){
					
					if ($this->config->get('advancedlogin_redirect_advurl')) {
	  		$this->response->redirect($this->session->data['advurl']);
			}
			else
			{
			$this->response->redirect($this->url->link('account/account', '', 'SSL'));
			}

				}
	
				$email_query = $this->db->query("SELECT `email` FROM " . DB_PREFIX . "customer WHERE LOWER(email) = '" . $this->db->escape(strtolower($email)) . "'");
	
				if($email_query->num_rows) {
					$this->model_account_customer->editPassword($email, $password);
					if($this->customer->login($email, $password)){
					if ($this->config->get('advancedlogin_redirect_advurl')) {
	  		$this->response->redirect($this->session->data['advurl']);
			}
			else
			{
			$this->response->redirect($this->url->link('account/account', '', 'SSL'));
			}

					}
				} 
				else{
				
			
				$this->request->post['email'] = $email;
			
			$newUserData = array();
			
					$newUserData['firstname'] = isset($user['given_name']) ? $user['given_name'] : '';
					$newUserData['lastname'] = isset($user['family_name']) ? $user['family_name'] : '';
					$newUserData['email'] = $user['email'];
					$newUserData['password'] = $password;
					
				$this->load->model('account/advancedlogin');
				$this->model_account_advancedlogin->register($newUserData, 2);
				

				if($this->customer->login($email, $password)){
						unset($this->session->data['guest']);
					if ($this->config->get('advancedlogin_redirect_advurl')) {
	  		$this->response->redirect($this->session->data['advurl']);
			}
			else
			{
			$this->response->redirect($this->url->link('account/success', '', 'SSL'));
			}
					}
					
				}
				
			}
		}
		
		$this->response->redirect($this->url->link('account/login'));

	}
	

	
	function encrypt($text,$salt) 
	{ 
		return trim(base64_encode(mcrypt_encrypt(MCRYPT_RIJNDAEL_256, $salt, $text, MCRYPT_MODE_ECB, mcrypt_create_iv(mcrypt_get_iv_size(MCRYPT_RIJNDAEL_256, MCRYPT_MODE_ECB), MCRYPT_RAND)))); 
	} 
	
	function decrypt($text,$salt) 
	{ 
		return trim(mcrypt_decrypt(MCRYPT_RIJNDAEL_256, $salt, base64_decode($text), MCRYPT_MODE_ECB, mcrypt_create_iv(mcrypt_get_iv_size(MCRYPT_RIJNDAEL_256, MCRYPT_MODE_ECB), MCRYPT_RAND))); 
	} 


	function htmlspecialcharsDecode($data) {
    	if (is_array($data)) {
	  		foreach ($data as $key => $value) {
				unset($data[$key]);
				$data[$this->htmlspecialcharsDecode($key)] = $this->htmlspecialcharsDecode($value);
	  		}
		} else { 
	  		$data = htmlspecialchars_decode($data, ENT_COMPAT);
		}

		return $data;
	}	  

}
?>