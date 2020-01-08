<style>
  @media only screen and (max-width: <?php echo $data['globalPageContentWidth']; ?>px) {
    .tab-container::before {
      display: none !important;
    }
  }

  /*No top bar not over*/
  <?php if ($data['stickyStatus'] && !$data['stickyFullHomePadding'] && !$data['topBarStatus'] && in_array($data['headerType'], array('slim', 'compact'))): ?>
  .desktop body{
    padding-top: <?php echo $data['headerCompactHeight']; ?>px
  }
  .desktop header{
    width: 100%;
    top: 0;
    position: fixed;
  }
  .desktop.popup-open header.header-compact {
    padding-right: 17px;
  }
  .desktop.popup-open.webkit header.header-compact {
    padding-right: <?php echo $data['scrollBarWidth']; ?>px;
  }
  <?php endif; ?>


  /*No top bar over*/
  <?php if ($data['stickyStatus'] && $data['stickyFullHomePadding'] && !$data['topBarStatus'] && in_array($data['headerType'], array('slim', 'compact'))): ?>
  .desktop:not(.route-common-home) body{
    padding-top: <?php echo $data['headerCompactHeight']; ?>px
  }
  .desktop header{
    width: 100%;
    top: 0;
    position: fixed;
  }
  .desktop.popup-open header.header-compact {
    padding-right: 17px;
  }
  .desktop.popup-open.webkit header.header-compact {
    padding-right: <?php echo $data['scrollBarWidth']; ?>px;
  }
  <?php endif; ?>


  /*Top bar not over*/
  <?php if ($data['stickyStatus'] && !$data['stickyFullHomePadding'] && $data['topBarStatus'] && in_array($data['headerType'], array('slim', 'compact'))): ?>
  .desktop header{
    position: -webkit-sticky;
    position: sticky;
    top: -<?php echo $data['headerTopBarHeight']; ?>px;
  }

  .popup-open .sticky-compact{
  padding-top:<?php echo $data['headerTopBarHeight'] + $data['headerCompactHeight']; ?>px;
  }
  .popup-open .sticky-compact header {
    position: fixed;
    width: calc(100% - 12px);
  }
  <?php endif; ?>

  /*Top bar over*/
  <?php if ($data['stickyStatus'] && $data['stickyFullHomePadding'] && $data['topBarStatus'] && in_array($data['headerType'], array('slim', 'compact'))): ?>
  .desktop header{
    position: -webkit-sticky;
    position: sticky;
    top: -<?php echo $data['headerTopBarHeight']; ?>px;
  }
  /*Home*/
  .desktop.route-common-home header{
    margin-bottom: -<?php echo $data['headerCompactHeight']; ?>px;
  }

  .popup-open .sticky-compact{
    padding-top:<?php echo $data['headerTopBarHeight'] + $data['headerCompactHeight']; ?>px;
  }
  .popup-open.route-common-home .sticky-compact{
  padding-top:<?php echo $data['headerTopBarHeight']; ?>px;
  }
  .popup-open .sticky-compact header {
    position: fixed;
    width: calc(100% - 12px);
  }
  <?php endif; ?>

  /*Title breadcrumbs*/
  <?php if ($data['titleBeforeBreadcrumbs'] && $data['pageTitlePosition'] == 'top'): ?>
    header{
      order:-5
    }
    .breadcrumb{
      order:0
    }
    .page-title{
      order:-1
    }
  <?php endif; ?>

  <?php if ($data['headerMiniSearchDisplay'] == 'page'): ?>
    .mini-search .tt-menu{
      padding-left:<?php echo $data['headerMiniSearchDropdownPadding']; ?>px;
      padding-right:<?php echo $data['headerMiniSearchDropdownPadding']; ?>px;
    }
  <?php endif; ?>

</style>
