old_article = File.read("old_article/article.txt")

# Assign new date and create post from markdown.
system("date > date/date.txt")

system("markdown article/index.md > index.html")
system("markdown article/index.md > indexes/index.txt")


article = File.readlines("article/index.md")

article_pubdate     = File.read("date/date.txt").strip
article_description = article[0] 
article_item        = File.read("indexes/index.txt").strip

# Create new article.
new_article = "
  <title>#{article_pubdate}</title>
  <description>#{article_description}</description>
  <item>#{article_item}<item>
"

open("old_article/article.txt", "w") { |f|
  f.puts new_article
  f.puts old_article
}

open("feed/rss.xml", "w") { |f|
  f.puts '<?xml version="1.0" encoding="UTF-8"?>'
  f.puts "<channel>"
  f.puts new_article
  f.puts old_article
  f.puts "</channel>"
}
