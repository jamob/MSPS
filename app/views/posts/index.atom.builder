atom_feed do |feed|
  feed.title "MSPS"
  feed.updated @messages.first.created_at

  @messages.each do |post|
    feed.entry post do |entry|
      entry.title post.title
      entry.content article.content, :type => 'html'

      entry.author do |author|
        author.name post.author
      end
    end
  end
end
