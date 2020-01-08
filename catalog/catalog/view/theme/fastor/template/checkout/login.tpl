<div class="row">
  <div class="col-sm-6">
    <h2><?php echo $text_new_customer; ?></h2>
    <p><?php echo $text_checkout; ?></p>
    <div class="radio">
      <label>
        <?php if ($account == 'register') { ?>
        <input type="radio" name="account" value="register" checked="checked" />
        <?php } else { ?>
        <input type="radio" name="account" value="register" />
        <?php } ?>
        <?php echo $text_register; ?></label>
    </div>
    <?php if ($checkout_guest) { ?>
    <div class="radio">
      <label>
        <?php if ($account == 'guest') { ?>
        <input type="radio" name="account" value="guest" checked="checked" />
        <?php } else { ?>
        <input type="radio" name="account" value="guest" />
        <?php } ?>
        <?php echo $text_guest; ?></label>
    </div>
    <?php } ?>
    <p style="padding-top: 10px"><?php echo $text_register_account; ?></p>
    <input type="button" value="<?php echo $button_continue; ?>" id="button-account" data-loading-text="<?php echo $text_loading; ?>" style="margin-bottom:25px;" class="btn btn-primary" />
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
  <div class="col-sm-6">
    <h2><?php echo $text_returning_customer; ?></h2>
    <p><?php echo $text_i_am_returning_customer; ?></p>
    <div class="form-group">
      <label class="control-label" for="input-email"><?php echo $entry_email; ?></label>
      <input type="text" name="email" value="" placeholder="<?php echo $entry_email; ?>" id="input-email" class="form-control" />
    </div>
    <div class="form-group">
      <label class="control-label" for="input-password"><?php echo $entry_password; ?></label>
      <input type="password" name="password" value="" placeholder="<?php echo $entry_password; ?>" id="input-password" class="form-control" />
     </div>
    <input type="button" value="<?php echo $button_login; ?>" id="button-login" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary" />
     <a href="<?php echo $forgotten; ?>" style="margin-top: 5px;float:right;display: inline-block;"><?php echo $text_forgotten; ?></a>
  </div>
</div>
