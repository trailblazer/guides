module BlogPost::Operation
  class Notify < Trailblazer::Operation
    step :send_email
    step :create_notification

    def send_email(ctx, blog_post:, **)
      CreateMailer.new(blog_post: blog_post).send_email
    end

    def create_notification(ctx, blog_post:, current_user:, **)
      ctx[:notification] = Notification.create(
        category:  :blog_post_created,
        record_id: blog_post.id,
        user_id:   current_user.id
      )
    end
  end
end
