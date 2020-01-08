<div class="panel-default">
    <div class="panel-heading"><i class="fa fa-user" aria-hidden="true"></i>
        Login
    </div>

    <div class="row" id="login_details">
        <div class="col-sm-12">
            <div class="row">
                <div class="col-sm-12">
                    <div class="form-group">
                        <label class="control-label" for="input-email"><?php echo $entry_email; ?>/Mobile No</label>
                        <input type="text" name="email" value="" placeholder="<?php echo $entry_email; ?>/Mobile No" id="input-email" class="form-control" />
                    </div>
                    <div class="form-group">
                        <label class="control-label" for="input-password"><?php echo $entry_password; ?></label>
                        <input type="password" name="password" value="" placeholder="<?php echo $entry_password; ?>" id="input-password" class="form-control" />
                        <input type="button" value="<?php echo $button_login; ?>" id="button-login" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary" />
                        <a href="<?php echo $forgotten; ?>" style="margin-top: 5px;float:right;display: inline-block;"><?php echo $text_forgotten; ?></a>
                    </div>
                </div>
            </div>
        </div>
        <br>
        <div class="col-sm-12 hidden" >
            <div class="radio">
                <label>
                    <?php if ($account == 'register') { ?>
                    <input  type="radio" name="account" value="register" checked="checked" />
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
            <input  type="button" value="<?php echo $button_continue; ?>" id="button-account" data-loading-text="<?php echo $text_loading; ?>" style="margin-bottom:25px;" class="btn btn-primary hidden" />
        </div>
        <div class="col-sm-6">
            <?php if ($fbenable==1) { ?>
            <a href="<?php echo $advancedlogin_url; ?>" class="btn btn-block btn-social btn-facebook box-advancedlogin" style="width: 100%;text-align: center;">
                    <i class="fa fa-facebook"></i>Facebook
            </a>
            <!--            <a class="box-advancedlogin" ><img alt="" src="<?php echo $fbbutton; ?>"/></a>-->
            <?php } ?>
        </div>
        <div class="col-sm-6" >
            <?php if ($genable==1) { ?>
           <a  href="<?php echo $advancedlogin_furl; ?>" class="btn btn-block btn-social btn-google-plus box-advancedloging" style="width: 100%;text-align: center;">
                    <i class="fa fa-google-plus"></i>Google
            </a>
            <!-- <a class="box-advancedloging" href="<?php echo $advancedlogin_furl; ?>"></a>-->
            <?php } ?>
        </div>
    </div>
</div>
<div class="modal fade" id="myModal" role="dialog" style="">
    <div id="leologin"><div class="modal-dialog modal-sm">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">×</button>
                    <h2 class="modal-title text-center"><i class="fa fa-user"></i> Login please</h2>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label class="control-label" for="input-email"><?php echo $entry_email; ?></label>
                                        <input type="text" name="email" value="" placeholder="<?php echo $entry_email; ?>" id="input-email" class="form-control" />
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label" for="input-password"><?php echo $entry_password; ?></label>
                                        <input type="password" name="password" value="" placeholder="<?php echo $entry_password; ?>" id="input-password" class="form-control" />
                                        <input type="button" value="<?php echo $button_login; ?>" id="button-login" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary" />
                                        <a href="<?php echo $forgotten; ?>" style="margin-top: 5px;float:right;display: inline-block;"><?php echo $text_forgotten; ?></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div></div>
    </div>