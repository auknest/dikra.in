<?php echo $header; ?>
<?php echo $j3->loadController('journal3/layout', 'top'); ?>
<?php if ($content_top || $content_bottom || $column_left || $column_right): ?>
<div id="common-home" class="container">
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <?php if ($content_top || $content_bottom): ?>
    <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?><?php echo $content_bottom; ?></div>
    <?php endif; ?>
    <?php echo $column_right; ?></div>
</div>
<?php endif; ?>
<?php echo $j3->loadController('journal3/seo/rich_snippets'); ?>
<?php echo $footer; ?>
