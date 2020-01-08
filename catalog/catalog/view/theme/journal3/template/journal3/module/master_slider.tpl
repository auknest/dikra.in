<div class="<?php echo $j3->classes($classes); ?>" style="background-image:url('<?php echo $first_image; ?>')">
  <?php if (isset($staticText)): ?>
    <?php if ($staticText && $staticTextLink['href']): ?>
      <a href="<?php echo $staticTextLink['href']; ?>" class="slider-static-text static-text-1"><span><?php echo $staticText; ?></span></a>
    <?php elseif ($staticText) : ?>
      <div class="slider-static-text static-text-1"><span><?php echo $staticText; ?></span></div>
    <?php endif; ?>
  <?php endif; ?>
  <?php if (isset($static2Text)): ?>
    <?php if ($static2Text && $static2TextLink['href']): ?>
      <a href="<?php echo $static2TextLink['href']; ?>" class="slider-static-text static-text-2"><span><?php echo $static2Text; ?></span></a>
    <?php elseif ($static2Text) : ?>
      <div class="slider-static-text static-text-2"><span><?php echo $static2Text; ?></span></div>
    <?php endif; ?>
  <?php endif; ?>
  <img src="<?php echo $first_image; ?>" <?php if (isset($first_image2x) && $first_image2x): ?> srcset="<?php echo $first_image; ?> 1x, <?php echo $first_image2x; ?> 2x"<?php endif; ?> alt="<?php echo $first_alt; ?>">
  <?php /*<img src="<?php echo $first_image; ?>" alt="<?php echo $first_alt; ?>" class="img-2">*/ ?>
  <div class="master-slider ms-skin-minimal" data-options='<?php echo json_encode($options, JSON_FORCE_OBJECT); ?>' <?php if ($parallaxMode): ?>data-parallax="<?php echo $parallax; ?>"<?php endif; ?>>
    <?php foreach ($items as $item): ?>
      <div class="<?php echo $j3->classes($item['classes']); ?>" <?php if ($item['delay']): ?>data-delay="<?php echo $item['delay']; ?>"<?php endif; ?>>
        <img src="<?php echo $item['image']; ?>" <?php if (isset($item['image2x']) && $item['image2x']): ?> srcset="<?php echo $item['image']; ?> 1x, <?php echo $item['image2x']; ?> 2x"<?php endif; ?> alt="<?php echo $item['alt']; ?>" width="<?php echo $options['width']; ?>" height="<?php echo $options['height']; ?>"/>

        <?php if ($thumbnails && $item['thumb']): ?>
          <img src="<?php echo $item['thumb']; ?>" <?php if (isset($item['thumb2x']) && $item['thumb2x']): ?> srcset="<?php echo $item['thumb']; ?> 1x, <?php echo $item['thumb2x']; ?> 2x"<?php endif; ?> alt="<?php echo $item['alt']; ?>" class="ms-thumb"/>
        <?php endif; ?>

        <?php if ($item['link']['href']): ?>
          <a href="<?php echo $item['link']['href']; ?>" <?php echo $j3->linkAttrs($item['link']); ?>></a>
        <?php endif; ?>

        <?php if ($item['type'] == 'video'): ?>
          <?php if ($item['videoType'] == 'html5'): ?>
            <video data-autopause="true" <?php if ($j3->document->hasClass('ios')): ?>playsinline<?php endif; ?>>
              <?php foreach ($item['videoSrc'] as $type => $src): ?>
                <source src="<?php echo $src; ?>" type="video/<?php echo $type; ?>"/>
              <?php endforeach; ?>
            </video>
          <?php elseif ($item['videoType'] == 'youtube'): ?>
            <a href="https://www.youtube.com/embed/<?php echo $item['videoSrc']; ?>?hd=1&wmode=opaque&controls=1&showinfo=0&autoplay=1" data-type="video"></a>
          <?php elseif ($item['videoType'] == 'vimeo'): ?>
            <a href="https://player.vimeo.com/video/<?php echo $item['videoSrc']; ?>" data-type="video"></a>
          <?php endif; ?>
        <?php endif; ?>

        <?php foreach ($item['items'] as $subitem): ?>
          <?php if ($subitem['type'] == 'text'): ?>
            <div class="<?php echo $j3->classes($subitem['classes']); ?>" <?php echo implode(' ', $subitem['data']); ?>><?php echo $subitem['text']; ?></div>
          <?php elseif ($subitem['type'] == 'hotspot'): ?>
            <div class="<?php echo $j3->classes($subitem['classes']); ?>" <?php echo implode(' ', $subitem['data']); ?>>
              <div class="product-tt"><?php echo $subitem['text']; ?></div>
            </div>
          <?php elseif ($subitem['type'] == 'shape'): ?>
            <img class="<?php echo $j3->classes($subitem['classes']); ?>" <?php echo implode(' ', $subitem['data']); ?> src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" data-src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" alt="<?php echo $subitem['alt']; ?>"/>
          <?php elseif ($subitem['type'] == 'button'): ?>
            <a class="<?php echo $j3->classes($subitem['classes']); ?>" <?php echo implode(' ', $subitem['data']); ?> <?php if ($subitem['link']['href']): ?>href="<?php echo $subitem['link']['href']; ?>" <?php echo $j3->linkAttrs($subitem['link']); ?><?php endif; ?>><span><?php echo $subitem['text']; ?></span></a>
          <?php elseif ($subitem['type'] == 'image'): ?>
            <img class="<?php echo $j3->classes($subitem['classes']); ?>" <?php echo implode(' ', $subitem['data']); ?> src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" data-src="<?php echo $subitem['image']; ?>" alt="<?php echo $subitem['alt']; ?>"/>
          <?php elseif ($subitem['type'] == 'video'): ?>
            <div class="<?php echo $j3->classes($subitem['classes']); ?>" <?php echo implode(' ', $subitem['data']); ?>>
              <?php if ($subitem['videoType'] == 'html5'): ?>
                <video controls>
                  <?php foreach ($subitem['videoSrc'] as $type => $src): ?>
                    <source src="<?php echo $src; ?>" type="video/<?php echo $type; ?>"/>
                  <?php endforeach; ?>
                </video>
              <?php elseif ($subitem['videoType'] == 'youtube'): ?>
                <iframe src="https://www.youtube.com/embed/<?php echo $subitem['videoSrc']; ?>?hd=1&wmode=opaque&controls=1&showinfo=0"></iframe>
              <?php elseif ($subitem['videoType'] == 'vimeo'): ?>
                <iframe src="https://player.vimeo.com/video/<?php echo $subitem['videoSrc']; ?>"></iframe>
              <?php endif; ?>
            </div>
          <?php endif; ?>
        <?php endforeach; ?>
      </div>
    <?php endforeach; ?>
  </div>
</div>
