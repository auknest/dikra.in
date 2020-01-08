<?php if ($hideadl == 0) { ?>

<link rel="stylesheet" type="text/css" href="catalog/view/javascript/jquery/fancybox/advancedloginsideboxleft.css" media="screen" />

<div class="panelleftslidelogin">


 <div align="center">

<table id="loginapopupt" border="0" cellpadding="0" cellspacing="0" style="width: 344px; height: auto;" >
	<tbody>
		<tr>
		
			<td colspan="2">
			
<img alt="" src="<?php echo $headerimage; ?>" align="middle"/>
			</td>
		</tr><br />
		<tr>
		
		<td>
		<?php if ($fbenable==1 || $genable==1) { ?>
		<P ALIGN="CENTER"><?php echo $fbmessgetop; ?></P>
				<P ALIGN="CENTER"><?php echo $fbheading; ?></P>
			<div align="center">
	
		<?php if ($fbenable==1) { ?>


			
			<a class="box-advancedlogin" href="<?php echo $advancedlogin_url; ?>"><img alt="" src="<?php echo $fbbutton; ?>"/></a>
			<?php } ?>						

<?php if ($genable==1) { ?>
								<a class="box-advancedloging" href="<?php echo $advancedlogin_furl; ?>"><img alt="" src="<?php echo $gbutton; ?>"/></a>
			<?php } ?>
			</div>
<P ALIGN="CENTER"><?php echo $fbmessgebottom; ?></P>

<?php } ?>	
			</td>


			<td>
				<?php if ($localenable==1) { ?>
<P ALIGN="CENTER"><?php echo $logmessgetop; ?></P>
<P ALIGN="CENTER"><?php echo $logheading; ?></P>

<form id="module_loginsl"> 
	<P ALIGN="CENTER">
<b><?php echo $entry_email_address; ?></b><br />
    <input type="text" name="email"  id="email" size="35" >
    <br />
    <b><?php echo $entry_password; ?></b><br />
    <input type="password" name="password" id="password" size="35" >
        <br /><br />
    
   
 <div align="center">
 <a class="btn btn-primary" onclick="login()"><span><?php echo $button_login; ?></span></a>


<a href="<?php echo $forgotten; ?>" class="btn btn-primary"><span><?php echo $button_forgotten; ?></span></a>
<br /><br />
<a class="btn btn-primary" onclick="register()"><span><?php echo $button_create; ?></span></a>

</div>    
    </P>
<br style="clear:both;"/>
    </form>
<P ALIGN="CENTER"><?php echo $logmessgebottom; ?></P>
<P ALIGN="CENTER" id="register_result"></p>


<?php } ?>
</td>
		</tr>
		</tbody>
</table>

</div>





<script type="text/javascript"><!--
  $('#module_loginsl input').keydown(function(e) {
	  if (e.keyCode == 13) {
		  $('#module_loginsl').submit();
	  }
  });
  //--></script>

</div>


<a class="triggerleftslidelogin" href="#"><?php echo $slidetext; ?></a>
<script type="text/javascript">
$(document).ready(function(){
	$(".triggerleftslidelogin").click(function(){
		$(".panelleftslidelogin").toggle("fast");
		$(this).toggleClass("active");
		return false;
	});
});
</script>
<script language="javascript">
	
function login(){
	$.ajax({
			type: 'post',
			url: 'index.php?route=module/advancedlogin/login',
			dataType: 'html',
            data:$("#module_loginsl").serialize(),
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
            data:$("#module_loginsl").serialize(),
			success: function (html) {
				eval(html);
				if ($("#register_result > span").hasClass("success")) {
				login();
				}
			}}); 
}
</script>

<?php } ?>