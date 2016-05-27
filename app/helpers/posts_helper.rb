module PostsHelper

  def liked_post(post)
    if current_user.voted_for? post
      'glyphicon-heart'
    else
      'glyphicon-heart-empty'
    end
  end

  def post_like_link(post)
    if current_user.voted_for? post
      unlike_post_path(post.id)
    else
      like_post_path(post.id)
    end
  end

  def display_likes(post)
    votes = post.votes_for.up.by_type(User)
    return list_likers(votes) if votes.size <= 8
    count_likers(votes)
  end

  private

  def list_likers(votes)
    user_names = []
    unless votes.blank?
      votes.voters.each do |voter|
        user_names.push(link_to voter.user_name, profile_path(voter.user_name), class: 'user-name')
      end
      user_names.to_sentence.html_safe + like_plural(votes)
    end
  end

  def count_likers(votes)
    votes.size.to_s + ' likes'
  end

  def like_plural(votes)
    return ' like this' if votes.count > 1
    ' likes this'
  end


end
