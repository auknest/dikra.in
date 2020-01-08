<?php if (!function_exists('renderSearchCategories')):
  function renderSearchCategories($j3, $categories, $category_id, $index) {
    foreach ($categories as $category): $classes = array('selected' => $category['category_id'] == $category_id); ?>
      <li data-category_id="<?php echo $category['category_id']; ?>" class="<?php echo $j3->classes($classes); ?> category-level-<?php echo $index; ?>"><a><?php echo $category['title']; ?></a></li>
      <?php renderSearchCategories($j3, $category['items'], $category_id, $index + 1); ?>
    <?php endforeach;
  }
endif; ?>
<?php if ($j3->settings->get('catalogSearchStatus')): ?>
<div id="search" class="dropdown">
  <button class="dropdown-toggle search-trigger" data-toggle="dropdown"></button>
  <div class="dropdown-menu j-dropdown">
    <div class="header-search">
      <?php if ($j3->settings->get('searchStyleSearchCategoriesSelectorStatus') && isset($categories)): ?>
        <div class="search-categories dropdown drop-menu">
          <div class="search-categories-button dropdown-toggle" data-toggle="dropdown"><?php echo $category_id ? $category : $j3->settings->get('searchStyleSearchCategories'); ?></div>

          <div class="dropdown-menu j-dropdown">
            <ul class="j-menu">
              <li data-category_id="0" class="category-level-1"><a><?php echo $j3->settings->get('searchStyleSearchCategories'); ?></a></li>
              <?php renderSearchCategories($j3, $categories, $category_id, 1); ?>
            </ul>
          </div>
        </div>
      <?php endif; ?>
      <input type="text" name="search" value="<?php echo $search; ?>" placeholder="<?php echo $j3->settings->get('searchStyleSearchPlaceholder'); ?>" class="search-input" <?php if (isset($category_id)): ?>data-category_id="<?php echo $category_id; ?>"<?php endif; ?>/>
      <button type="button" class="search-button" data-search-url="<?php echo $search_url; ?>"></button>
    </div>
  </div>
</div>
<?php endif; ?>
