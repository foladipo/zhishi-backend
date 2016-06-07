RSpec.shared_context :comment_resource_helpers do
  def new_comment_path
    comments_path(subject.zhishi_url_options)
  end

  def existing_comment_path
    comment_path(subject.zhishi_url_options)
  end
end
