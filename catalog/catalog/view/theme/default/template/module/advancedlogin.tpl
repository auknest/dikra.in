<?php if ($hideadl == 0) { ?>
<div>
 <h3><?php echo $fbheading; ?></h3>
  <div class="box-content"> 
<div style="float:left; text-align: right;">	<a class="box-advancedloginf" href="<?php echo $advancedlogin_url; ?>"><img alt="" src="<?php echo $fbbutton; ?>"/></a></div>
  <br><br><br>
<div style="float:left; text-align: right;"><a class="box-advancedloging" href="<?php echo $advancedlogin_furl; ?>"><img alt="" src="<?php echo $gbutton; ?>"/></a></div>
  <br>



  <h3><?php echo $logheading; ?></h3>

	
	<form id="module_loginn"> 
	<b><?php echo $entry_email_address; ?></b><br />
    <span style="text-align: left;"><input type="text" name="email" /></span>
    <br />
    <b><?php echo $entry_password; ?></b><br />
    <input type="password" name="password" />
        <br />
<p align="left" id="register_result"></p>
<p align="left" id="loginresult"></p>
    <div style="float:left; text-align: right;">
	 <a class="btn btn-primary" onclick="login()"><span><?php echo $button_login; ?></span></a>
	</div>
   
 <div style="float:left; text-align: right;"><a href="<?php echo $forgotten; ?>" class="btn btn-primary"><span><?php echo $button_forgotten; ?></span></a></div>



<div style="float:left; text-align: right;"><a class="btn btn-primary" onclick="register()"><?php echo $button_create; ?></a></div>
    
<br style="clear:both;"/>


    </form>
  </div>
 </div>

  <script type="text/javascript"><!--
  $('#module_loginn input').keydown(function(e) {
	  if (e.keyCode == 13) {
		  $('#module_loginn').submit();
	  }
  });
  
//--></script>
<script language="javascript">
	
function login(){
	$.ajax({
			type: 'post',
			url: 'index.php?route=module/advancedlogin/login',
			dataType: 'html',
            data:$("#module_loginn").serialize(),
			success: function (html) {

				eval(html);
							if ($("#loginresult").hasClass("success")) {
							
				<?php if ($redirect_advurl==1): ?>	
				var str= '<?php echo $advurl; ?>';
				var res= str.replace("&amp;", "&"); 
				
				window.location = res ;
				<?php else : ?>
					window.location = 'index.php?route=account/account';
				<?php endif; ?>
				}
			}}); 
}
</script>
<script language="javascript">
	
function register(){
	$.ajax({
			type: 'post',
			url: 'index.php?route=module/advancedlogin/register',
			dataType: 'html',
            data:$("#module_loginn").serialize(),
			success: function (html) {
			
				eval(html);
				if ($("#register_result > span").hasClass("success")) {
				login();
				}
			}}); 
}
</script>
<?php } ?>
