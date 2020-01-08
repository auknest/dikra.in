<div class="<?php echo $j3->classes($classes); ?>" data-url="<?php echo $url; ?>">
  <?php if ($title): ?>
    <h3 class="title module-title"><?php echo $title; ?></h3>
  <?php endif; ?>
  <div class="module-body">
    <div class="box-search">
      <input type="text" class="form-control blog-search" value="<?php echo $search; ?>" placeholder="<?php echo $placeholder; ?>"/>
      <button class="btn search-btn">
        <i class="fa fa-search"></i>
      </button>
    </div>
  </div>
</div>
