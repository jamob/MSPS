atom_feed language: 'en-US' do |feed|
  feed.title "MSPS"
  feed.updated(@posts.first.created_at) if @posts.length > 0

  @posts.each do |post|
    feed.entry post, published: post.created_at do |entry|
      entry.title post.title
      entry.content( post.content, type: 'html')

      entry.author do |author|
        author.name post.author
      end
    end
  end
end
