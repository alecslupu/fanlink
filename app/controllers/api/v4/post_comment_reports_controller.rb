# frozen_string_literal: true

class Api::V4::PostCommentReportsController < Api::V3::PostCommentReportsController
  def index
    @post_comment_reports = paginate apply_filters
    return_the @post_comment_reports, handler: tpl_handler
  end

  protected

    def tpl_handler
      'jb'
    end
end
