class BlogPostsController < ApplicationController
  def create
    authorize! # provides {current_user}

    @errors ||= {}

    if blog_post_params = params[:blog_post]
      if validate_for_create?(blog_post_params)

        @blog_post = BlogPost.new(current_user: @current_user, **blog_post_params)

        if @blog_post.save
          CreateMailer.new(blog_post: @blog_post).send_email

        end
      else
        @errors[:title] = ["Title is invalid"]
      end
    end

    # render
  end

  private

  def validate_for_create?(params)
    params[:title].present? && params[:body].present?
  end
end
