module Migration
  module Assets
    class DownloadFilePageJob < ::Migration::Assets::ApplicationJob
      def perform(file_id)
        require 'open-uri'
        file = ::DownloadFilePage.find(file_id)
        url = paperclip_asset_url(file, 'document', file.product)
        file.document.attach(io: open(url), filename: file.document_file_name, content_type: content_type(file))
      end

      private

      def content_type(file)
        file.document.attached? ? file.document.blob.content_type : nil
      end
    end
  end
end
