<?php echo $header; ?>
<?php if ($j3->settings->get('pageTitlePosition') === 'top'): ?>
  <h1 class="title page-title"><span><?php echo $heading_title; ?></span></h1>
<?php endif; ?>
<div class="container">
  <?php if ($error_warning): ?>
    <div class="alert alert-danger alert-dismissible"><i class="fa fa-exclamation-circle"></i><?php echo $error_warning; ?></div>
  <?php else: ?>
    <?php echo $j3->loadController('journal3/layout', 'top'); ?>
    <div class="row"><?php echo $column_left; ?>
      <?php if ($column_left && $column_right) { ?>
      <?php $class = 'col-sm-6'; ?>
      <?php } elseif ($column_left || $column_right) { ?>
      <?php $class = 'col-sm-9'; ?>
      <?php } else { ?>
      <?php $class = 'col-sm-12'; ?>
      <?php } ?>
      <div id="content" class="<?php echo $class; ?>">
        <?php if ($j3->settings->get('pageTitlePosition') === 'default'): ?>
          <h1 class="title page-title"><?php echo $heading_title; ?></h1>
        <?php endif; ?>
        <?php echo $content_top; ?>
        <form class="form-horizontal">
          <fieldset>
            <div class="form-group required">
              <label class="col-sm-2 control-label" for="input-name"><?php echo $entry_name; ?></label>
              <div class="col-sm-10">
                <input type="text" name="name" value="<?php echo $name; ?>" id="input-name" class="form-control"/>
              </div>
            </div>
            <div class="form-group required">
              <label class="col-sm-2 control-label" for="input-email"><?php echo $entry_email; ?></label>
              <div class="col-sm-10">
                <input type="text" name="email" value="<?php echo $email; ?>" id="input-email" class="form-control"/>
              </div>
            </div>
            <div class="form-group required">
              <label class="col-sm-2 control-label" for="input-enquiry"><?php echo $entry_enquiry; ?></label>
              <div class="col-sm-10">
                <textarea name="enquiry" rows="10" id="input-enquiry" class="form-control"><?php echo $enquiry; ?></textarea>
              </div>
            </div>
          </fieldset>
          <div class="buttons">
            <div class="pull-right">
              <button class="btn btn-primary" type="submit"><span><?php echo $button_submit; ?></span></button>
            </div>
          </div>
        </form>
        <?php echo $content_bottom; ?></div>
      <?php echo $column_right; ?></div>
  <?php endif; ?>
</div>
<?php echo $footer; ?>
