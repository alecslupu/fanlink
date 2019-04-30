module Admin
  class PostReportsController < Admin::ApplicationController
    include Messaging

    def index
      # search_term = params[:search].to_s.strip
      resources = PostReport.for_product(ActsAsTenant.current_tenant).page(params[:page]).per(records_per_page)
      page = Administrate::Page::Collection.new(dashboard, order: order)
      render locals: {
          resources: resources,
          # search_term: search_term,
          page: page,
          show_search_bar: false
      }
    end

    def update
      post_report = PostReport.find(params["id"])
      post_report.status = params["post_report"]["status"]
      post = post_report.post
      errored = false
      if post_report.status == "post_hidden"
        post.status = :deleted
        if post.save && delete_post(post, post.person.followers)
          post_report.save
        else
          errored = true
        end
      else
        post.status = :published
        if !post.save
          errored = true
        end
      end
      if errored
        render status: :unprocessable_entity, json: { error: "Unable to update the post. Please try again later." }
      else
        render status: :ok, json: { message: (post.deleted?) ? "Post hidden" : "Post remains" }
      end
    end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   PostReport.find_by!(slug: param)
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information
  end
end
