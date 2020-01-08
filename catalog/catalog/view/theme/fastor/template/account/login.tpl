<?php echo $header; 
$theme_options = $registry->get('theme_options');
$config = $registry->get('config'); 
include('catalog/view/theme/' . $config->get($config->get('config_theme') . '_directory') . '/template/new_elements/wrapper_top.tpl'); ?>

<div class="row">
    <div class="col-sm-6">
        <div class="well">
            <h2><?php echo $text_new_customer; ?></h2>
            <p><strong><?php echo $text_register; ?></strong></p>
            <p style="padding-bottom: 10px"><?php echo $text_register_account; ?></p>
            <a href="<?php echo $register; ?>" class="btn btn-primary"><?php echo "Register"; ?></a>

        </div>
    </div>
    <div class="col-sm-6">
        <div class="well">
            <h2><?php echo $text_returning_customer; ?></h2>
            <p><strong><?php echo $text_i_am_returning_customer; ?></strong></p>
            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <label class="control-label" for="input-email"><?php echo $entry_email; ?>/Mobile No</label>
                    <input type="text" name="email" value="<?php echo $email; ?>" placeholder="<?php echo $entry_email; ?>/Mobile No" id="input-email" class="form-control" />
                </div>
                <div class="form-group" style="padding-bottom: 10px">
                    <label class="control-label" for="input-password"><?php echo $entry_password; ?></label>
                    <input type="password" name="password" value="<?php echo $password; ?>" placeholder="<?php echo $entry_password; ?>" id="input-password" class="form-control" />
                </div>
                <input type="submit" value="<?php echo $button_login; ?>" class="btn btn-primary" />

                <?php if ($redirect) { ?>
                <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
                <?php } ?>
                <a href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a>
            </form>
            <p>
                <?php if ($fbenable==1) { ?>
                <a href="<?php echo $advancedlogin_url; ?>" class="btn btn-block btn-social btn-facebook box-advancedlogin">
                    <i class="fa fa-facebook"></i> Sign in with Facebook
                </a>
                <!--            <a class="box-advancedlogin" ><img alt="" src="<?php echo $fbbutton; ?>"/></a>-->
                <?php } ?>
                <?php if ($genable==1) { ?>
                <a  href="<?php echo $advancedlogin_furl; ?>" class="btn btn-block btn-social btn-google-plus box-advancedloging">
                    <i class="fa fa-google-plus"></i> Sign in with Google
                </a>
                <!-- <a class="box-advancedloging" href="<?php echo $advancedlogin_furl; ?>"></a>-->
                <?php } ?>
            </p>
        </div>
    </div>
</div>

<?php include('catalog/view/theme/' . $config->get($config->get('config_theme') . '_directory') . '/template/new_elements/wrapper_bottom.tpl'); ?>
<?php echo $footer; ?>