<?php if ($hideadl == 0) { ?>
<link rel="stylesheet" type="text/css" href="catalog/view/javascript/jquery/fancybox/advancedloginfooter.css" media="screen" />



<div class="yellow-strip-wrap">
		<div class="yellow-strip-content">
			

		
		<a style="align:right" id="register_result"></a>
		<a style="align:right" id="loginresult"></a>
				<div class="yellow-strip-inputbox">
					
<div class="subscription-skip">
				&nbsp;</div>
			
				
<?php if ($fbenable==1) { ?>
<a class="box-advancedlogin-a" href="<?php echo $advancedlogin_url; ?>"><img alt="" src="<?php echo $fbbutton; ?>"/></a>
<?php } ?>
<?php if ($genable==1) { ?>
<a class="box-advancedloging" href="<?php echo $advancedlogin_furl; ?>"><img alt="" src="<?php echo $gbutton; ?>"/></a>
<?php } ?>
				


<?php if ($localenable==1) { ?>
<form id="module_loginf"> 
	<b><?php echo $entry_email_address; ?></b>
    <input type="text" name="email" />
   
    <b><?php echo $entry_password; ?></b>
    <input type="password" name="password" />
        
    <a class="btn btn-primary" onclick="login()"><span><?php echo $button_login; ?></span></a>	
<a href="<?php echo $forgotten; ?>" class="btn btn-primary"><span><?php echo $button_forgotten; ?></span></a>
<a class="btn btn-primary" onclick="register()"><span><?php echo $button_create; ?></span></a>




    

    </form><?php } ?>
<div> 

</div>
					
		</div>
	
</div></div>
 <script type="text/javascript"><!--

  $('#module_loginf input').keydown(function(e) {
	  if (e.keyCode == 13) {
		  $('#module_loginf').submit();
	  }
  });
  //--></script>

<script language="javascript">

$(".subscription-skip").click(function () {
   $(".yellow-strip-wrap").fadeOut('slow');
});


</script>
<script language="javascript">
	
function login(){
	$.ajax({
			type: 'post',
			url: 'index.php?route=module/advancedlogin/login',
			dataType: 'html',
            data:$("#module_loginf").serialize(),
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
            data:$("#module_loginf").serialize(),
			success: function (html) {
				eval(html);
			if ($("#register_result > span").hasClass("success")) {
			
				login();
				}
			}}); 
}
</script>
<?php } ?>