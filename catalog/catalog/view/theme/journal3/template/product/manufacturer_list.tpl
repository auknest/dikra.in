<?php echo $header; ?>
<ul class="breadcrumb">
  <?php foreach ($breadcrumbs as $breadcrumb) { ?>
  <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
  <?php } ?>
</ul>
<?php if ($j3->settings->get('pageTitlePosition') === 'top'): ?>
  <h1 class="title page-title"><span><?php echo $heading_title; ?></span></h1>
<?php endif; ?>
<?php echo $j3->loadController('journal3/layout', 'top'); ?>
<div class="container">
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
      <?php if ($categories) { ?>
      <p><strong><?php echo $text_index; ?></strong> <?php foreach ($categories as $category): ?>
        &nbsp;&nbsp;&nbsp;<a href="index.php?route=product/manufacturer#<?php echo $category['name']; ?>"><?php echo $category['name']; ?></a> <?php endforeach; ?> </p>
      <?php foreach ($categories as $category) { ?>
      <h2 id="<?php echo $category['name']; ?>" class="title manufacturer-letter"><?php echo $category['name']; ?></h2>
      <?php if ($category['manufacturer']) { ?>
      <div class="manufacturer"> <?php foreach ($category['manufacturer'] as $manufacturer) { ?>
        <div><a href="<?php echo $manufacturer['href']; ?>" class="image-card"><img src="<?php echo $manufacturer['image']; ?>" alt="<?php echo $manufacturer['name']; ?>"/><span><?php echo $manufacturer['name']; ?></span></a></div>
      <?php } ?>
      </div>
      <?php } ?>
      <?php } ?>
      <?php } else { ?>
      <p><?php echo $text_empty; ?></p>
      <div class="buttons clearfix">
        <div class="pull-right"><a href="<?php echo $continue; ?>" class="btn btn-primary"><?php echo $button_continue; ?></a></div>
      </div>
      <?php } ?>
      <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>
<?php echo $footer; ?>
