<?php if ($items): ?>
  <div class="<?php echo $j3->classes($classes); ?>">
    <?php if ($title): ?>
      <h3 class="title module-title"><?php echo $title; ?></h3>
    <?php endif; ?>
    <div class="module-body">
      <?php foreach ($items as $item): ?>
        <div class="<?php echo $j3->classes($item['classes']); ?>">
          <a class="side-image" href="<?php echo $item['href']; ?>">
            <img src="https://s.gravatar.com/avatar/<?php echo $item['avatar']; ?>?s=<?php echo $imageSize; ?>" alt="<?php echo $item['subtitle']; ?>" width="<?php echo $imageSize; ?>" height="<?php echo $imageSize; ?>"/>
          </a>
          <div class="side-details">
            <a class="side-title" href="<?php echo $item['href']; ?>"><?php echo $item['title']; ?></a>
            <div class="side-subtitle">
              <span><?php echo $item['subtitle']; ?></span>
            </div>
          </div>
        </div>
      <?php endforeach; ?>
    </div>
  </div>
<?php endif; ?>
