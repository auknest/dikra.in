<?php if ($items): ?>
  <div class="<?php echo $j3->classes($classes); ?>">
    <?php if ($title): ?>
      <h3 class="title module-title"><?php echo $title; ?></h3>
    <?php endif; ?>
    <div class="module-body">
      <?php foreach ($items as $item): ?>
        <a href="<?php echo $item['href']; ?>" class="<?php echo $j3->classes($item['classes']); ?>"><span><?php echo $item['name']; ?></span></a>
      <?php endforeach; ?>
    </div>
  </div>
<?php endif; ?>
