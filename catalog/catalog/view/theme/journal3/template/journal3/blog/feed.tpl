<?php echo '<?xml version="1.0" encoding="UTF-8" ?>'; ?>
<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
  <channel>
    <atom:link href="<?php echo $feed_link; ?>" rel="self" type="application/rss+xml"/>
    <title><?php echo $title; ?></title>
    <link><?php echo $blog_link; ?></link>
    <description><?php echo $meta_description; ?></description>

    <?php foreach ($posts as $post): ?>
      <item>
        <title><?php echo $post['name']; ?></title>
        <author><?php echo $post['author']; ?></author>
        <pubDate><?php echo $post['date']; ?></pubDate>
        <link><?php echo $post['href']; ?></link>
        <guid><?php echo $post['href']; ?></guid>
        <description>
          <![CDATA[
          <?php if ($post['thumb']): ?>
            <p><img src="<?php echo $post['thumb']; ?>" alt="<?php echo $post['name']; ?>"/></p>
          <?php endif; ?>
          <?php echo $post['description']; ?>
          <a href="<?php echo $post['href']; ?>">Read More</a>
          ]]>
        </description>
      </item>
    <?php endforeach; ?>

  </channel>
</rss>
