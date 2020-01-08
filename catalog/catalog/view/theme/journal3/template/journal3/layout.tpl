<?php if ($rows): ?>
  <div class="<?php echo $j3->classes($grid_classes); ?>">
    <?php foreach ($rows as $grid_row): ?>
      <div class="<?php echo $j3->classes($grid_row['classes']); ?>">
        <?php if (isset($grid_row['waveStatus']) && $grid_row['waveStatus']): ?>
        <svg viewBox="0 0 100 20" class="wave wave-top" preserveAspectRatio="none">
          <path fill="white" d="M 0 30 V 10 Q 25 <?php echo $grid_row['waveDirection']; ?> 55 10 T 100 10 V 30 Z"></path>
        </svg>
        <?php endif; ?>
        <div class="grid-cols">
          <?php foreach ($grid_row['columns'] as $grid_column): ?>
            <div class="<?php echo $j3->classes($grid_column['classes']); ?>">
              <div class="grid-items">
                <?php foreach ($grid_column['items'] as $grid_item): ?>
                  <div class="<?php echo $j3->classes($grid_item['classes']); ?>">
                    <?php echo $grid_item['item']; ?>
                  </div>
                <?php endforeach; ?>
              </div>
            </div>
          <?php endforeach; ?>
        </div>
        <?php if (isset($grid_row['wave2Status']) && $grid_row['wave2Status']): ?>
        <svg viewBox="0 0 100 20" class="wave wave-bottom" preserveAspectRatio="none">
          <path fill="white" d="M 0 30 V 10 Q 25 <?php echo $grid_row['wave2Direction']; ?> 55 10 T 100 10 V 30 Z"></path>
        </svg>
        <?php endif; ?>
        <?php if (isset($grid_row['videoBgStatus']) && $grid_row['videoBgStatus'] && (isset($grid_row['videoBg']) && $grid_row['videoBg'])): ?>
          <div class="video-row">
            <video class="video-bg" loop muted <?php if ($j3->document->hasClass('desktop')): ?>autoplay<?php endif; ?> <?php if ($grid_row['videoInline'] && $j3->document->hasClass('android')): ?>autoplay<?php endif; ?> <?php if ($grid_row['videoInline'] && $j3->document->hasClass('ios')): ?>playsinline<?php endif; ?> data-src="<?php echo $grid_row['videoBg']; ?>"></video>
          </div>
        <?php endif; ?>
      </div>
    <?php endforeach; ?>
  </div>
<?php endif; ?>
