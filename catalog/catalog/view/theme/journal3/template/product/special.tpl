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
      <div class="main-products-wrapper">
      <?php if ($products): ?>
        <?php if ($j3->settings->get('sortBarStatus')): ?>
          <div class="products-filter">
            <div class="grid-list">
              <button id="btn-grid-view" class="view-btn <?php if($j3->settings->get('globalProductView') == 'grid'): ?>active<?php endif; ?>" data-toggle="tooltip" title="<?php echo $button_grid; ?>" data-view="grid"></button>
              <button id="btn-list-view" class="view-btn <?php if($j3->settings->get('globalProductView') == 'list'): ?>active<?php endif; ?>" data-toggle="tooltip" title="<?php echo $button_list; ?>" data-view="list"></button>
              <a href="<?php echo $compare; ?>" id="compare-total" class="compare-btn"><?php echo $text_compare; ?></a>
            </div>
            <div class="select-group">
              <div class="input-group input-group-sm sort-by">
                <label class="input-group-addon" for="input-sort"><?php echo $text_sort; ?></label>
                <select id="input-sort" class="form-control" onchange="location = this.value;">
                  <?php foreach ($sorts as $sorts): ?>
                    <?php if ($sorts['value'] == $sort . '-' . $order): ?>
                      <option value="<?php echo $sorts['href']; ?>" selected="selected"><?php echo $sorts['text']; ?></option>
                    <?php else: ?>
                      <option value="<?php echo $sorts['href']; ?>"><?php echo $sorts['text']; ?></option>
                    <?php endif; ?>
                  <?php endforeach; ?>
                </select>
              </div>
              <div class="input-group input-group-sm per-page">
                <label class="input-group-addon" for="input-limit"><?php echo $text_limit; ?></label>
                <select id="input-limit" class="form-control" onchange="location = this.value;">
                  <?php foreach ($limits as $limits): ?>
                    <?php if ($limits['value'] == $limit): ?>
                      <option value="<?php echo $limits['href']; ?>" selected="selected"><?php echo $limits['text']; ?></option>
                    <?php else: ?>
                      <option value="<?php echo $limits['href']; ?>"><?php echo $limits['text']; ?></option>
                    <?php endif; ?>
                  <?php endforeach; ?>
                </select>
              </div>
            </div>
          </div>
        <?php endif; ?>
        <div class="main-products product-<?php echo $j3->settings->get('globalProductView'); ?>">
          <?php $display = $j3->settings->get('globalProductView'); ?>
          <?php include $j3->incl('journal3/product_card.tpl'); ?>
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
      </div>
      <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>
<?php echo $footer; ?>
