<?php
class ControllerModuleadvancedlogin extends Controller {

	private $error = array();

	public function index($setting) {


	
		$this->session->data['advurl']="http" . (($_SERVER['SERVER_PORT']==443) ? "s://" : "://") . $_SERVER['HTTP_HOST'] . $_SERVER['REQUEST_URI'];
		$this->session->data['advurl']=str_replace("logout","account",$this->session->data['advurl']);
		
		
		$data['advurl']=$this->session->data['advurl'];
		
			
		
		
		$data['redirect_advurl']=$this->config->get('advancedlogin_redirect_advurl');
		
		
		$language_id=$this->config->get('config_language_id');

	$data['logheading'] = $this->config->get('advancedlogin_logheading_'.$language_id);
	$data['logmessgetop'] = $this->config->get('advancedlogin_logmessgetop_'.$language_id);
$data['logmessgebottom'] = $this->config->get('advancedlogin_logmessgebottom_'.$language_id);
$data['slidetext'] = $this->config->get('advancedlogin_slidelabel_'.$language_id);


$data['fbheading'] = $this->config->get('advancedlogin_fbheading_'.$language_id);
$data['fbmessgetop'] = $this->config->get('advancedlogin_fbmessgetop_'.$language_id);
$data['fbmessgebottom'] = $this->config->get('advancedlogin_fbmessgebottom_'.$language_id);




$data['headerimage'] = "image/".$this->config->get('advancedlogin_'.$language_id.'_headerimage');
$data['fbbutton'] = "image/".$this->config->get('advancedlogin_'.$language_id.'_fbutton');
$data['gbutton'] = "image/".$this->config->get('advancedlogin_'.$language_id.'_gbutton');
$data['thickboxbutton'] = "image/".$this->config->get('advancedlogin_'.$language_id.'_thickboxbutton');

$data['popupdelay'] = $this->config->get('advancedlogin_popupdelay');

$data['force'] = $this->config->get('advancedlogin_force');
$data['once'] = $this->config->get('advancedlogin_showonce');
if (($data['force']==0) && ($data['once']==1) )
{
$data['hide'] = 1;
}
else
{
$data['hide'] = 2;
}

$data['genable'] = $this->config->get('advancedlogin_enablegoogle');
$data['fbenable'] = $this->config->get('advancedlogin_enablefb');
$data['localenable'] = $this->config->get('advancedlogin_enablelocal');



      
		
		$data['entry_email_address'] = $this->config->get('advancedlogin_emailaddress_'.$language_id);
		$data['entry_password'] = $this->config->get('advancedlogin_password_'.$language_id);
		
		$data['button_login'] = $this->config->get('advancedlogin_login_'.$language_id);
		$data['button_logout'] = $this->config->get('advancedlogin_logout_'.$language_id);
		$data['button_create'] = $this->config->get('advancedlogin_register_'.$language_id);
	$data['button_forgotten'] = $this->config->get('advancedlogin_forgotten_'.$language_id);
	$data['forgotten'] = $this->url->link('account/forgotten', '', 'SSL');

		
		if(!$this->customer->isLogged()){
		$data['hideadl']=0;
		}
 		else{
		$data['hideadl']=1;
		}
		




	

		if(!$this->customer->isLogged()){

			if(!isset($this->advancedlogin)){			
			
				if ( !class_exists('BaseFacebook') ) {			
				require_once(DIR_SYSTEM . 'vendor/facebook-sdk/facebook.php');
													}
				$this->advancedlogin = new Facebook(array(
					'appId'  => $this->config->get('advancedlogin_apikey'),
					'secret' => $this->config->get('advancedlogin_apisecret'),
				));
			}

			$data['advancedlogin_url'] = $this->advancedlogin->getLoginUrl(
				array(
					'scope' => 'public_profile, email',
					'redirect_uri'  => $this->url->link('account/advancedlogin', '', 'SSL')
				)
			);





		$data['advancedlogin'] = $this->config->get('advancedlogin');
			
			
			
			
			
				if(!isset($this->googleObject)){
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

if ($setting['type']=='normal'){

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/advancedlogin.tpl')) {
				return $this->load->view($this->config->get('config_template') . '/template/module/advancedlogin.tpl', $data);
			} else {
				return $this->load->view('default/template/module/advancedlogin.tpl', $data);
			}

			
}
if ($setting['type']=='popup'){

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/advancedloginpopup.tpl')) {
				return $this->load->view($this->config->get('config_template') . '/template/module/advancedloginpopup.tpl', $data);
			} else {
				return $this->load->view('default/template/module/advancedloginpopup.tpl', $data);
			}

			
}
if ($setting['type']=='thickbox'){

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/advancedloginthickbox.tpl')) {
				return $this->load->view($this->config->get('config_template') . '/template/module/advancedloginthickbox.tpl', $data);
			} else {
				return $this->load->view('default/template/module/advancedloginthickbox.tpl', $data);
			}

						}
if ($setting['type']=='footer'){


		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/advancedloginfooter.tpl')) {
				return $this->load->view($this->config->get('config_template') . '/template/module/advancedloginfooter.tpl', $data);
			} else {
				return $this->load->view('default/template/module/advancedloginfooter.tpl', $data);
			}


}
if ($setting['type']=='slideright'){

if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/advancedloginslideright.tpl')) {
				return $this->load->view($this->config->get('config_template') . '/template/module/advancedloginslideright.tpl', $data);
			} else {
				return $this->load->view('default/template/module/advancedloginslideright.tpl', $data);
			}


			
}
if ($setting['type']=='slideleft'){


if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/advancedloginslideleft.tpl')) {
				return $this->load->view($this->config->get('config_template') . '/template/module/advancedloginslideleft.tpl', $data);
			} else {
				return $this->load->view('default/template/module/advancedloginslideleft.tpl', $data);
			}

			
		

}
if ($setting['type']=='header'){


if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/advancedloginheader.tpl')) {
				return $this->load->view($this->config->get('config_template') . '/template/module/advancedloginheader.tpl', $data);
			} else {
				return $this->load->view('default/template/module/advancedloginheader.tpl', $data);
			}

			
		

}
	


			
		}				

	}
	
	
		public function register(){
		 
	
	$language_id=$this->config->get('config_language_id');
	$data['alreadyexist'] = $this->config->get('advancedlogin_alreadyexist_'.$language_id);
	  $data['enteremail'] = $this->config->get('advancedlogin_enteremail_'.$language_id);
	  $data['enterpassword'] = $this->config->get('advancedlogin_enterpassword_'.$language_id);
	  $data['worngmatch'] = $this->config->get('advancedlogin_worngmatch_'.$language_id);
	  $data['success'] = $this->config->get('advancedlogin_successregister_'.$language_id);
	
			$prefix_eval = "";
		
		$this->load->model('account/advancedlogin');
		
	  		if ( $this->validate()) {
		
			 if(!$this->model_account_advancedlogin->checkmailid($this->request->post)){

		  $this->model_account_advancedlogin->register($this->request->post, 3);
		  
		  if (isset($this->request->post['fancybox'])) {
					$out = array('message' => $data['success'], 'type' => 'success');
					$this->response->addHeader('Content-type: application/json');
					$this->response->setOutput($out ? json_encode($out) : '');
					
					}
					else
					{
					echo('$("'.$prefix_eval.' #register_result").html("<span class=\"success\">'.$data['success'].'</span>")');			
					}
			
	 
	
			 
		   }else{
		   if (isset($this->request->post['fancybox'])) {
					$out = array('message' => $data['alreadyexist'], 'type' => 'error');
					$this->response->addHeader('Content-type: application/json');
					$this->response->setOutput($out ? json_encode($out) : '');
					
					}
					else
					{
						echo('$("'.$prefix_eval.' #register_result").html("<span class=\"error\">'.$data['alreadyexist'].'</span>")');
							
					}
		   
					 
				
		  }
		   
	  }else{
	  
	     if (isset($this->request->post['fancybox'])) {
					$out = array('message' => $this->error['warning'], 'type' => 'error');
					$this->response->addHeader('Content-type: application/json');
					$this->response->setOutput($out ? json_encode($out) : '');
					
					}
					else
					{
					echo('$("'.$prefix_eval.' #register_result").html("<span class=\"error\">'.$this->error['warning'].'</span>")');			
					}
	    	
			
		}
		

	}
	
	
	
	
	public function login(){
	
		$language_id=$this->config->get('config_language_id');
	$data['alreadyexist'] = $this->config->get('advancedlogin_alreadyexist_'.$language_id);
	  $data['enteremail'] = $this->config->get('advancedlogin_enteremail_'.$language_id);
	  $data['enterpassword'] = $this->config->get('advancedlogin_enterpassword_'.$language_id);
	  $data['worngmatch'] = $this->config->get('advancedlogin_worngmatch_'.$language_id);
	  $data['success'] = $this->config->get('advancedlogin_successlogin_'.$language_id);
	  $prefix_eval = "";
	  $this->load->model('account/advancedlogin'); 
	  
		if ( $this->validate()) {
		
		if($this->customer->login($this->request->post['email'], $this->request->post['password'])){
					
					unset($this->session->data['guest']);
					if (isset($this->request->post['fancybox'])) {
					$out = array('message' => $data['success'], 'type' => 'success');
					$this->response->addHeader('Content-type: application/json');
					$this->response->setOutput($out ? json_encode($out) : '');
					
					}
					else
					{
					echo('$("'.$prefix_eval.' #register_result").html("<span id=\"loginresult\" class=\"success\">'.$data['success'].'</span>")');			
					}
				  
				}
				else
				{
						if (isset($this->request->post['fancybox'])) {
						$out = array('message' => $data['worngmatch'], 'type' => 'error');
						$this->response->addHeader('Content-type: application/json');
						$this->response->setOutput($out ? json_encode($out) : '');
					
					}
					else
					{
					echo('$("'.$prefix_eval.' #register_result").html("<span id=\"loginresult\" class=\"error\">'.$data['worngmatch'].'</span>")');		
					}
				
				  
				  }
	}
	  
	  else
	  {
	  if (isset($this->request->post['fancybox'])) {
	  $out = array('message' => $this->error['warning'], 'type' => 'error');
	  
		$this->response->addHeader('Content-type: application/json');
		$this->response->setOutput($out ? json_encode($out) : '');
					}
					else
					{
					echo('$("'.$prefix_eval.' #register_result").html("<span id=\"loginresult\" class=\"error\">'.$this->error['warning'].'</span>")');	
					}
	  
	  
	  }
	

	}
	

	
			public function address(){

	
	$language_id=$this->config->get('config_language_id');
	
	$this->load->model('account/advancedlogin');
	$this->language->load('account/address');
	$sucesssaddress= $this->language->get('text_add');
      	
			
			if ( $this->validateaddress()) {
			 
			$out = array('message' => $sucesssaddress, 'type' => 'alert-success');
			 $this->model_account_advancedlogin->address($this->request->post);		
			 unset($this->session->data['fieldrequired']);
			 }	  
	  else
	  {
			$out = array('message' => $this->error['warning'], 'type' => 'alert-danger');
	  }
	
	
		$this->response->addHeader('Content-type: application/json');
		$this->response->setOutput($out ? json_encode($out) : '');
	}
	
	  	private function validateaddress() {
			
			$this->language->load('account/register');

if (isset($this->request->post['firstname'])) {
if ((utf8_strlen(trim($this->request->post['firstname'])) < 1) || (utf8_strlen(trim($this->request->post['firstname'])) > 32)) {
			$this->error['warning'] = $this->language->get('error_firstname');
		}
		}
		
		if (isset($this->request->post['lastname'])) {

		if ((utf8_strlen(trim($this->request->post['lastname'])) < 1) || (utf8_strlen(trim($this->request->post['lastname'])) > 32)) {
			$this->error['warning'] = $this->language->get('error_lastname');
		}
		}

		if (isset($this->request->post['address_1'])) {
		if ((utf8_strlen(trim($this->request->post['address_1'])) < 3) || (utf8_strlen(trim($this->request->post['address_1'])) > 128)) {
			$this->error['warning'] = $this->language->get('error_address_1');
		}
		}
		
		if (isset($this->request->post['city'])) {

		if ((utf8_strlen(trim($this->request->post['city'])) < 2) || (utf8_strlen(trim($this->request->post['city'])) > 128)) {
			$this->error['warning'] = $this->language->get('error_city');
		}
		}
		
if (isset($this->request->post['country_id'])) {
		$this->load->model('localisation/country');

		$country_info = $this->model_localisation_country->getCountry($this->request->post['country_id']);

		if (isset($this->request->post['postcode'])) {
		if ($country_info && $country_info['postcode_required'] && (utf8_strlen(trim($this->request->post['postcode'])) < 2 || utf8_strlen(trim($this->request->post['postcode'])) > 10)) {
			$this->error['warning'] = $this->language->get('error_postcode');
		}
		}
		

		if ($this->request->post['country_id'] == '') {
			$this->error['warning'] = $this->language->get('error_country');
		}

		if (isset($this->request->post['zone_id'])) {
		if (!isset($this->request->post['zone_id']) || $this->request->post['zone_id'] == '') {
			$this->error['warning'] = $this->language->get('error_zone');
		}
		}
		}

		

		
		
    	if (!$this->error) {
      		return true;
		} else {
      		return false;
    	}
  	}
	
	
	public function registerfancybox(){

	
	$language_id=$this->config->get('config_language_id');
	$data['alreadyexist'] = $this->config->get('advancedlogin_alreadyexist_'.$language_id);
	  $data['enteremail'] = $this->config->get('advancedlogin_enteremail_'.$language_id);
	  $data['enterpassword'] = $this->config->get('advancedlogin_enterpassword_'.$language_id);
	  $data['worngmatch'] = $this->config->get('advancedlogin_worngmatch_'.$language_id);

		
		$this->load->model('account/advancedlogin');
		
	  		if ( $this->validate()) {
		
			 if(!$this->model_account_advancedlogin->checkmailid($this->request->post)){

		  $this->model_account_advancedlogin->register($this->request->post);
			
	
			 
		   }else{
					$out = array('message' => $data['alreadyexist'], 'type' => 'warning');
				
		  }
		   
	  }else{
	    	
			$out = array('message' => $this->error['warning'], 'type' => 'warning');
		}

			
		
		$this->response->addHeader('Content-type: application/json');
		$this->response->setOutput($out ? json_encode($out) : '');
		
	}
	
	private function validate() {

     $language_id=$this->config->get('config_language_id');
		$data['alreadyexist'] = $this->config->get('advancedlogin_alreadyexist_'.$language_id);
	  $data['enteremail'] = $this->config->get('advancedlogin_enteremail_'.$language_id);
	  $data['enterpassword'] = $this->config->get('advancedlogin_enterpassword_'.$language_id);
	  $data['worngmatch'] = $this->config->get('advancedlogin_worngmatch_'.$language_id);
		
	
 if ((utf8_strlen($this->request->post['email']) > 96) || !preg_match('/^[^\@]+@.*\.[a-z]{2,6}$/i', $this->request->post['email'])) {
      		$this->error['warning'] = $data['enteremail'];
    	}

    	
    	if ((utf8_strlen($this->request->post['password']) < 1) || (utf8_strlen($this->request->post['password']) > 20)) {
      		$this->error['warning'] =  $data['enterpassword'];
    	}

	
		
    	if (!$this->error) {
      		return true;
    	} else {
      		return false;
    	}
  	}
	
	
	
	
	
}
?>
