<?php echo $header; ?>
<ul class="breadcrumb">
  <?php foreach ($breadcrumbs as $breadcrumb) { ?>
  <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
  <?php } ?>
</ul>
<?php if ($j3->settings->get('pageTitlePosition') === 'top'): ?>
  <h1 class="title page-title">
    <span ><?php echo $heading_title; ?></span>
    <?php if ($feed_url): ?>
      <a class="blog-feed" href="<?php echo $feed_url; ?>" target="_blank"><span class="feed-text"><?php echo $j3->settings->get('blogFeedText'); ?></span></a>
    <?php endif; ?>
  </h1>
<?php endif; ?>
<?php echo $j3->loadController('journal3/layout', 'top'); ?>
<div class="container blog-home">
  <div class="row"><?php echo $column_left; ?>
    <div id="content">
      <?php if ($j3->settings->get('pageTitlePosition') === 'default'): ?>
        <h1 class="title page-title">
          <?php echo $heading_title; ?>
          <?php if ($feed_url): ?>
            <a class="blog-feed" href="<?php echo $feed_url; ?>" target="_blank"><span class="feed-text"><?php echo $j3->settings->get('blogFeedText'); ?></span></a>
          <?php endif; ?>
        </h1>
      <?php endif; ?>
      <?php echo $content_top; ?>
      <?php if (isset($category_description) && $category_description): ?>
      <div class="category-description"><?php echo $category_description; ?></div>
      <?php endif; ?>
      <?php if ($posts): ?>
        <div class="main-posts post-<?php echo $j3->settings->get('globalPostView'); ?>">
          <?php include $j3->incl('journal3/post_grid.tpl'); ?>
        </div>
        <div class="row pagination-results">
          <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
          <div class="col-sm-6 text-right"><?php echo $results; ?></div>
        </div>
      <?php else: ?>
        <p><?php echo $text_empty; ?></p>
        <div class="buttons">
          <div class="pull-right"><a href="<?php echo $continue; ?>" class="btn btn-primary"><?php echo $button_continue; ?></a></div>
        </div>
      <?php endif; ?>
      <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>
<?php echo $footer; ?>
