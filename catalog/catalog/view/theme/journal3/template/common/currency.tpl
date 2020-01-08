<?php if ($j3->settings->get('catalogCurrencyStatus')): ?>
<?php if (count($currencies) > 1) { ?>
  <?php
  $current_currency = null;
  foreach ($currencies as $currency) {
    if ($currency['code'] == $code) {
      $current_currency = $currency;
    }
  }
  ?>
  <div id="currency" class="currency">
    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-currency">
      <div class="dropdown drop-menu">
        <button type="button" class="dropdown-toggle" data-toggle="dropdown">
          <span class="currency-symbol-title">
            <?php if ($current_currency['symbol_left']): ?>
              <span class="symbol"><?php echo $current_currency['symbol_left']; ?></span>
              <span class="currency-title"><?php echo $current_currency['title']; ?></span>
              <span class="currency-code"><?php echo $current_currency['code']; ?></span>
            <?php else: ?>
              <span class="symbol"><?php echo $current_currency['symbol_right']; ?></span>
              <span class="currency-title"><?php echo $current_currency['title']; ?></span>
              <span class="currency-code"><?php echo $current_currency['code']; ?></span>
            <?php endif; ?>
          </span>
        </button>
        <div class="dropdown-menu j-dropdown">
          <ul class="j-menu">
            <?php foreach ($currencies as $currency): ?>
              <?php if ($currency['symbol_left']): ?>
                <li>
                  <a class="currency-select" data-name="<?php echo $currency['code']; ?>">
                    <span class="currency-symbol"><?php echo $currency['symbol_left']; ?></span>
                    <span class="currency-title-dropdown"><?php echo $currency['title']; ?></span>
                    <span class="currency-code-dropdown"><?php echo $currency['code']; ?></span>
                  </a>
                </li>
              <?php else: ?>
                <li>
                  <a class="currency-select" data-name="<?php echo $currency['code']; ?>">
                    <span class="currency-symbol"><?php echo $currency['symbol_right']; ?></span>
                    <span class="currency-title-dropdown"><?php echo $currency['title']; ?></span>
                    <span class="currency-code-dropdown"><?php echo $currency['code']; ?></span>
                  </a>
                </li>
              <?php endif; ?>
            <?php endforeach; ?>
          </ul>
        </div>
      </div>
      <input type="hidden" name="code" value=""/>
      <input type="hidden" name="redirect" value="<?php echo $redirect; ?>"/>
    </form>
  </div>
<?php } ?>
<?php endif; ?>
