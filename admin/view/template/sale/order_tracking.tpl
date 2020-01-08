<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <a onclick="window.location.reload();" data-toggle="tooltip" title="Refresh" class="btn btn-primary"><i class="fa fa-refresh"></i></a>
            </div>
            <h1><?php echo $heading_title; ?></h1>
            <ul class="breadcrumb">
                <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
                <?php } ?>
            </ul>
        </div>
    </div>
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-6">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title"><i class="fa fa-shopping-cart"></i> ORDER TRACKING</h3>
                    </div>
                    <table class="table">
                        <tbody>
                            <tr>
                                <th>Order No</th>
                                <td>#<?php echo $order_id; ?></td>
                            </tr>
                            <tr>
                                <th>DTDC Order No</th>
                                <td><?php echo $response->DOCKNO ?></td>
                            </tr>
                            <tr>
                                <th>Current Status</th>
                                <th><u><?php echo $response->CURRENT_STATUS ?></u></th>
                            </tr>
                            <tr>
                                <th>Current City</th>
                                <td><?php echo $response->CURRENT_CITY ?></td>
                            </tr>
                            <tr>
                                <th>Next City</th>
                                <td><?php echo $response->NEXT_LOCATION ?></td>
                            </tr>

                        </tbody>
                    </table>
                </div>
            </div>
            <div class="col-md-6">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title"><i class="fa fa-user"></i> <?php echo $text_customer_detail; ?></h3>
                    </div>
                    <table class="table">
                        <tr>
                            <th><?php echo $text_customer; ?></th>
                            <td><?php echo $response->RECIEVER_NAME ?></td>
                        </tr>

                        <tr>
                            <th><?php echo $text_telephone; ?></th>
                            <td><?php echo $response->CONTACT_NO ?></td>
                        </tr>
                        <tr>
                            <th><?php echo $text_shipping_address ?></th>
                            <td><?php echo $shipping_address?></td>
                        </tr>
                    </table>
                </div>
            </div>

        </div>
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="fa fa-comment-o"></i> <?php echo $text_history; ?></h3>
            </div>
            <div class="panel-body">
                <ul class="nav nav-tabs">
                    <li class="active"><a href="#tab-history" data-toggle="tab"><?php echo $tab_history; ?></a></li>

                </ul>
                <div id="history">
                    <div class="table-responsive">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <td class="text-left"><?php echo "Date & time"?></td>
                                    <td class="text-left"><?php echo $column_status; ?></td>
                                    <td class="text-left"><?php echo $column_comment; ?></td>
                                    <td class="text-left">Current City</td>
                                    <td class="text-left">Next Location</td>
                                </tr>
                            </thead>
                            <tbody>
                                <?php if ($response->Detail) { ?>
                                <?php foreach ($response->Detail as $history) { ?>
                                <tr>
                                    <td class="text-left"><?php echo $history->EVENTDATE." ".$history->EVENTTIME; ?></td>
                                    <td class="text-left"><?php echo $history->CURRENT_STATUS; ?></td>
                                    <td class="text-left"><?php echo isset($history->NDR_REASON)?$history->NDR_REASON:''; ?></td>
                                    <td class="text-left"><?php echo $history->CURRENT_CITY; ?></td>
                                    <td class="text-left"><?php echo $history->NEXT_LOCATION; ?></td>
                                </tr>
                                <?php } ?>
                                <?php } else { ?>
                                <tr>
                                    <td class="text-center" colspan="4"><?php echo $text_no_results; ?></td>
                                </tr>
                                <?php } ?>
                            </tbody>
                        </table>
                    </div>
                </div>

            </div>

        </div>
    </div>
</div>
<?php echo $footer; ?> 
