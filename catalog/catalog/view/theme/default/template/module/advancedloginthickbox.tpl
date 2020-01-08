<?php if ($hideadl == 0) { ?>

<style type="text/css">
.fancybox-outer {
    background: none repeat scroll 0 0 #000000 !important; }
</style>

<script src="//code.jquery.com/jquery-migrate-1.0.0.js"></script>
<link rel="stylesheet" type="text/css" href="catalog/view/javascript/jquery/fancybox/advancedloginpopup.css" media="screen" />
<script type="text/javascript" src="catalog/view/javascript/jquery/fancybox/jquery.fancybox.pack.js"></script>

<link rel="stylesheet" type="text/css" href="catalog/view/javascript/jquery/fancybox/jquery.fancybox.css" media="screen" />

<a href="#loginpopupt_form" title="Login" class="loginpopupt"><img alt="" src="<?php echo $thickboxbutton; ?>" align="middle"/></a>


<div style="display:none">
 <div id="loginpopupt_form">
 <div class="advancedlogin">
 <p align="center"><?php echo $fbheading; ?></p>
 <img alt="" src="<?php echo $headerimage; ?>" align="middle"/>
 <div align="center">


<div id="contactform">

	<div class="formcolumn">
<?php if ($fbenable==1 || $genable==1) { ?>
       	<P ALIGN="CENTER"><?php echo $fbmessgetop; ?></P>
				<br />
			<div align="center">
	
		<?php if ($fbenable==1) { ?>
				<a class="box-advancedlogin" href="<?php echo $advancedlogin_url; ?>"><img alt="" src="<?php echo $fbbutton; ?>"/></a>
	<br />		<?php } ?>						

<?php if ($genable==1) { ?>
								<a class="box-advancedloging" href="<?php echo $advancedlogin_furl; ?>"><img alt="" src="<?php echo $gbutton; ?>"/></a>
			<?php } ?>
			
			</div>
<P ALIGN="CENTER"><?php echo $fbmessgebottom; ?></P>

<?php } ?> 
    </div>
 


	<div class="formcolumn">
    
	<?php if ($localenable==1) { ?>
<P ALIGN="CENTER"><?php echo $logmessgetop; ?></P>
<P ALIGN="CENTER"><?php echo $logheading; ?></P><br />
<form id="module_logintk"> 
	<P ALIGN="CENTER">
<input type="text" id="email" name="email" placeholder="<?php echo $entry_email_address; ?>">
    <br />

	<input type="password" id="password" name="password" placeholder="<?php echo $entry_password; ?>">
	<input type="hidden" name="fancybox"  id="fancybox" value="">
        <br /><br />
    
   
 <div align="center"><a class="button" onclick="login()"><?php echo $button_login; ?></a></a>

<a href="<?php echo $forgotten; ?>" class="button"><?php echo $button_forgotten; ?></a> <br /><br />
<a class="button" onclick="register()"><?php echo $button_create; ?></a></div>    
    </P>

    </form><br />
<P ALIGN="CENTER"><?php echo $logmessgebottom; ?></P>


<?php } ?>
	
  </div>
</div>


</div> </div></div></div> 




<script type="text/javascript"><!--
  $('#module_logintk input').keydown(function(e) {
	  if (e.keyCode == 13) {
		  $('#module_logintk').submit();
	  }
  });
  //--></script>
<script type="text/javascript">

$('.loginpopupt').fancybox({  'padding' : 0,  'scrolling'        : 'no',   'titleShow'        : false,   });



</script>
<script language="javascript">
	
function login(){
	$.ajax({
			type: 'post',
			url: 'index.php?route=module/advancedlogin/login',
			dataType: 'json',
            data:$("#module_logintk").serialize(),
			
			success: function(data){
				
			 	 $('#module_logintk').before('<div class="' + data.type + '">' + data.message + '</div>');
        $('div.' + data.type).delay(2000).slideUp(200, function(){if($(this).hasClass('success')){
		$.fancybox.close();
		<?php if ($redirect_advurl==1): ?>	
				window.location = '<?php echo $advurl; ?>';
				<?php else : ?>
					window.location = 'index.php?route=account/account';
				<?php endif; ?>
		}$(this).remove();});
				
				
				}});
 		        }
			
			
			
		

</script>

<script language="javascript">
	
function register(){
	$.ajax({
			type: 'post',
			url: 'index.php?route=module/advancedlogin/register',
			dataType: 'json',
            data:$("#module_logintk").serialize(),
			
			success: function(data){
				
			 	 $('#module_logintk').before('<div class="' + data.type + '">' + data.message + '</div>');
        $('div.' + data.type).delay(2000).slideUp(200, function(){if($(this).hasClass('success')){
		login();
		}$(this).remove();});
				
				
				}});
 		        }
</script>


<?php } ?>