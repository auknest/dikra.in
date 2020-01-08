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
      <h2 class="title search-criteria-title"><?php echo $entry_search; ?></h2>

      <div class="search-form">
        <div class="inputs">
          <input type="text" name="search" value="<?php echo $search; ?>" placeholder="<?php echo $text_keyword; ?>" id="input-search" class="form-control" />

          <select name="category_id" class="form-control">
            <option value="0"><?php echo $text_category; ?></option>
            <?php foreach ($categories as $category_1) { ?>
            <?php if ($category_1['category_id'] == $category_id) { ?>
            <option value="<?php echo $category_1['category_id']; ?>" selected="selected"><?php echo $category_1['name']; ?></option>
            <?php } else { ?>
            <option value="<?php echo $category_1['category_id']; ?>"><?php echo $category_1['name']; ?></option>
            <?php } ?>
            <?php foreach ($category_1['children'] as $category_2) { ?>
            <?php if ($category_2['category_id'] == $category_id) { ?>
            <option value="<?php echo $category_2['category_id']; ?>" selected="selected">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_2['name']; ?></option>
            <?php } else { ?>
            <option value="<?php echo $category_2['category_id']; ?>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_2['name']; ?></option>
            <?php } ?>
            <?php foreach ($category_2['children'] as $category_3) { ?>
            <?php if ($category_3['category_id'] == $category_id) { ?>
            <option value="<?php echo $category_3['category_id']; ?>" selected="selected">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_3['name']; ?></option>
            <?php } else { ?>
            <option value="<?php echo $category_3['category_id']; ?>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_3['name']; ?></option>
            <?php } ?>
            <?php } ?>
            <?php } ?>
            <?php } ?>
          </select>
        </div>
        <div class="checkbox">
          <label class="checkbox-inline">
            <?php if ($sub_category) { ?>
            <input type="checkbox" name="sub_category" value="1" checked="checked" />
            <?php } else { ?>
            <input type="checkbox" name="sub_category" value="1" />
            <?php } ?>
            <?php echo $text_sub_category; ?></label>
        </div>

      <div class="checkbox">
        <label class="checkbox-inline">
          <?php if ($description) { ?>
          <input type="checkbox" name="description" value="1" id="description" checked="checked" />
          <?php } else { ?>
          <input type="checkbox" name="description" value="1" id="description" />
          <?php } ?>
          <?php echo $entry_description; ?></label>
      </div>

      </div>

      <div class="buttons clearfix">
          <div class="pull-right"><button id="button-search" class="btn btn-primary"><span><?php echo $button_search; ?></span></button></div>
      </div>
      <h2 class="title search-products-title"><?php echo $text_search; ?></h2>
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
      <?php endif; ?>
      </div>
      <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>
<script type="text/javascript"><!--
$('#button-search').bind('click', function() {
	url = 'index.php?route=product/search';

	var search = $('#content input[name=\'search\']').prop('value');

	if (search) {
		url += '&search=' + encodeURIComponent(search);
	}

	var category_id = $('#content select[name=\'category_id\']').prop('value');

	if (category_id > 0) {
		url += '&category_id=' + encodeURIComponent(category_id);
	}

	var sub_category = $('#content input[name=\'sub_category\']:checked').prop('value');

	if (sub_category) {
		url += '&sub_category=true';
	}

	var filter_description = $('#content input[name=\'description\']:checked').prop('value');

	if (filter_description) {
		url += '&description=true';
	}

	location = url;
});

$('#content input[name=\'search\']').bind('keydown', function(e) {
	if (e.keyCode == 13) {
		$('#button-search').trigger('click');
	}
});

$('select[name=\'category_id\']').on('change', function() {
	if (this.value == '0') {
		$('input[name=\'sub_category\']').prop('disabled', true);
	} else {
		$('input[name=\'sub_category\']').prop('disabled', false);
	}
});

$('select[name=\'category_id\']').trigger('change');
--></script>
<?php echo $footer; ?>
