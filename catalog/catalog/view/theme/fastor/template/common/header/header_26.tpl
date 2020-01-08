<?php if($theme_options->get( 'fixed_header' ) == 1) { ?>
<!-- HEADER
	================================================== -->
<div class="fixed-header-1 sticky-header">
	<div class="background-header"></div>
	<div class="slider-header">
		<!-- Top of pages -->
		<div id="top" class="<?php if($theme_options->get( 'header_layout' ) == 1) { echo 'full-width'; } elseif($theme_options->get( 'header_layout' ) == 4) { echo 'fixed3 fixed2'; } elseif($theme_options->get( 'header_layout' ) == 3) { echo 'fixed2';  } else { echo 'fixed'; } ?>">
			<div class="background-top"></div>
			<div class="background">
				<div class="shadow"></div>
				<div class="pattern">
					<?php if($theme_options->get( 'megamenu_type' ) == 4 || $theme_options->get( 'megamenu_type' ) == 5 || $theme_options->get( 'megamenu_type' ) == 6 || $theme_options->get( 'megamenu_type' ) == 9 || $theme_options->get( 'megamenu_type' ) == 14 || $theme_options->get( 'megamenu_type' ) == 19 || $theme_options->get( 'megamenu_type' ) == 29) { ?>
					<div class="container container-megamenu2">
					<?php } ?>
					<?php 
					$menu = $modules_old_opencart->getModules('menu');
					if( count($menu) ) { ?>
					     <div class="megamenu-background">
					          <div class="">
					               <div class="overflow-megamenu container">
               						<?php 
               						if(count($menu) > 1) echo '<div class="row mega-menu-modules">';
               						$i = 0;
               						    
               						foreach ($menu as $module) {
               						     if($i == 0 && count($menu) > 1) echo '<div class="col-md-3">';
               						     if($i == 1 && count($menu) > 1) echo '<div class="col-md-9">';
               							     echo $module;
               							if(count($menu) > 1 && ($i == 0 || $i == 1)) echo '</div>';
               							if(count($menu) > 1 && $i == 1) echo '</div>';
               							$i++;
               						} ?>
               					</div>
               				</div>
               			</div>
					<?php } elseif($categories) { ?>
					<div class="megamenu-background">
					     <div class="">
					          <div class="overflow-megamenu container">
               					<div class="container-megamenu horizontal">
               						<div class="megaMenuToggle">
               							<div class="megamenuToogle-wrapper">
               								<div class="megamenuToogle-pattern">
               									<div class="container">
               										<div><span></span><span></span><span></span></div>
               										Navigation
               									</div>
               								</div>
               							</div>
               						</div>
               						
               						<div class="megamenu-wrapper">
               							<div class="megamenu-pattern">
               								<div class="container">
               									<ul class="megamenu shift-up">
               										<?php foreach ($categories as $category) { ?>
               										<?php if ($category['children']) { ?>
               										<li class="with-sub-menu hover"><p class="close-menu"></p><p class="open-menu"></p>
               											<a href="<?php echo $category['href'];?>"><span><strong><?php echo $category['name']; ?></strong></span></a>
               										<?php } else { ?>
               										<li>
               											<a href="<?php echo $category['href']; ?>"><span><strong><?php echo $category['name']; ?></strong></span></a>
               										<?php } ?>
               											<?php if ($category['children']) { ?>
               											<?php 
               												$width = '100%';
               												$row_fluid = 3;
               												if($category['column'] == 1) { $width = '220px'; $row_fluid = 12; }
               												if($category['column'] == 2) { $width = '500px'; $row_fluid = 6; }
               												if($category['column'] == 3) { $width = '700px'; $row_fluid = 4; }
               											?>
               											<div class="sub-menu" style="width: <?php echo $width; ?>">
               												<div class="content">
               													<p class="arrow"></p>
               													<div class="row hover-menu">
               														<?php for ($i = 0; $i < count($category['children']);) { ?>
               														<div class="col-sm-<?php echo $row_fluid; ?> mobile-enabled">
               															<div class="menu">
               																<ul>
               																  <?php $j = $i + ceil(count($category['children']) / $category['column']); ?>
               																  <?php for (; $i < $j; $i++) { ?>
               																  <?php if (isset($category['children'][$i])) { ?>
               																  <li><a href="<?php echo $category['children'][$i]['href']; ?>" class="main-menu"><?php echo $category['children'][$i]['name']; ?></a></li>
               																  <?php } ?>
               																  <?php } ?>
               																</ul>
               															</div>
               														</div>
               														<?php } ?>
               													</div>
               												</div>
               											</div>
               											<?php } ?>
               										</li>
               										<?php } ?>
               									</ul>
               								</div>
               							</div>
               						</div>
               					</div>
          					</div>
     					</div>
					</div>
					<?php
					}
					?>
					<?php if($theme_options->get( 'megamenu_type' ) == 4 || $theme_options->get( 'megamenu_type' ) == 5 || $theme_options->get( 'megamenu_type' ) == 6 || $theme_options->get( 'megamenu_type' ) == 9 || $theme_options->get( 'megamenu_type' ) == 14 || $theme_options->get( 'megamenu_type' ) == 19 || $theme_options->get( 'megamenu_type' ) == 29) { ?>
					</div>
					<?php } ?>
					
					<?php 
					$menu2 = $modules_old_opencart->getModules('menu2');
					if( count($menu2) ) { 
					     echo '<div class="overflow-menu2">';
						foreach ($menu2 as $module) {
							echo $module;
						}
						echo '</div>';
					} ?>
				</div>
			</div>
		</div>
	</div>
</div>
<?php } ?>

<!-- HEADER
	================================================== -->
<header class="header-type-26">
	<div class="background-header"></div>
	<div class="slider-header">
		<!-- Top of pages -->
		<div id="top" class="<?php if($theme_options->get( 'header_layout' ) == 1) { echo 'full-width'; } elseif($theme_options->get( 'header_layout' ) == 4) { echo 'fixed3 fixed2'; } elseif($theme_options->get( 'header_layout' ) == 3) { echo 'fixed2';  } else { echo 'fixed'; } ?>">
			<div class="background-top"></div>
			<div class="background">
				<div class="shadow"></div>
				<div class="pattern">
					<div class="container">
						<div class="row">
							<!-- Header Left -->
							<div class="col-sm-4" id="header-left">
							     <?php 
							     $top_block = $modules_old_opencart->getModules('top_block');
							     if( count($top_block) ) { 
							     	foreach ($top_block as $module) {
							     		echo $module;
							     	}
							     } ?>
							     
                                        <ul class="menu">
                                             <?php if ($logged) { ?>
                                             <li><a href="<?php echo $wishlist; ?>" id="wishlist-total" title="<?php echo $text_wishlist; ?>"><?php echo $text_wishlist; ?></a></li>
                                             <li><a href="<?php echo $logout; ?>"><?php echo $text_logout; ?></a></li>
                                             <?php } else { ?>
                                             <li><a href="<?php echo $register; ?>"><?php echo $text_register; ?></a></li>
                                             <li><a href="<?php echo $login; ?>"><?php echo $text_login; ?></a></li>
                                             <li><a href="<?php echo $wishlist; ?>" id="wishlist-total" title="<?php echo $text_wishlist; ?>"><?php echo $text_wishlist; ?></a></li>
                                             <?php } ?>
                                        </ul>
							</div>
							
							<!-- Header Center -->
							<div class="col-sm-4" id="header-center">		
							     <?php if ($logo) { ?>
							     <!-- Logo -->
							     <div class="logo"><a href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" /></a></div>
							     <?php } ?>
							</div>
							
							<!-- Header Right -->
							<div class="col-sm-4 text-right" id="header-right">
							     <div class="overflow-currency-cart">
     								<?php echo $currency.$language; ?>
     								<?php echo $cart; ?>
								</div>
								
								<ul class="menu">
								     <li><a href="<?php echo $shopping_cart; ?>" title="<?php echo $text_shopping_cart; ?>"><?php echo $text_shopping_cart; ?></a></li>
								     <li><a href="<?php echo $checkout; ?>" title="<?php echo $text_checkout; ?>"><?php echo $text_checkout; ?></a></li>
								</ul>
							</div>
						</div>
					</div>
					
					<?php if($theme_options->get( 'megamenu_type' ) == 4 || $theme_options->get( 'megamenu_type' ) == 5 || $theme_options->get( 'megamenu_type' ) == 6 || $theme_options->get( 'megamenu_type' ) == 9 || $theme_options->get( 'megamenu_type' ) == 14 || $theme_options->get( 'megamenu_type' ) == 19 || $theme_options->get( 'megamenu_type' ) == 29) { ?>
					<div class="container container-megamenu2">
					<?php } ?>
					<?php 
					$menu = $modules_old_opencart->getModules('menu');
					if( count($menu) ) { ?>
					     <div class="megamenu-background">
					          <div class="">
					               <div class="overflow-megamenu container">
               						<?php 
               						if(count($menu) > 1) echo '<div class="row mega-menu-modules">';
               						$i = 0;
               						    
               						foreach ($menu as $module) {
               						     if($i == 0 && count($menu) > 1) echo '<div class="col-md-3">';
               						     if($i == 1 && count($menu) > 1) echo '<div class="col-md-9">';
               							     echo $module;
               							if(count($menu) > 1 && ($i == 0 || $i == 1)) echo '</div>';
               							if(count($menu) > 1 && $i == 1) echo '</div>';
               							$i++;
               						} ?>
               					</div>
               				</div>
               			</div>
					<?php } elseif($categories) { ?>
					<div class="megamenu-background">
					     <div class="">
					          <div class="overflow-megamenu container">
               					<div class="container-megamenu horizontal">
               						<div class="megaMenuToggle">
               							<div class="megamenuToogle-wrapper">
               								<div class="megamenuToogle-pattern">
               									<div class="container">
               										<div><span></span><span></span><span></span></div>
               										Navigation
               									</div>
               								</div>
               							</div>
               						</div>
               						
               						<div class="megamenu-wrapper">
               							<div class="megamenu-pattern">
               								<div class="container">
               									<ul class="megamenu shift-up">
               										<?php foreach ($categories as $category) { ?>
               										<?php if ($category['children']) { ?>
               										<li class="with-sub-menu hover"><p class="close-menu"></p><p class="open-menu"></p>
               											<a href="<?php echo $category['href'];?>"><span><strong><?php echo $category['name']; ?></strong></span></a>
               										<?php } else { ?>
               										<li>
               											<a href="<?php echo $category['href']; ?>"><span><strong><?php echo $category['name']; ?></strong></span></a>
               										<?php } ?>
               											<?php if ($category['children']) { ?>
               											<?php 
               												$width = '100%';
               												$row_fluid = 3;
               												if($category['column'] == 1) { $width = '220px'; $row_fluid = 12; }
               												if($category['column'] == 2) { $width = '500px'; $row_fluid = 6; }
               												if($category['column'] == 3) { $width = '700px'; $row_fluid = 4; }
               											?>
               											<div class="sub-menu" style="width: <?php echo $width; ?>">
               												<div class="content">
               													<p class="arrow"></p>
               													<div class="row hover-menu">
               														<?php for ($i = 0; $i < count($category['children']);) { ?>
               														<div class="col-sm-<?php echo $row_fluid; ?> mobile-enabled">
               															<div class="menu">
               																<ul>
               																  <?php $j = $i + ceil(count($category['children']) / $category['column']); ?>
               																  <?php for (; $i < $j; $i++) { ?>
               																  <?php if (isset($category['children'][$i])) { ?>
               																  <li><a href="<?php echo $category['children'][$i]['href']; ?>" class="main-menu"><?php echo $category['children'][$i]['name']; ?></a></li>
               																  <?php } ?>
               																  <?php } ?>
               																</ul>
               															</div>
               														</div>
               														<?php } ?>
               													</div>
               												</div>
               											</div>
               											<?php } ?>
               										</li>
               										<?php } ?>
               									</ul>
               								</div>
               							</div>
               						</div>
               					</div>
          					</div>
     					</div>
					</div>
					<?php
					}
					?>
					<?php if($theme_options->get( 'megamenu_type' ) == 4 || $theme_options->get( 'megamenu_type' ) == 5 || $theme_options->get( 'megamenu_type' ) == 6 || $theme_options->get( 'megamenu_type' ) == 9 || $theme_options->get( 'megamenu_type' ) == 14 || $theme_options->get( 'megamenu_type' ) == 19 || $theme_options->get( 'megamenu_type' ) == 29) { ?>
					</div>
					<?php } ?>
					
					<?php 
					$menu2 = $modules_old_opencart->getModules('menu2');
					if( count($menu2) ) { 
					     echo '<div class="overflow-menu2">';
						foreach ($menu2 as $module) {
							echo $module;
						}
						echo '</div>';
					} ?>
				</div>
			</div>
		</div>
	</div>
	
	<?php $slideshow = $modules_old_opencart->getModules('slideshow'); ?>
	<?php  if(count($slideshow)) { ?>
	<!-- Slider -->
	<div id="slider" class="<?php if($theme_options->get( 'slideshow_layout' ) == 1) { echo 'full-width'; } elseif($theme_options->get( 'slideshow_layout' ) == 4) { echo 'fixed3 fixed2'; } elseif($theme_options->get( 'slideshow_layout' ) == 3) { echo 'fixed2'; } else { echo 'fixed'; } ?>">
		<div class="background-slider"></div>
		<div class="background">
			<div class="shadow"></div>
			<div class="pattern">
				<?php foreach($slideshow as $module) { ?>
				<?php echo $module; ?>
				<?php } ?>
			</div>
		</div>
	</div>
	<?php } ?>
</header>