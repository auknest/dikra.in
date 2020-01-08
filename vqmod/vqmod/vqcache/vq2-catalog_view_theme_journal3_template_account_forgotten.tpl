<?php echo $header; ?>
<ul class="breadcrumb">
  <?php foreach ($breadcrumbs as $breadcrumb) { ?>
  <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
  <?php } ?>
</ul>
<?php if ($j3->settings->get('pageTitlePosition') === 'top'): ?>
  
                <style>
                
                .title-divider-bottom {
    display: block;
    height: 3px;
    background: #db8fb3;
    margin-top: 15px;
    margin-bottom: 15px;
    margin-left: auto;
    margin-right: 36%;
}
                .title-divider-top {
    display: block;
    height: 3px;
    background: #db8fb3;
    margin-top: 15px;
    margin-bottom: 15px;
    margin-left: 36%;
    margin-right: auto;
}
                .refine-categories,.category-description,.products-filter{
display:none;              
  }
                .title-wrapper-top {
    margin: unset;
    text-align: center;
                    padding-left: 20px;
                    padding-right: 20px;
}
                </style>
                <div class="title-wrapper-top">
      <div class="title-divider-top"></div>
    <h3><?php echo $heading_title; ?></h3>
    <div class="title-divider"></div>
    <div class="title-divider-bottom"></div>
  </div>			

<?php endif; ?>
<?php echo $j3->loadController('journal3/layout', 'top'); ?>
<div id="account-forgotten" class="container">
  <?php if ($error_warning) { ?>
  <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?></div>
  <?php } ?>
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
      <p><?php echo $text_email; ?></p>
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="form-horizontal">
        <fieldset>
          <legend><?php echo $text_your_email; ?></legend>
          <div class="form-group required">
            <label class="col-sm-2 control-label" for="input-email"><?php echo $entry_email; ?></label>
            <div class="col-sm-10">
              <input type="text" name="email" value="<?php echo $email; ?>" placeholder="<?php echo $entry_email; ?>" id="input-email" class="form-control" />
            </div>
          </div>
        </fieldset>
        <div class="buttons clearfix">
          <div class="pull-left"><a href="<?php echo $back; ?>" class="btn btn-default"><?php echo $button_back; ?></a></div>
          <div class="pull-right">
            <button type="submit" class="btn btn-primary"><span><?php echo $button_continue; ?></span></button>
          </div>
        </div>
      </form>
      <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>
<?php echo $footer; ?>
