<div class="<?php echo $j3->classes($classes); ?>">
  <?php if ($title): ?>
    <h3 class="title module-title"><?php echo $title; ?></h3>
  <?php endif; ?>
  <div class="module-body">
    <div class="tags">
      <?php foreach ($items as $item): ?>
        <a href="<?php echo $item['href']; ?>"><?php echo $item['name']; ?></a><b>,</b>
      <?php endforeach; ?>
    </div>
  </div>
</div>
