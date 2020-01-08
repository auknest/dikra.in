<?php echo $header; 
$theme_options = $registry->get('theme_options');
$config = $registry->get('config'); 
include('catalog/view/theme/' . $config->get($config->get('config_theme') . '_directory') . '/template/new_elements/wrapper_top.tpl'); ?>
<style>
    .form-group{
        margin-bottom:0;
    }
</style>
<div class="row">
    <div class="col-md-3">
    </div>
    <div class="col-md-6" style="background: #a8d4af82">
  <div class="col-md-1">
        </div>
       
        <div class="col-md-10">
            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="form-horizontal">
                <fieldset>
                    <legend  class="text-center">Seller Registration </legend>
                    <div class="form-group required">
                        <label class="text-bold control-label" for="input-name">Name</label>
                        <input type="text" name="name" value="<?php echo $name ?>" id="input-name" class="form-control" />
                        <?php if ($error_name) { ?>
                        <div class="text-danger"><?php echo $error_name; ?></div>
                        <?php } ?>
                    </div>
                    <div class="form-group required">
                        <label class="text-bold control-label" for="input-company">Company Name</label>
                        <input type="text" name="company" value="<?php echo $company ?>" id="input-company" class="form-control" />
                        <?php if ($error_company) { ?>
                        <div class="text-danger"><?php echo $error_company; ?></div>
                        <?php } ?>
                    </div>
                    <div class="form-group required">
                        <label class="text-bold control-label" for="input-brand">Brand Name</label>
                        <input type="text" name="brand" value="<?php echo $brand ?>" id="input-brand" class="form-control" />
                        <?php if ($error_brand) { ?>
                        <div class="text-danger"><?php echo $error_brand; ?></div>
                        <?php } ?>
                    </div>
                    <div class="form-group required">
                        <label class="text-bold control-label" for="input-email">E-Mail</label>
                        <input type="text" name="email" value="<?php echo $email ?>" id="input-email" class="form-control" />
                        <?php if ($error_email) { ?>
                        <div class="text-danger"><?php echo $error_email; ?></div>
                        <?php } ?>
                    </div>
                    <div class="form-group required">

                        <label class="control-label" for="input-phone">Phone</label>
                        <input type="text" name="phone" value="<?php echo $phone ?>" id="input-email" class="form-control" />
                        <?php if ($error_phone) { ?>
                        <div class="text-danger"><?php echo $error_phone; ?></div>
                        <?php } ?>
                    </div>

                </fieldset>
                <div class="buttons">
                    <div class="text-center">
                        <input class="btn btn-primary" type="submit" value="Register" />
                    </div>
                </div>
            </form></div>
         <div class="col-md-1">
        </div>
    </div>
</div>
<?php include('catalog/view/theme/' . $config->get($config->get('config_theme') . '_directory') . '/template/new_elements/wrapper_bottom.tpl'); ?>
<?php echo $footer; ?>